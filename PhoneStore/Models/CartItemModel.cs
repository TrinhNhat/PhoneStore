using PhoneStore.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Models
{
    public class CartItemModel
    {
        public CartItem item { get; set; }
        public DIENTHOAI product { get; set; }
        public Decimal Amount { get; set; }
    }
}