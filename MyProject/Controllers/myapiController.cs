using Newtonsoft.Json;
using MyProject.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace MyProject.Controllers
{
    public class myapiController : ApiController
    {
        [BasicAuthentication]
        [HttpGet]
        public HttpResponseMessage index()
        {
            String currDateTime = "";
            CommonFunctions c = new CommonFunctions();
            currDateTime = c.getCurrentDateTime();
            string yourJson = JsonConvert.SerializeObject(currDateTime); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;

        }
        [BasicAuthentication]
        [HttpGet]
        public HttpResponseMessage getUserName(string LoggedUser)
        {
            string userName = "";
            UserAccess u = new UserAccess();
            userName = u.getLoggedUser(LoggedUser);
            string yourJson = JsonConvert.SerializeObject(userName); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;

        }
        [BasicAuthentication]
        [HttpGet]
        public HttpResponseMessage signOutUser(string userId, string token)
        {
            ReturnData rd = new ReturnData();
            UserAccess u = new UserAccess();
            rd = u.delete_token(userId, token);
            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;

        }
        //Get user data 
        [BasicAuthentication]
        [HttpPost]//DIV.1 
        public HttpResponseMessage GetUserData(ReturnData r)
        {
            Users u = new Users();
            List<Users> list = new List<Users>();
            UserAccess ua = new UserAccess();
            string token = r.token;
            list = u.GetUsers(ua.getLoggedUser(token));
            string yourJson = JsonConvert.SerializeObject(list); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        [BasicAuthentication]
        [HttpPost]//DIV.1 
        public HttpResponseMessage UpdateUserProfile(Users u)
        {
            ReturnData rd = new ReturnData();
            rd = u.UpdateUserProfile();
            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        //Change pass by logged user
        [BasicAuthentication]
        [HttpPost]//DIV.1 
        public HttpResponseMessage ChangePassword(Users u)
        {
            ReturnData rd = new ReturnData();
            rd = u.ChangePassword();
            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        //[BasicAuthentication]
        [HttpPost]//DIV.1 
        public HttpResponseMessage GetHirings()
        {
            Hirings h = new Hirings();
            List<Hirings> list;
            list = h.GetHirings();
            string yourJson = JsonConvert.SerializeObject(list); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        [BasicAuthentication]
        [HttpPost]//DIV.1 
        public HttpResponseMessage SetVehicle(Vehicle v)
        {
            ReturnData rd;
            rd = v.SetVehicle();
            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        [BasicAuthentication]
        [HttpPost]//DIV.1  Overload method
        public HttpResponseMessage GetUserHirings(Hirings h)
        {
            List<Hirings> list;
            list = h.GetHirings();
            string yourJson = JsonConvert.SerializeObject(list); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        [BasicAuthentication]
        [HttpPost]//DIV.1  Overload method
        public HttpResponseMessage GetVehicle(Vehicle v)
        {
            List<Vehicle> list;
            list = v.GetVehicle();
            string yourJson = JsonConvert.SerializeObject(list); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
        [BasicAuthentication]
        [HttpPost]//DIV.1  Overload method
        public HttpResponseMessage SetHiring(Hirings h)
        {
            ReturnData rd;
            rd = h.SetHiring();
            string yourJson = JsonConvert.SerializeObject(rd);
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;
        }
    }

}
