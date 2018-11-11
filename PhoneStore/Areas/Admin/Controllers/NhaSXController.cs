using PhoneStore.Filters;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class NhaSXController : Controller
    {
        // GET: Admin/NhaSX
        public ActionResult Index()
        {
            return View();
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/NhaSX/GetAllNSX
        public ActionResult GetAllNSX(int page = 1)
        {
            int pageSz = 5;

            List<NHASANXUAT> model = new List<NHASANXUAT>();
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.NHASANXUATs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = query.OrderBy(p => p.MaNSX).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                return View(li);
            }
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/NhaSX/AddNSX
        public ActionResult AddNSX()
        {
            return View();
        }

        //
        //POST: /Admin/NhaSX/AddNSX
        [HttpPost]
        public ActionResult AddNSX(NHASANXUAT ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                int count = ql.NHASANXUATs.Count();
                ob.MaNSX = count + 1;

                ql.NHASANXUATs.Add(ob);
                ql.SaveChanges();
            }

            ViewBag.Added = true;
            return View();
        }


        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/NhaSX/EditNSX
        public ActionResult EditNSX(int? id)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("GetAllNSX", "NhaSX");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                NHASANXUAT n = ql.NHASANXUATs.Where(p => p.MaNSX == id).FirstOrDefault();

                return View(n);
            }
        }

        //
        //POST: /Admin/NhaSX/EditNSX
        [HttpPost]
        public ActionResult EditNSX(NHASANXUAT ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                NHASANXUAT n = ql.NHASANXUATs.Where(p => p.MaNSX == ob.MaNSX).FirstOrDefault();

                n.TenNSX = ob.TenNSX;
                n.QuocGia = ob.QuocGia;

                ql.SaveChanges();
            }

            ViewBag.Added = true;
            return View(ob);
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/NhaSX/RemoveNSX
        public ActionResult RemoveNSX(int? id)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("GetAllNSX", "NhaSX");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                NHASANXUAT l = ql.NHASANXUATs.Where(p => p.MaNSX == id).FirstOrDefault();

                return View(l);
            }
        }

        //
        //POST: /Admin/RemoveLoai
        [HttpPost]
        public ActionResult RemoveNSX(NHASANXUAT ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                NHASANXUAT lx = ql.NHASANXUATs.Where(p => p.MaNSX == ob.MaNSX).FirstOrDefault();
                ql.NHASANXUATs.Remove(lx);
                ql.SaveChanges();
            }

            return View();
        }
    }
}