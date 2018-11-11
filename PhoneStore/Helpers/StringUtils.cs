using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace PhoneStore.Helpers
{
    public static class StringUtils
    {
        public static string MD5(string input)
        {
            MD5 md5 = MD5CryptoServiceProvider.Create();
            byte[] ip = Encoding.Default.GetBytes(input);
            byte[] output = md5.ComputeHash(ip);
            string ret = BitConverter.ToString(output).Replace("-", "");
            return ret;
        }
    }
}