using PhoneStore.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneStore.Models;
using BotDetect.Web.Mvc;
using PhoneStore.Helpers;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        // GET: Admin/Home
        [LoginRequired(Permisson = "AAD")]
        public ActionResult Index(int page = 1)
        {
            int pageSz = 5;

            List<TAIKHOAN> model = new List<TAIKHOAN>();
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.TAIKHOANs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = query.OrderBy(p => p.MaTK).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                return View(li);
            }
        }

        // Get: Admin/Home/Create
        [LoginRequired(Permisson = "AAD")]
        public ActionResult Create()
        {
            return View();
        }

        // Post: Admin/Home/Create
        [HttpPost]
        [CaptchaValidation("CaptchaCode", "ExampleCaptcha", "Incorrect CAPTCHA code!")]
        public ActionResult Create(RegisterModel model)
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
                tk.LoaiTK = "AAD";

                ql.TAIKHOANs.Add(tk);
                ql.SaveChanges();
            }

            ViewBag.Board = "Tài khoản đã được tạo.";
            return View();
        }

        // GET: /Admin/Home/Profiles
        [LoginRequired(Permisson = "AAD")]
        public ActionResult Profiles()
        {
            return View();
        }

        // POST: /Admin/Home/ChangePassword
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
                    return View("Profiles", model);
                }

                TAIKHOAN tk = CurrentContext.GetCurAcc();
                tk.MatKhau = mknew;

                ql.Entry(tk).State = System.Data.Entity.EntityState.Modified;
                ql.SaveChanges();

                ViewBag.Board = "Mật khẩu đã được thay đổi.";
            }
            return View("Profiles", model);
        }

        //
        // POST: /Admin/Home/ChangeProfile
        [HttpPost]
        public ActionResult ChangeProfile(ProfileModel model)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                TAIKHOAN tk = CurrentContext.GetCurAcc();
                tk.TenKH = model.FullName;
                tk.Email = model.email;
                tk.NgaySinh = DateTime.ParseExact(model.dob, "M/d/yyyy", null);

                ql.Entry(tk).State = System.Data.Entity.EntityState.Modified;
                ql.SaveChanges();

                ViewBag.aBoard = "Thông tin đã được thay đổi.";
            }
            return View("Profiles", model);
        }

        //GET: /Admin/Home/Delete
        [LoginRequired(Permisson = "AAD")]
        public ActionResult Delete(int? id)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("Index", "Home");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                TAIKHOAN l = ql.TAIKHOANs.Where(p => p.MaTK == id).FirstOrDefault();

                return View(l);
            }
        }

        //
        //POST: /Admin/Home/Delete
        [HttpPost]
        public ActionResult Delete(TAIKHOAN ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                TAIKHOAN lx = ql.TAIKHOANs.Where(p => p.MaTK == ob.MaTK).FirstOrDefault();
                ql.TAIKHOANs.Remove(lx);
                ql.SaveChanges();
            }

            return View();
        }
    }
}