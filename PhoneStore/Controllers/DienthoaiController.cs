using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneStore.Models;
using System.Configuration;

namespace PhoneStore.Controllers
{
    public class DienthoaiController : Controller
    {
        // GET: Dienthoai/ByHang/{id}
        public ActionResult ByHang(int? id, int page =1)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("Index", "Home");
            }

            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs.Where(x => x.MaHang == id);
                int count = query.Count();
                int nPages = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = nPages;
                ViewBag.CurPage = page;           
                ViewBag.MaHang = id;

                List<DIENTHOAI> list = query.OrderBy(p=> p.MaDT)
                    .Skip((page -1)* pageSz)
                    .Take(pageSz).ToList();

                HANGDIENTHOAI hdt = ql.HANGDIENTHOAIs.Where(y => y.MaHang == id).FirstOrDefault();
                ViewBag.Hdt = hdt.TenHang;

                return View(list);
            }             
        }

        // GET: Dienthoai/ByNSX/{id}
        public ActionResult ByNSX(int? id, int page = 1)
        {
            if (id.HasValue == false)
            {
                return RedirectToAction("Index", "Home");
            }

            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs.Where(x => x.MaNSX == id);
                int count = query.Count();
                int nPages = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = nPages;
                ViewBag.CurPage = page;
                ViewBag.MaNSX = id;

                List<DIENTHOAI> list = query.OrderBy(p => p.MaDT)
                    .Skip((page - 1) * pageSz)
                    .Take(pageSz).ToList();

                NHASANXUAT nsx = ql.NHASANXUATs.Where(y => y.MaNSX == id).FirstOrDefault();
                ViewBag.nsx = nsx.TenNSX;

                return View(list);
            }
        }

        // GET: Dienthoai/Chitiet/{id}
        public ActionResult Chitiet(string id)
        {
            if (id == null)
            {
                return RedirectToAction("Index", "Home");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                DIENTHOAI dt = ql.DIENTHOAIs.Where(x => x.MaDT == id).FirstOrDefault();
                dt.SLXem++;
                ql.SaveChanges();

                NHASANXUAT nsx = ql.NHASANXUATs.Where(n => n.MaNSX == dt.MaNSX).FirstOrDefault();
                HANGDIENTHOAI h = ql.HANGDIENTHOAIs.Where(m => m.MaHang == dt.MaHang).FirstOrDefault();

                //Dùng skip phải dùng orderby -Lấy ra 3 sản phẩm cùng hãng trừ sản phẩm đang xem 
                List<DIENTHOAI> DSHang = ql.DIENTHOAIs.Where(p => p.MaHang == dt.MaHang)
                    .OrderBy(y => y.MaDT)               
                    .Take(3).ToList();
                List<DIENTHOAI> DSNSX = ql.DIENTHOAIs.Where(p => p.MaNSX == dt.MaNSX).OrderBy(y =>y.MaDT).Take(3).ToList();

                ViewBag.hang = h.TenHang;
                ViewBag.nsx = nsx.TenNSX;
                ViewBag.qg = nsx.QuocGia;

                ViewBag.dshang = DSHang;
                ViewBag.dsnsx = DSNSX;

                return View(dt);
            }
        }

        // GET: /Dienthoai/AllProduct
        public ActionResult AllProduct(int page = 1)
        {

            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = ql.DIENTHOAIs.OrderBy(p => p.MaDT).Skip((page - 1) * pageSz).Take(pageSz).ToList();
                return View(li);
            }
        }

        // GET: /Dienthoai/TimkiemTheoTen
        public ActionResult TimkiemTheoTen(string Ten, int page = 1)
        {
            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs.Where(p => p.TenDT.Contains(Ten));

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;
                ViewBag.KW = Ten;

                var li = query.OrderBy(p => p.MaDT).Skip((page - 1) * pageSz).Take(pageSz).ToList();
                return View(li);
            }
        }

        //
        // POST: /Product/TimkiemTheoTen
        [HttpPost]
        public ActionResult TimkiemTheoTen(string Ten)
        {
            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs.Where(p => p.TenDT.Contains(Ten));

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = 1;
                ViewBag.KW = Ten;

                var li = query.OrderBy(p => p.MaDT).Skip((1 - 1) * pageSz).Take(pageSz).ToList();
                return View(li);
            }
        }

        // GET: /Dienthoai/TimkiemNC
        public ActionResult TimkiemNC(int Hang = 0, int NSX = 0, int GiaMin = -1, int GiaMax = -1, int page = 1)
        {
            SearchModel model = new SearchModel();
            model.Hang = Hang;
            model.NSX = NSX;
            model.GiaMax = GiaMax;
            model.GiaMin = GiaMin;

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                model.lt = ql.HANGDIENTHOAIs.ToList();
                model.ln = ql.NHASANXUATs.ToList();

                if (Hang == 0 && NSX == 0)
                {
                    return View(model);
                }
                else
                {
                    int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

                    var query = ql.DIENTHOAIs.Where(p => p.MaDT == "");

                    if (Hang > 0 && NSX > 0 && GiaMin > -1 && GiaMax > -1)
                    {
                        query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang && p.MaNSX == NSX && p.DonGia >= GiaMin && p.DonGia <= GiaMax);
                    }
                    else
                    {
                        if (Hang > 0 && NSX == 0 && GiaMin > -1 && GiaMax > -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang && p.DonGia >= GiaMin && p.DonGia <= GiaMax);
                        }
                        else
                        {
                            if (Hang > 0 && NSX == 0 && (GiaMin == -1 || GiaMin == 0) && GiaMax == -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang);
                            }

                            if (Hang == 0 && NSX > 0 && (GiaMin == -1 || GiaMin == 0) && GiaMax == -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaNSX == NSX);
                            }

                            if (Hang > 0 && NSX > 0 && (GiaMin == -1 || GiaMin == 0) && GiaMax == -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang && p.MaNSX == NSX);
                            }

                            if (Hang > 0 && NSX == 0 && (GiaMin == -1 || GiaMin == 0) && GiaMax > -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang && p.DonGia < GiaMax);
                            }

                            if (Hang > 0 && NSX == 0 && GiaMin > -1 && GiaMax == -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaHang == Hang && p.DonGia > GiaMin);
                            }

                            if (Hang == 0 && NSX > 0 && (GiaMin == -1 || GiaMin == 0) && GiaMax > -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaNSX == NSX && p.DonGia < GiaMax);
                            }

                            if (Hang == 0 && NSX > 0 && GiaMin > -1 && GiaMax == -1)
                            {
                                query = ql.DIENTHOAIs.Where(p => p.MaNSX == NSX && p.DonGia > GiaMin);
                            }
                        }
                    }

                    int count = query.Count();
                    int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                    ViewBag.PageCount = npage;
                    ViewBag.CurPage = page;

                    model.dt = query.OrderBy(p => p.MaDT).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                    return View(model);
                }
            }
        }

        // POST: /Dienthoai/TimkiemNC
        [HttpPost]
        public ActionResult TimkiemNC(SearchModel model)
        {
            int pageSz = Convert.ToInt32(ConfigurationManager.AppSettings["PageSize"]);

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                model.lt = ql.HANGDIENTHOAIs.ToList();
                model.ln = ql.NHASANXUATs.ToList();

                if (model.Hang == 0 && model.NSX == 0)
                {
                    ViewBag.Err = "Chưa chọn thông tin tìm kiếm !";
                    return View(model);
                }

                var query = ql.DIENTHOAIs.Where(p => p.MaDT == "");

                if (model.Hang > 0 && model.NSX > 0 && model.GiaMin > -1 && model.GiaMax > -1)
                {
                    query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang && p.MaNSX == model.NSX && p.DonGia >= model.GiaMin && p.DonGia <= model.GiaMax);
                }
                else
                {
                    if (model.Hang > 0 && model.NSX == 0 && model.GiaMin > -1 && model.GiaMax > -1)
                    {
                        query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang && p.DonGia >= model.GiaMin && p.DonGia <= model.GiaMax);
                    }
                    else
                    {
                        if (model.Hang > 0 && model.NSX == 0 && (model.GiaMin == -1 || model.GiaMin == 0) && model.GiaMax == -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang);
                        }

                        if (model.Hang == 0 && model.NSX > 0 && (model.GiaMin == -1 || model.GiaMin == 0) && model.GiaMax == -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaNSX == model.NSX);
                        }

                        if (model.Hang > 0 && model.NSX > 0 && (model.GiaMin == -1 || model.GiaMin == 0) && model.GiaMax == -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang && p.MaNSX == model.NSX);
                        }

                        if (model.Hang > 0 && model.NSX == 0 && (model.GiaMin == -1 || model.GiaMin == 0) && model.GiaMax > -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang && p.DonGia < model.GiaMax);
                        }

                        if (model.Hang > 0 && model.NSX == 0 && model.GiaMin > -1 && model.GiaMax == -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaHang == model.Hang && p.DonGia > model.GiaMin);
                        }

                        if (model.Hang == 0 && model.NSX > 0 && (model.GiaMin == -1 || model.GiaMin == 0) && model.GiaMax > -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaNSX == model.NSX && p.DonGia < model.GiaMax);
                        }

                        if (model.Hang == 0 && model.NSX > 0 && model.GiaMin > -1 && model.GiaMax == -1)
                        {
                            query = ql.DIENTHOAIs.Where(p => p.MaNSX == model.NSX && p.DonGia > model.GiaMin);
                        }
                    }
                }

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = 1;

                model.dt = query.OrderBy(p => p.MaDT).Skip((1 - 1) * pageSz).Take(pageSz).ToList();

                return View(model);
            }
        }
    }
}