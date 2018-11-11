using PhoneStore.Filters;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class DonhangController : Controller
    {
        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/Donhang/GetAllOrder
        public ActionResult GetAllOrder(int page = 1)
        {
            int pageSz = 10;

            List<DONHANG> model = new List<DONHANG>();
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DONHANGs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = query.OrderBy(p => p.MaDH).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                return View(li);
            }
        }

        //POST: /Admin/Donhang/ChangeStatus
        [HttpPost]
        public ActionResult ChangeStatus(int? id, int tt, int page)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                DONHANG d = ql.DONHANGs.Where(p => p.MaDH == id).FirstOrDefault();

                if (tt == 1)
                    d.TinhTrang = "Chưa giao hàng";
                if (tt == 2)
                    d.TinhTrang = "Đã giao hàng";

                ql.SaveChanges();
            }

            return RedirectToAction("GetAllOrder", "Donhang", new { page = page });
        }

        //POST: /Admin/Donhang/SortOrder
        [HttpPost]
        public ActionResult SortOrder(int dk, int page = 1)
        {
            int pageSz = 10;

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DONHANGs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                List<DONHANG> li = new List<DONHANG>();

                if (dk == 0)
                {
                    return RedirectToAction("GetAllOrder", "Donhang");
                }
                if (dk == 1)
                {
                    li = query.OrderBy(p => p.NgayDatHang).ToList();
                }
                if (dk == 2)
                {
                    li = query.OrderByDescending(p => p.NgayDatHang).ToList();
                }
                if (dk == 3)
                {
                    li = query.OrderBy(p => p.TongCong).ToList();
                }
                if (dk == 4)
                {
                    li = query.OrderByDescending(p => p.TongCong).ToList();
                }

                ViewBag.DK = dk;

                li = li.Skip((page - 1) * pageSz).Take(pageSz).ToList();
                return View("GetAllOrder", li);
            }

        }
    }
}