using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyProject
{
    public partial class ManageHirings : System.Web.UI.Page
    {
        readonly string connection_string = ConfigurationManager.ConnectionStrings["db_connectionstring"].ConnectionString;
        string user_db_connection_string = ConfigurationManager.ConnectionStrings["user_db_connectionstring"].ConnectionString;
        
        public string ImagePath { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ImgUpload_Click(object sender, EventArgs e)
        {
            string filename = Path.GetFileName(VImg.PostedFile.FileName);
            string ext = Path.GetExtension(filename);
            int ss = filename.Length;
            int si = VImg.PostedFile.ContentLength;
            string Imagename = GetImageName();
            if (si > 1500000)
            {
                return;
            }
            VImg.SaveAs(Server.MapPath("images/" + Imagename + ext));
            //string filePath = Server.MapPath("~/images/" + Imagename + ext);
            V_img.Src = ResolveUrl(String.Format(@"~/images/{0}", Imagename + ext));
            //File.Delete(filePath);
            this.ImagePath = "images/"+Imagename + ext;
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:MngVehicleModal(); ", true);
        }
        public string GetImageName()
        {
            string ImageName="";
            int ImageId = 0;
            SqlConnection con = new SqlConnection(connection_string);
            HttpCookie cookie = Request.Cookies["erptk"];
            string UserID = getLoggedUser(cookie.Value);
            string sql = "select COUNT(*) as cnt from Vehical where UserId=@UserId";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserId", UserID);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                ImageId = Convert.ToInt32(rdr["cnt"])+1;
            }
            con.Close();
            ImageName = UserID + "_" + ImageId;
            return ImageName;
        }
        public string getLoggedUser(string token)
        {
            string retutn_val = "";
            SqlConnection con = new SqlConnection(user_db_connection_string);
            string sql = "select user_id from Token where token=@token";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@token", token);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                rdr.Read();
                retutn_val = rdr["user_id"].ToString();
            }
            con.Close();
            return retutn_val;
        }
    }
}