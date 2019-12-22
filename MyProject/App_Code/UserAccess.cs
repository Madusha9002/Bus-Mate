using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class UserAccess
    {
        readonly string user_db_connection_string = ConfigurationManager.ConnectionStrings["user_db_connectionstring"].ConnectionString;
        public int recordref { get; set; }
        public string user_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }
        public string mobile_phone { get; set; }
        public string password { get; set; }
        public string user_role { get; set; }
        public string password_trycount { get; set; }
        public string status { get; set; }
        public string last_accessed { get; set; }
        public ReturnData login()
        {
            ReturnData rd = new ReturnData();
            EncriptionDecription ed = new EncriptionDecription();
            if (this.user_id == null || this.password == null || this.user_id == "" || this.password == "")
            {
                rd.status = 0;
                rd.message = "Not a valid username of password";
                return rd;
            }


            string sql = "select * from user_profile where user_id=@para_user_id and password=@para_password and status = 'Active' ";
            SqlConnection con = new SqlConnection(user_db_connection_string);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@para_user_id", this.user_id);
            //cmd.Parameters.AddWithValue("@para_password", this.password); //Check plain text password
            cmd.Parameters.AddWithValue("@para_password", ed.GetHashSha256(this.password)); //Check Hash(sha256) password
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.HasRows)
            {
                rdr.Read();
                rd.status = 1;
                rd.message = "OK";
                rd.para1 = get_token(rdr["user_id"].ToString());

            }
            else
            {
                rd.status = 0;
                rd.message = "Not a valid username of password";
            }
            con.Close();

            return rd;
        }
        protected string get_token(string para_user_id)
        {
            //generate a token
            Guid id = Guid.NewGuid();
            string token = id.ToString();

            var request = HttpContext.Current.Request;
            string ip = request.ServerVariables["REMOTE_ADDR"];

            if (ip == null) { ip = "Not Available"; }

            SqlConnection con = new SqlConnection(user_db_connection_string);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            CommonFunctions cf = new CommonFunctions();

            //TWO QUERIES
            cmd.CommandText = "delete from  token where user_id=@user_id; insert into TOKEN (user_id,token, ip, center_id, login_time) values(@user_id,@token, @ip, @center_id, @current_date_time)";
            cmd.Parameters.AddWithValue("@user_id", para_user_id);
            cmd.Parameters.AddWithValue("@token", token);
            cmd.Parameters.AddWithValue("@ip", ip);
            cmd.Parameters.AddWithValue("@center_id", "0");
            cmd.Parameters.AddWithValue("@current_date_time", cf.getCurrentDateTime());
            con.Open();
            int count = (int)cmd.ExecuteNonQuery();
            con.Close();

            return token;

        }
        public bool validateToken(string token)
        {
            bool return_value = false;

            SqlConnection con = new SqlConnection(user_db_connection_string);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "select * from token where token=@token";
            cmd.Parameters.AddWithValue("@token", token);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.HasRows)
            {
                rdr.Read();

                CommonFunctions cf = new CommonFunctions();

                DateTime current_time = Convert.ToDateTime(cf.getCurrentDateTime());
                DateTime token_time = Convert.ToDateTime(rdr["login_time"]);

                var duration = (int)(current_time - token_time).TotalMinutes;
                if (duration > 360)
                {
                    return_value = false;
                }
                else
                {
                    return_value = true;
                }
            }

            con.Close();
            return return_value;

        }
        public ReturnData delete_token(string para_user_id, string token)
        {
            //generate a token
            //Guid id = Guid.NewGuid();
            //string token = id.ToString();

            var request = HttpContext.Current.Request;
            string ip = request.ServerVariables["REMOTE_ADDR"];
            ReturnData rd = new ReturnData();
            if (ip == null) { ip = "Not Available"; }

            SqlConnection con = new SqlConnection(user_db_connection_string);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            CommonFunctions cf = new CommonFunctions();

            //TWO QUERIES
            cmd.CommandText = "delete from  token where user_id=@user_id and token=@token";
            cmd.Parameters.AddWithValue("@user_id", para_user_id);
            cmd.Parameters.AddWithValue("@token", token);
            cmd.Parameters.AddWithValue("@ip", ip);
            cmd.Parameters.AddWithValue("@center_id", "0");
            cmd.Parameters.AddWithValue("@current_date_time", cf.getCurrentDateTime());
            int count = 0;
            con.Open();

            try
            {
                count = (int)cmd.ExecuteNonQuery();
            }
            catch (Exception Ex)
            {
                rd.status = 0;
                rd.message = Ex.Message;
            }
            con.Close();
            if (count > 0)
            {
                rd.status = 1;
                rd.message = "OK";
            }
            return rd;

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
        public string getUserRole(string token)
        {
            string userRole = "";
            SqlConnection con = new SqlConnection(user_db_connection_string);
            string sql = "select user_profile.user_role as userRole from Token inner join user_profile on Token.user_id=user_profile.user_id where Token.token=@token";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@token", token);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                rdr.Read();
                userRole = rdr["userRole"].ToString();
            }
            con.Close();
            return userRole;
        }

        public Boolean validateFunctions(string token, string strFunction)
        {
            //Boolean b = false;
            SqlConnection con = new SqlConnection(user_db_connection_string);
            int count = 0;
            string sx = "%\\[" + strFunction + "\\]%";
            string sql = "select COUNT(*) as RecCnt from user_role where functions like @functions escape '\\' and user_role=(select user_profile.user_role as userRole from Token inner join user_profile on Token.user_id=user_profile.user_id where Token.token=@token)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@functions", sx);
            cmd.Parameters.AddWithValue("@token", token);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                rdr.Read();
                count = Convert.ToInt32(rdr["RecCnt"]);
            }
            con.Close();
            if (count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
    }
}