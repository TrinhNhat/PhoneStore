using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Areas.Admin.Models
{
    public class EditProductModel
    {
        public string MaDT { get; set; }
        public string TenDT { get; set; }
        public DateTime NgayNhap { get; set; }
        public int DonGia { get; set; }
        public int SLTon { get; set; }
        public string TenNSX { get; set; }
        public string TenHang { get; set; }
    }
}