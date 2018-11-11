using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Models
{
    public class OrderDetailModel
    {
        public DIENTHOAI dt { get; set; }
        public int Soluong { get; set; }
        public int DonGia { get; set; }
        public int ThanhTien { get; set; }
    }
}