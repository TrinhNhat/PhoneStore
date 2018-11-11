using BotDetect.Web.Mvc;
using PhoneStore.Filters;
using PhoneStore.Helpers;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Controllers
{
    public class TaikhoanController : Controller
    {
        // GET: Taikhoan/Dangnhap
        public ActionResult Dangnhap(string retUrl)
        {
            if (string.IsNullOrEmpty(retUrl) == false)
                ViewBag.RetUrl = retUrl;

            return View();
        }

        // Post: Taikhoan/Dangnhap
        [HttpPost]
        public ActionResult Dangnhap(LoginModel model)
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

        //Post: Taikhoan/Thoat
        [HttpPost]
        public ActionResult Thoat()
        {
            CurrentContext.Destroy();
            return RedirectToAction("Index","Home");
        }

        // GET: Taikhoan/Dangky
        public ActionResult Dangky()
        {
            return View();
        }

        // Post: Taikhoan/Dangky
        [HttpPost]
        [CaptchaValidation("CaptchaCode", "ExampleCaptcha", "Incorrect CAPTCHA code!")]
        public ActionResult Dangky(RegisterModel model)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                if (!ModelState.IsValid)
                {
                    // TODO: Captcha validation failed, show error message    
                    ViewBag.Err = "Captcha không chính xác.";
                    return View(model);
                }

                int n = ql.TAIKHOANs.Where(u => u.TenDN == model.UID).Count();

                if (n > 0)
                {
                    ViewBag.Err = model.UID + " đã có trong hệ thống";
                    return View(model);
                }

                n = ql.TAIKHOANs.Where(u => u.Email == model.Email).Count();

                if (n > 0)
                {
                    ViewBag.Err = "Email này đã được sử dụng";
                    return View(model);
                }

                TAIKHOAN tk = new TAIKHOAN();

                tk.TenDN = model.UID;
                tk.MatKhau = StringUtils.MD5(model.PWD);
                tk.Email = model.Email;
                tk.TenKH = model.FullName;
                tk.NgaySinh = DateTime.ParseExact(model.DOB, "M/d/yyyy", null);
                tk.LoaiTK = "AKH";

                ql.TAIKHOANs.Add(tk);
                ql.SaveChanges();
            }

            ViewBag.Board = "Tài khoản đã được tạo.";
            return View();
        }

        // GET: Taikhoan/Thongtincanhan
        [LoginRequired(Permisson = "AKH")]
        public ActionResult Thongtincanhan()
        {
            //if (CurrentContext.IsLogin() == false)
            //{
            //    return RedirectToAction("Dangnhap", "Taikhoan");
            //}
            return View();
        }

        // POST: /Taikhoan/ChangePassword
        [HttpPost]
        public ActionResult ChangePassword(ProfileModel model)
        {
            string mkold = StringUtils.MD5(model.PWD_OLD);
            string mknew = StringUtils.MD5(model.PWD_NEW);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                int n = ql.TAIKHOANs.Where(p => p.TenDN == model.UID && p.MatKhau == mkold).Count();

                if (n == 0)
                {
                    ViewBag.Err = "Mật khẩu không thể thay đổi.";
                    return View("Thongtincanhan", model);
                }

                TAIKHOAN tk = CurrentContext.GetCurAcc();
                tk.MatKhau = mknew;

                ql.Entry(tk).State = System.Data.Entity.EntityState.Modified;
                ql.SaveChanges();

                ViewBag.Board = "Mật khẩu đã được thay đổi.";
            }
            return View("Thongtincanhan", model);
        }

        //
        // POST: /Taikhoan/ChangeProfile
        [HttpPost]
        public ActionResult ChangeProfile(ProfileModel model)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities ())
            {
                TAIKHOAN tk = CurrentContext.GetCurAcc();
                tk.TenKH = model.FullName;
                tk.Email = model.email;
                tk.NgaySinh = DateTime.ParseExact(model.dob, "M/d/yyyy", null);

                ql.Entry(tk).State = System.Data.Entity.EntityState.Modified;
                ql.SaveChanges();

                ViewBag.aBoard = "Thông tin đã được thay đổi.";
            }
            return View("Thongtincanhan", model);
        }
    }
}