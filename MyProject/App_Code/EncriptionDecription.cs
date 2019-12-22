using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace MyProject.App_Code
{
    public class EncriptionDecription
    {
        public string GetHashSha256(string text)
        {
            string hash = "";
            SHA256 myHash = SHA256.Create();
            byte[] hashArr = myHash.ComputeHash(Encoding.UTF8.GetBytes(text));
            hash=hashArr.ToString();
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < hashArr.Length; i++)
            {
                builder.Append(hashArr[i].ToString("x2"));
            }
            hash = builder.ToString();
            return hash;
        }
        public string GetHashSha1(string text)
        {
            string hash = "";
            SHA1 myHash = SHA1.Create();
            byte[] hashArr = myHash.ComputeHash(Encoding.UTF8.GetBytes(text));
            hash = hashArr.ToString();
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < hashArr.Length; i++)
            {
                builder.Append(hashArr[i].ToString("x2"));
            }
            hash = builder.ToString();
            return hash;
        }
        public string GetHashMD5(string text)
        {
            string hash = "";
            MD5 myHash = MD5.Create();
            byte[] hashArr = myHash.ComputeHash(Encoding.UTF8.GetBytes(text));
            hash = hashArr.ToString();
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < hashArr.Length; i++)
            {
                builder.Append(hashArr[i].ToString("x2"));
            }
            hash = builder.ToString();
            return hash;
        }
    }
}