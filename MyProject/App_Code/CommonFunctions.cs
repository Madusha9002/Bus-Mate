using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class CommonFunctions
    {
        string connection_string = ConfigurationManager.ConnectionStrings["db_connectionstring"].ConnectionString;
        string usr_connection_string = ConfigurationManager.ConnectionStrings["user_db_connectionString"].ConnectionString;
        public string getCurrentDate()
        {
            var remoteTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Sri Lanka Standard Time");
            var remoteTime = TimeZoneInfo.ConvertTime(DateTime.Now, remoteTimeZone);
            return remoteTime.ToString("yyyy-MM-dd");
        }

        public string getCurrentDateTime()
        {
            var remoteTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Sri Lanka Standard Time");
            var remoteTime = TimeZoneInfo.ConvertTime(DateTime.Now, remoteTimeZone);
            return remoteTime.ToString("yyyy-MM-dd HH:mm");
        }
        public string getCurrentDateTimeSec()
        {
            var remoteTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Sri Lanka Standard Time");
            var remoteTime = TimeZoneInfo.ConvertTime(DateTime.Now, remoteTimeZone);
            return remoteTime.ToString("yyyy-MM-dd HH:mm:ss");
        }

        public int getNextId(string field_name)
        {
            int return_value = 0;

            SqlConnection con = new SqlConnection(connection_string);
            string sql = "update config set int_field_value = int_field_value+1 where field_name =@field_name; select int_field_value from config where field_name=@field_name";
            //string sql = "select int_field_value from config where field_name=@field_name";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@field_name", field_name);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                return_value = Convert.ToInt32(rdr["int_field_value"]);
            }
            con.Close();



            return return_value;
        }
    }
}