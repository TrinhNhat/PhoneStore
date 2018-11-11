using PhoneStore.Filters;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class HangDTController : Controller
    {
        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/HangDT/GetAllLoai
        public ActionResult GetAllLoai(int page = 1)
        {
            int pageSz = 5;

            List<HANGDIENTHOAI> model = new List<HANGDIENTHOAI>();
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.HANGDIENTHOAIs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = query.OrderBy(p => p.MaHang).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                return View(li);
            }
        }

        [LoginRequired(Permisson = "AAD")]
        //GET: /Admin/HangDT/AddLoai
        public ActionResult AddLoai()
        {
            return View();
        }

        //
        //POST: /Admin/HangDT/AddLoai
        [HttpPost]
        public ActionResult AddLoai(HANGDIENTHOAI ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                int count = ql.HANGDIENTHOAIs.Count();
                ob.MaHang = count + 1;

                ql.HANGDIENTHOAIs.Add(ob);
                ql.SaveChanges();
            }

            ViewBag.Added = true;
            return View();
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/HangDT/EditLoai
        public ActionResult EditLoai(int? id)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("GetAllLoai", "HangDT");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                HANGDIENTHOAI l = ql.HANGDIENTHOAIs.Where(p => p.MaHang == id).FirstOrDefault();

                return View(l);
            }
        }

        //
        //POST: /Admin/HangDT/EditLoai
        [HttpPost]
        public ActionResult EditLoai(HANGDIENTHOAI ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                //LOAIXE lx = ctx.LOAIXEs.Where(p => p.MaLoai == ob.MaLoai).FirstOrDefault(); ;

                //lx.TenLoai = ob.TenLoai;
                ql.Entry(ob).State = System.Data.Entity.EntityState.Modified;

                ql.SaveChanges();
            }

            ViewBag.Added = true;
            return View(ob);
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/HangDT/RemoveLoai
        public ActionResult RemoveLoai(int? id)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("GetAllLoai", "HangDT");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                HANGDIENTHOAI l = ql.HANGDIENTHOAIs.Where(p => p.MaHang == id).FirstOrDefault();

                return View(l);
            }
        }

        //
        //POST: /Admin/HangDT/RemoveLoai
        [HttpPost]
        public ActionResult RemoveLoai(HANGDIENTHOAI ob)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                HANGDIENTHOAI lx = ql.HANGDIENTHOAIs.Where(p => p.MaHang == ob.MaHang).FirstOrDefault();
                ql.HANGDIENTHOAIs.Remove(lx);
                ql.SaveChanges();
            }

            return View();
        }
    }
}