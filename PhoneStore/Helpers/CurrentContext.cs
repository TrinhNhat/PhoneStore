using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Helpers
{
    public static class CurrentContext
    {
        public static bool IsLogin()
        {
            if ((int)HttpContext.Current.Session["IsLogin"] == 1)
            {
                return true;
            }

            if (HttpContext.Current.Request.Cookies["Username"] != null)
            {
                string user = HttpContext.Current.Request.Cookies["Username"].Value;
                HttpContext.Current.Session["IsLogin"] = 1;

                using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
                {
                    TAIKHOAN tk = ql.TAIKHOANs.Where(u => u.TenDN == user).FirstOrDefault();
                    HttpContext.Current.Session["CurAcc"] = tk;
                }

                return true;
            }

            return false;
        }

        public static TAIKHOAN GetCurAcc()
        {
            return (TAIKHOAN)HttpContext.Current.Session["CurAcc"];
        }

        public static Cart GetCart()
        {
            return (Cart)HttpContext.Current.Session["Cart"];
        }

        public static void Destroy()
        {
            HttpContext.Current.Session["IsLogin"] = 0;
            HttpContext.Current.Session["CurAcc"] = null;
            GetCart().Items.Clear();

            HttpContext.Current.Response.Cookies["Username"].Expires = DateTime.Now.AddDays(-1);
        }
    }
}