using MyProject.App_Code;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace MyProject.Controllers
{
    public class AccessController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage login(UserAccess useraccess)
        {
            //login(dynamic para_user_id, dynamic para_password)
            ReturnData rd = new ReturnData();
            rd = useraccess.login();

            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;

        }
        [HttpPost]
        public HttpResponseMessage UserRegistration(Users users)
        {
            //login(dynamic para_user_id, dynamic para_password)
            ReturnData rd = new ReturnData();
            rd = users.UserRegistration();

            string yourJson = JsonConvert.SerializeObject(rd); ;
            var response = this.Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(yourJson, Encoding.UTF8, "application/json");
            return response;

        }
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}