using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Areas.Admin.Models
{
    public class DangnhapModel
    {
        public string UID { get; set; }
        public string PWD { get; set; }
        public bool RememberMe { get; set; }
        public string retUrl { get; set; }
    }
}