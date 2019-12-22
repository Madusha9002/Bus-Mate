using System;
using MyProject.App_Code;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyProject
{
    //part of this class from https://stevescodingblog.co.uk/basic-authentication-with-asp-net-webapi/ article
    public class BasicAuthenticationAttribute : System.Web.Http.Filters.ActionFilterAttribute
    {
        public override void OnActionExecuting(System.Web.Http.Controllers.HttpActionContext actionContext)
        {

            if (actionContext.Request.Headers.Authorization == null)
            {
                actionContext.Response = new System.Net.Http.HttpResponseMessage(System.Net.HttpStatusCode.Unauthorized);
            }
            else
            {

                var re = actionContext.Request;
                var headers = re.Headers;

                string token = headers.GetValues("Authorization").First(); //this is collected from the HTTP header 

                UserAccess u = new UserAccess();

                if (!u.validateToken(token)) //invalid token
                {
                    actionContext.Response = new System.Net.Http.HttpResponseMessage(System.Net.HttpStatusCode.Unauthorized);
                }

            }

        }



    }
}