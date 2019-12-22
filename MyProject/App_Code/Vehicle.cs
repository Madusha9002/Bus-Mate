using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class Vehicle
    {
        public string UserId { get; set; }
        public string VehicleId { get; set; }
        public string Brand { get; set; }
        public string Model { get; set; }
        public Boolean WithAC { get; set; }
        public int NoOfSeats { get; set; }
        public string OtherOptions { get; set; }
        public string ImagePath { get; set; }
        public string Token { get; set; }

        readonly string connection_string = ConfigurationManager.ConnectionStrings["db_connectionstring"].ConnectionString;

        public ReturnData SetVehicle()  //Sa
        {
            ReturnData rd = new ReturnData();
            UserAccess ua = new UserAccess();
            CommonFunctions cf = new CommonFunctions();
            if (!ua.validateFunctions(this.Token, "MNG_VEHICLE"))
            {
                rd.status = 0;
                rd.message = "Access denied! ";
                return rd;
            }
            if(this.VehicleId=="" || this.VehicleId == null)
            {
                this.VehicleId = "VID" +cf.getNextId("VEHICLE_ID");
            }
            SqlConnection con = new SqlConnection(connection_string);
            string sql = "Begin " + //Sa
                            "IF exists(select * from Vehical where VehicleId=@VehicleId) " +
                                "begin " +
                                    "Update Vehical set Brand=@Brand,Model=@Model,WithAC=@WithAC,NoOfSeats=@NoOfSeats, OtherOption=@OtherOption " +
                                        "where VehicleId=@VehicleId and UserId=@UserId; " +
                                 "end; " +
                            "else " +
                                "begin " +
                                    "insert into Vehical (UserId,VehicleId,Brand,Model,WithAC,NoOfSeats, OtherOption) " +
                                       "values(@UserId,@VehicleId,@Brand,@Model,@WithAC,@NoOfSeats, @OtherOption ) " +
                                "end; " +
                         "end; ";
            SqlCommand cmd = new SqlCommand(sql,con);
            cmd.Parameters.AddWithValue("@UserId",ua.getLoggedUser(this.Token));
            cmd.Parameters.AddWithValue("@VehicleId", this.VehicleId);
            cmd.Parameters.AddWithValue("@Brand", this.Brand);
            cmd.Parameters.AddWithValue("@Model", this.Model);
            cmd.Parameters.AddWithValue("@WithAC", this.WithAC);
            cmd.Parameters.AddWithValue("@NoOfSeats", this.NoOfSeats);
            cmd.Parameters.AddWithValue("@OtherOption", this.OtherOptions);
            //cmd.Parameters.AddWithValue("@ImagePath", this.ImagePath);
            con.Open();
            try
            {
                int count = cmd.ExecuteNonQuery();
                if (count > 0)
                {
                    rd.status = 1;
                    rd.message = "successd";
                }
                else
                {
                    rd.status = 0;
                    rd.message = "Not inserted";
                }
            }
            catch (Exception e)
            {
                rd.status = 0;
                rd.message = "Something went wrong  " + e.Message; 
            }
            con.Close();
            return rd;
        }
        /// <summary>
        /// Return Vehicle list
        /// pass Token in object to get userwise
        /// </summary>
        /// <returns></returns>
        public List<Vehicle> GetVehicle()
        {
            List<Vehicle> list = new List<Vehicle>();
            UserAccess ua = new UserAccess();
            SqlCommand cmd = new SqlCommand();
            string sqlPart = "";
            string sqlPart2 = "";
            
            if (ua.validateFunctions(this.Token, "ALL_VEHICLES"))
            {
                if (this.VehicleId != "" && this.VehicleId != null)
                {
                    sqlPart = " where VehicleId=@VehicleId";
                    cmd.Parameters.AddWithValue("@VehicleId", this.VehicleId);
                }
                else
                {
                    sqlPart = "";
                }
            }
            else
            {
                if(this.VehicleId != "" && this.VehicleId != null)
                {
                    sqlPart2 = " and VehicleId=@VehicleId";
                    cmd.Parameters.AddWithValue("@VehicleId", this.VehicleId);
                }
                sqlPart = " where UserId=@UserId" + sqlPart2;
                cmd.Parameters.AddWithValue("@UserId",ua.getLoggedUser(this.Token));
            }
            SqlConnection con = new SqlConnection(connection_string);
            string sql = "select * from Vehical " + sqlPart;
            cmd.CommandText = sql;
            cmd.Connection = con;
            con.Open();
            try
            {
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Vehicle v = new Vehicle();
                    v.UserId = rdr["UserId"].ToString();
                    v.VehicleId = rdr["VehicleId"].ToString();
                    v.Brand = rdr["Brand"].ToString();
                    v.Model = rdr["Model"].ToString();
                    v.WithAC = Convert.ToBoolean(rdr["WithAC"]);
                    v.NoOfSeats = Convert.ToInt32(rdr["NoOfSeats"]);
                    v.OtherOptions = rdr["OtherOption"].ToString();
                    //v.ImagePath = rdr["ImagePath"].ToString();
                    list.Add(v);
                }
            }
            catch (Exception e)
            {
                string err = e.Message;
            }
            con.Close();
            return list;
        }
    }
    
}