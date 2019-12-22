using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class Hirings
    {
        public string UserID { get; set; }
        public string HireID { get; set; }  //Sa
        public string Brand { get; set; }
        public string Model { get; set; }
        public Boolean IsAC { get; set; }
        public int NoOfSeats { get; set; }
        public string OtherOptions { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string TelNo1 { get; set; }
        public string TelNo2 { get; set; }
        public string VehicleId { get; set; }
        public double Rate { get; set; }
        public Boolean WithDriver { get; set; }
        public Boolean WithoutDriver { get; set; }
        public Boolean IsAvailable { get; set; }
        public string Location { get; set; }
        public string Status { get; set; }
        public string Token { get; set; }
        readonly string connection_string = ConfigurationManager.ConnectionStrings["db_connectionstring"].ConnectionString;

        public List<Hirings> GetHirings()
        {
            UserAccess ua = new UserAccess();
            string sqlPart = "";
            SqlCommand cmd = new SqlCommand();
            if (this.Token==null || this.Token == "")
            {
                sqlPart = " where Status='ONLINE' ";
            }
            else if (ua.validateFunctions(this.Token, "ALL_HIRES"))
            {
                sqlPart = "";
            }
            else if (ua.validateFunctions(this.Token, "USER_HIRES"))
            {
                sqlPart = " where  Status<>'DELETED' and  UserID=@UserID ";
                cmd.Parameters.AddWithValue("@UserID", ua.getLoggedUser(this.Token));
            }
            else
            {
                sqlPart = " where Status='ONLINE' ";
            }
            List<Hirings> list = new List<Hirings>();
            SqlConnection con = new SqlConnection(connection_string);
            string sql = "Select * from V_Hirings " + sqlPart +
                        " order by RecordRef Desc ";
            cmd.CommandText = sql;
            cmd.Connection = con;
            con.Open();
            try
            {
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Hirings h = new Hirings();
                    h.VehicleId = rdr["VehicleId"].ToString();
                    h.HireID = rdr["HireID"].ToString();    //Sa
                    h.Rate = Convert.ToDouble(rdr["Rate"]);
                    h.WithDriver = Convert.ToBoolean(rdr["WithDriver"]);
                    h.WithoutDriver = Convert.ToBoolean(rdr["WithoutDriver"]);
                    h.IsAvailable = Convert.ToBoolean(rdr["IsAvailable"]);
                    h.Location = Convert.ToString(rdr["Location"]);
                    h.UserID = Convert.ToString(rdr["UserId"]);
                    h.Brand = Convert.ToString(rdr["Brand"]);
                    h.Model = Convert.ToString(rdr["Model"]);
                    h.IsAC = Convert.ToBoolean(rdr["WithAC"]);
                    h.NoOfSeats = Convert.ToInt32(rdr["NoOfSeats"]);
                    h.OtherOptions = Convert.ToString(rdr["OtherOption"]);
                    h.Name = Convert.ToString(rdr["first_name"]);
                    h.Email = Convert.ToString(rdr["Email"]);
                    h.TelNo1 = Convert.ToString(rdr["mobile_phone"]);
                    h.TelNo2 = Convert.ToString(rdr["mobile_phone2"]);
                    h.Status = rdr["Status"].ToString();
                    list.Add(h);
                }
            }
            catch (Exception e)
            {
                string err = e.Message;
            }
            con.Close();
            //cmd.CommandText = sql;
            //cmd.Connection = con;
            return list;
        }
        public ReturnData SetHiring()
        {
            ReturnData rd = new ReturnData();
            CommonFunctions cf = new CommonFunctions();
            UserAccess ua = new UserAccess();
            if (!ua.validateFunctions(this.Token, "MNG_HIRE"))
            {
                rd.status = 0;
                rd.message = "Access denied! ";
                return rd;
            }
            if(this.VehicleId=="" || this.VehicleId == null)
            {
                rd.status = 0;
                rd.message = "Must select and vehicle!";
                return rd;
            }
            if (this.HireID == "" || this.HireID == null)
            {
                if (ValidateVehicle(this.VehicleId))
                {
                    rd.status = 0;
                    rd.message = "This vehicle is in another hire!";
                    return rd;
                }
                this.HireID = "HI" + cf.getNextId("HIRE_NO");
            }
            SqlConnection con = new SqlConnection(connection_string);
            string sql = "Begin " +
                            "IF exists (Select * from Hiring where VehicleId=@VehicleId) " +
                                "begin " +
                                    "Update Hiring set Rate=@Rate,WithDriver=@WithDriver,WithoutDriver=@WithoutDriver,IsAvailable=@IsAvailable,Location=@Location,Status=@Status " +
                                        "where HireID=@HireID and UserID=@UserID; " +
                                 "end; " +
                            "else " +
                                "begin " +
                                    "Insert into Hiring (HireID,VehicleId,Rate,WithDriver,WithoutDriver,IsAvailable,Location,UserID,Status) " +
                                    "Values(@HireID,@VehicleId,@Rate,@WithDriver,@WithoutDriver,@IsAvailable,@Location,@UserID,@Status); " +
                                 "end; "+
                           "end; ";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@HireID", this.HireID);
            cmd.Parameters.AddWithValue("@VehicleId", this.VehicleId);
            cmd.Parameters.AddWithValue("@Rate", this.Rate);
            cmd.Parameters.AddWithValue("@WithDriver", this.WithDriver);
            cmd.Parameters.AddWithValue("@WithoutDriver", this.WithoutDriver);
            cmd.Parameters.AddWithValue("@IsAvailable", this.IsAvailable);
            cmd.Parameters.AddWithValue("@Location", this.Location);
            cmd.Parameters.AddWithValue("@UserID", ua.getLoggedUser(this.Token));
            cmd.Parameters.AddWithValue("@Status", this.Status);
            con.Open();
            try
            {
                int count = cmd.ExecuteNonQuery();
                if (count > 0) { rd.status = 1;rd.message = "Success!"; }else { rd.status = 0;rd.message = "Not Success"; }
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message = "Something went wrong! " + e.Message;
            }
            con.Close();
            return rd;
        }
        public Boolean ValidateVehicle(string VehicleId)
        {
            Boolean st = false;
            SqlConnection con = new SqlConnection(connection_string);
            string sql = "select * from Hiring where VehicleId=@VehicleId";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@VehicleId", VehicleId);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Read();
            if (rdr.HasRows)
            {
                st =true;
            }else
            {
                st= false;
            }
            con.Close();
            return st;
        }
    }
}