using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class Users
    {
        public string UserID { get; set; }
        public Boolean IsEdit { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string MobilePhone { get; set; }
        public string Password { get; set; }
        public string UserRole { get; set; }
        public string Status { get; set; }
        public string Token { get; set; }
        public string NewPassword { get; set; }
        public string ConfirmPassword { get; set; }
        string connection_string = ConfigurationManager.ConnectionStrings["db_connectionString"].ConnectionString;
        string user_db_connection_string = ConfigurationManager.ConnectionStrings["user_db_connectionstring"].ConnectionString;

        public ReturnData SetUser()
        {
            ReturnData rd = new ReturnData();
            EncriptionDecription ed = new EncriptionDecription();
            UserAccess ua = new UserAccess();
            SqlConnection usercon = new SqlConnection(user_db_connection_string);
            if (!ua.validateFunctions(this.Token, "ADMIN_PANEL")) { rd.status = 0; rd.message = "You do not have privileges!"; return rd; }
            string sql = "";
            if (IsEdit)
            {
                sql = "Update user_profile set first_name=@first_name,last_name=@last_name,email=@email,mobile_phone=@mobile_phone,user_role=@user_role,status=@status where user_id=@user_id;";
            }else
            {
                sql = "Insert into user_profile (user_id,first_name,last_name,email,mobile_phone,password,user_role,status) values(@user_id,@first_name,@last_name,@email,@mobile_phone,@password,@user_role,@status);";
            }
            SqlCommand cmd = new SqlCommand(sql, usercon);
            cmd.Parameters.AddWithValue("@user_id", this.UserID);
            cmd.Parameters.AddWithValue("@first_name", this.FirstName);
            cmd.Parameters.AddWithValue("@last_name", this.LastName);
            cmd.Parameters.AddWithValue("@email", this.Email);
            cmd.Parameters.AddWithValue("@mobile_phone", this.MobilePhone);
            cmd.Parameters.AddWithValue("@password", ed.GetHashSha256(this.Password));
            cmd.Parameters.AddWithValue("@user_role", this.UserRole);
            cmd.Parameters.AddWithValue("@status", this.Status);
            usercon.Open();
            int count = 0;
            try
            {
                count = (int)cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message="Something went wrong! " + e.Message;
                return rd;
            }
            usercon.Close();
            if (count > 0) { rd.status = 1;rd.message = "Saved!"; }else { rd.status = 0;rd.message = "Unable to save!"; }
            return rd;
        }
        public List<Users> GetUsers(string SearchStr)
        {
            List<Users> list = new List<Users>();
            SqlConnection usercon = new SqlConnection(user_db_connection_string);
            SqlCommand cmd = new SqlCommand();
            string sqlPart = "";
            if(SearchStr !=null && SearchStr != "") {
                sqlPart = " and user_id=@user_id";
                cmd.Parameters.AddWithValue("@user_id", SearchStr);
            }
            string sql = "select user_id,first_name,last_name,email,mobile_phone,user_role,status from user_profile where user_id <>'AWS'";
            string sqlPart2 = " order by user_id;";
            cmd.Connection = usercon;
            cmd.CommandText = sql + sqlPart + sqlPart2;
            usercon.Open();
            try
            {
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Users u = new Users();
                    u.UserID = rdr["user_id"].ToString();
                    u.FirstName = rdr["first_name"].ToString();
                    u.LastName = rdr["last_name"].ToString();
                    u.Email = rdr["email"].ToString();
                    u.MobilePhone = rdr["mobile_phone"].ToString();
                    u.UserRole = rdr["user_role"].ToString();
                    u.Status = rdr["status"].ToString();
                    list.Add(u);
                }
            }
            catch (Exception e)
            {
                string err = e.Message;
            }
            usercon.Close();
            return list;
        }
        public ReturnData UpdateUserProfile()
        {
            ReturnData rd = new ReturnData();
            SqlConnection usercon = new SqlConnection(user_db_connection_string);
            UserAccess ua = new UserAccess();
            int count = 0;
            string sql = "update user_profile set first_name=@first_name,last_name=@last_name,email=@email,mobile_phone=@mobile_phone where user_id=@user_id";
            SqlCommand cmd = new SqlCommand(sql,usercon);
            cmd.Parameters.AddWithValue("@first_name", this.FirstName);
            cmd.Parameters.AddWithValue("@last_name", this.LastName);
            cmd.Parameters.AddWithValue("@email", this.Email);
            cmd.Parameters.AddWithValue("@mobile_phone", this.MobilePhone);
            cmd.Parameters.AddWithValue("@user_id", ua.getLoggedUser(this.Token));
            usercon.Open();
            try
            {
                count = (int)cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message = "Something went wrong! " + e.Message;
            }
            usercon.Close();
            if (count > 0)
            {
                rd.status = 1;
                rd.message = "Data updated!";
            }
            else
            {
                rd.status = 0;
                rd.message = rd.message + "Cannot update data";
            }
            return rd;
        }
        public ReturnData ChangePassword()
        {
            ReturnData rd = new ReturnData();
            SqlConnection usercon = new SqlConnection(user_db_connection_string);
            EncriptionDecription ed = new EncriptionDecription();
            UserAccess ua = new UserAccess();
            int Count = 0;
            string sql = "update user_profile set password=@NewPassword where user_id=@user_id and password=@password";
            SqlCommand cmd = new SqlCommand(sql, usercon);
            cmd.Parameters.AddWithValue("@NewPassword", ed.GetHashSha256(this.NewPassword));
            cmd.Parameters.AddWithValue("@user_id", ua.getLoggedUser(this.Token));
            cmd.Parameters.AddWithValue("@password", ed.GetHashSha256(this.Password));
            usercon.Open();
            try
            {
                Count = (int)cmd.ExecuteNonQuery();
                if (Count > 0) { rd.status = 1;rd.message = "Password changed!"; }else { rd.status = 0;rd.message = "Wrong password!"; }
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message = "Something went wrong! " + e.Message;
            }
            usercon.Close();
            return rd;
        }

        public ReturnData UserRegistration()
        {
            ReturnData rd = new ReturnData();
            SqlConnection usercon = new SqlConnection(user_db_connection_string);
            EncriptionDecription ed = new EncriptionDecription();
            if(this.NewPassword != this.ConfirmPassword)
            {
                rd.status = 0;
                rd.message = "password mismatch!";
                return rd;
            }
            string sql = "Insert into user_profile (user_id,password,status) values(@UserID,@NewPassword,@status);";
            SqlCommand cmd = new SqlCommand(sql, usercon);
            cmd.Parameters.AddWithValue("@UserID", this.UserID);
            cmd.Parameters.AddWithValue("@NewPassword", ed.GetHashSha256(this.NewPassword));
            cmd.Parameters.AddWithValue("@status", "Active");
            usercon.Open();
            try
            {
                int count = cmd.ExecuteNonQuery();
                if (count > 0)
                {
                    rd.status = 1;
                    rd.message = "User added!";
                }
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message = e.Message;
            }
            usercon.Close();
            
            return rd;
        }

    }
}