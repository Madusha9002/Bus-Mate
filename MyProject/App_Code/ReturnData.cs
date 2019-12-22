using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyProject.App_Code
{
    public class ReturnData
    {
        public int status { get; set; }
        public string message { get; set; }
        public string para1 { get; set; }
        public string para2 { get; set; }
        public string chitno { get; set; }
        public int IntPara1 { get; set; }   
        public int IntPara2 { get; set; }   
        public double DblPara { get; set; }
        public double DblPara2 { get; set; }
        public string token { get; set; }
        public Boolean boolPara { get; set; }

    }
}