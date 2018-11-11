using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Models
{
    public class ProfileModel
    {
        public int ID { get; set; }
        public string UID { get; set; }
        public string PWD_OLD { get; set; }
        public string PWD_NEW { get; set; }
        public string FullName { get; set; }
        public string dob { get; set; }
        public string email { get; set; }
        public string loaitk { get; set; }
    }
}