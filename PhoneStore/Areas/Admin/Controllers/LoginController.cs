using PhoneStore.Areas.Admin.Models;
using PhoneStore.Helpers;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        // GET: Admin/Login/Index
        public ActionResult Index()
        {
            return View();
        }

        // Post: Admin/Login/Index
        [HttpPost]
        public ActionResult Index(DangnhapModel model)
        {
            if (string.IsNullOrEmpty(model.UID) || string.IsNullOrEmpty(model.PWD))
            {
                ViewBag.Err = "Chưa nhập đủ thông tin! Hãy kiểm tra lại.";
                return View();
            }

            string mk = StringUtils.MD5(model.PWD);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                TAIKHOAN tk = ql.TAIKHOANs.Where(t => t.TenDN == model.UID && t.MatKhau == mk).FirstOrDefault();

                if (tk != null)
                {
                    Session["IsLogin"] = 1;
                    Session["CurAcc"] = tk;

                    if (model.RememberMe)
                    {
                        Response.Cookies["Username"].Value = model.UID;
                        Response.Cookies["Username"].Expires = DateTime.Now.AddDays(7);
                    }

                    if (string.IsNullOrEmpty(model.retUrl))
                        return RedirectToAction("Index", "Home");

                    return Redirect(model.retUrl);
                }
                else
                {
                    ViewBag.Err = "Sai tên đăng nhập hoặc mật khẩu";
                    return View();
                }
            }
        }

        //Post: /Admin/Login/Logout
        [HttpPost]
        public ActionResult Logout()
        {
            CurrentContext.Destroy();
            return RedirectToAction("Index", "Login");
        }
    }
}