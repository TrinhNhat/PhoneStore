using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Models
{
    public class SearchModel
    {
        public List<HANGDIENTHOAI> lt { get; set; }
        public List<NHASANXUAT> ln { get; set; }
        public List<DIENTHOAI> dt { get; set; }
        public int Hang { get; set; }
        public int NSX { get; set; }
        public int GiaMin { get; set; }
        public int GiaMax { get; set; }
    }
}