using PhoneStore.Areas.Admin.Models;
using PhoneStore.Filters;
using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Areas.Admin.Controllers
{
    public class ProductController : Controller
    {
        // GET: Admin/Product/GetAllProduct
        [LoginRequired(Permisson = "AAD")]
        public ActionResult GetAllProduct(int page = 1)
        {
            int pageSz = 10;

            List<EditProductModel> model = new List<EditProductModel>();
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                var li = query.OrderBy(p => p.MaDT).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                foreach (var i in li)
                {
                    HANGDIENTHOAI lx = ql.HANGDIENTHOAIs.Where(p => p.MaHang == i.MaHang).FirstOrDefault();
                    NHASANXUAT nsx = ql.NHASANXUATs.Where(p => p.MaNSX == i.MaNSX).FirstOrDefault();

                    EditProductModel pro = new EditProductModel
                    {
                        MaDT = i.MaDT,
                        TenDT = i.TenDT,
                        NgayNhap = (DateTime)i.NgayNhap,
                        SLTon = (int)i.SLTon,
                        DonGia = (int)i.DonGia,
                        TenHang = lx.TenHang,
                        TenNSX = nsx.TenNSX
                    };

                    model.Add(pro);
                }

                return View(model);
            }
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/AddProduct
        public ActionResult AddProduct()
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var li = ql.NHASANXUATs.ToList();
                var ls = ql.HANGDIENTHOAIs.ToList();

                ViewBag.Hang = ls;
                ViewBag.Nsx = li;

                return View();
            }
        }

        //
        //POST: /Admin/AddProduct
        [HttpPost]
        public ActionResult AddProduct(DIENTHOAI dt, HttpPostedFileBase fuHinhNho, HttpPostedFileBase fuHinhLon)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                if (string.IsNullOrEmpty(dt.MotaDai)) dt.MotaDai = "Không có mô tả";
                if (string.IsNullOrEmpty(dt.MotaNgan)) dt.MotaNgan = "Không có mô tả";

                int d = ql.DIENTHOAIs.Count();
                string madt = "DT";
                if (d >= 100) madt += (d + 1).ToString();
                if (d >= 10 && d < 100) madt = madt + "0" + (d + 1).ToString();
                if (d < 10 && d > 0) madt = madt + "00" + (d + 1).ToString();


                dt.MaDT = madt;
                dt.SLBan = 0;
                dt.SLXem = 0;
                dt.NgayNhap = DateTime.Now;

                ql.DIENTHOAIs.Add(dt);
                ql.SaveChanges();

                var li = ql.NHASANXUATs.ToList();
                var ls = ql.HANGDIENTHOAIs.ToList();

                ViewBag.Hang = ls;
                ViewBag.Nsx = li;
            }

            if (fuHinhNho != null && fuHinhNho.ContentLength > 0 && fuHinhLon != null && fuHinhLon.ContentLength > 0)
            {
                string spDirtPath = Server.MapPath("~/Images/Products");
                string targetDirPath = Path.Combine(spDirtPath, dt.MaDT);
                Directory.CreateDirectory(targetDirPath);

                string smFileName = Path.Combine(targetDirPath, "sm.jpg");
                fuHinhNho.SaveAs(smFileName);

                string lgFileName = Path.Combine(targetDirPath, "lg.png");
                fuHinhLon.SaveAs(lgFileName);
            }

            ViewBag.Added = true;
            return View();
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/Product/RemoveProduct
        public ActionResult RemoveProduct(string madt)
        {
            if (madt == null)
            {
                return RedirectToAction("GetAllProduct", "Product");
            }
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                DIENTHOAI dt = ql.DIENTHOAIs.Where(p => p.MaDT == madt).FirstOrDefault();

                return View(dt);
            }
        }

        //
        //POST: /Admin/Product/RemoveProduct
        [HttpPost]
        public ActionResult RemoveProduct(DIENTHOAI dt)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                DIENTHOAI x = ql.DIENTHOAIs.Where(p => p.MaDT == dt.MaDT).FirstOrDefault();

                List<CHITIETDONHANG> ls = ql.CHITIETDONHANGs.Where(p => p.MaDT == x.MaDT).ToList();

                foreach (var i in ls)
                {
                    ql.CHITIETDONHANGs.Remove(i);
                }

                ql.DIENTHOAIs.Remove(x);
                ql.SaveChanges();
            }

            //Xóa thư mục chứa hình ảnh
            string spDirtPath = Server.MapPath("~/Images/Products");
            string targetDirPath = Path.Combine(spDirtPath, dt.MaDT);
            DirectoryInfo dirdelete = new DirectoryInfo(targetDirPath);
            if (dirdelete.Exists)
            {
                foreach (FileInfo file in dirdelete.GetFiles())
                {
                    file.Delete();
                }

                Directory.Delete(targetDirPath);
            }

            return View();
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/Product/EditProduct
        public ActionResult EditProduct(string madt)
        {
            if (madt == null)
            {
                return RedirectToAction("GetAllProduct", "Product");
            }

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                DIENTHOAI pro = ql.DIENTHOAIs.Where(p => p.MaDT == madt).FirstOrDefault();
                var li = ql.NHASANXUATs.ToList();
                var ls = ql.HANGDIENTHOAIs.ToList();

                ViewBag.Hang = ls;
                ViewBag.Nsx = li;

                return View(pro);
            }
        }

        //POST: /Admin/Product/EditProduct
        [HttpPost]
        public ActionResult EditProduct(DIENTHOAI dt, HttpPostedFileBase fuHinhNho, HttpPostedFileBase fuHinhLon)
        {
            using (QLPhoneStoreEntities ctx = new QLPhoneStoreEntities())
            {
                ctx.Entry(dt).State = System.Data.Entity.EntityState.Modified;
                ctx.SaveChanges();

                var li = ctx.NHASANXUATs.ToList();
                var ls = ctx.HANGDIENTHOAIs.ToList();

                ViewBag.Hang = ls;
                ViewBag.Nsx = li;
            }

            if (fuHinhNho != null && fuHinhNho.ContentLength > 0 && fuHinhLon != null && fuHinhLon.ContentLength > 0)
            {
                string spDirtPath = Server.MapPath("~/Images/Products");
                string targetDirPath = Path.Combine(spDirtPath, dt.MaDT);
                Directory.CreateDirectory(targetDirPath);

                string smFileName = Path.Combine(targetDirPath, "sm.jpg");
                fuHinhNho.SaveAs(smFileName);

                string lgFileName = Path.Combine(targetDirPath, "lg.png");
                fuHinhLon.SaveAs(lgFileName);
            }

            ViewBag.Added = true;
            return View(dt);
        }

        [LoginRequired(Permisson = "AAD")]
        //
        //GET: /Admin/Product/SortOrderPro
        public ActionResult SortOrderPro(int dk = 0, int page = 1)
        {
            int pageSz = 10;

            List<EditProductModel> model = new List<EditProductModel>();
            if (dk == 0)
            {
                using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
                {
                    var query = ql.DIENTHOAIs;

                    int count = query.Count();
                    int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                    ViewBag.PageCount = npage;
                    ViewBag.CurPage = page;

                    var li = query.OrderBy(p => p.MaDT).Skip((page - 1) * pageSz).Take(pageSz).ToList();

                    foreach (var i in li)
                    {
                        HANGDIENTHOAI lx = ql.HANGDIENTHOAIs.Where(p => p.MaHang == i.MaHang).FirstOrDefault();
                        NHASANXUAT nsx = ql.NHASANXUATs.Where(p => p.MaNSX == i.MaNSX).FirstOrDefault();

                        EditProductModel pro = new EditProductModel
                        {
                            MaDT = i.MaDT,
                            TenDT = i.TenDT,
                            NgayNhap = (DateTime)i.NgayNhap,
                            SLTon = (int)i.SLTon,
                            DonGia = (int)i.DonGia,
                            TenHang = lx.TenHang,
                            TenNSX = nsx.TenNSX
                        };

                        model.Add(pro);
                    }

                    return View(model);
                }
            }
            else
            {
                using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
                {
                    var query = ql.DIENTHOAIs;

                    int count = query.Count();
                    int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                    ViewBag.PageCount = npage;
                    ViewBag.CurPage = page;

                    List<DIENTHOAI> li = new List<DIENTHOAI>();

                    if (dk == 1)
                    {
                        li = query.OrderBy(p => p.NgayNhap).ToList();
                    }
                    if (dk == 2)
                    {
                        li = query.OrderByDescending(p => p.NgayNhap).ToList();
                    }
                    if (dk == 3)
                    {
                        li = query.OrderBy(p => p.SLTon).ToList();
                    }
                    if (dk == 4)
                    {
                        li = query.OrderByDescending(p => p.SLTon).ToList();
                    }
                    if (dk == 5)
                    {
                        li = query.OrderBy(p => p.DonGia).ToList();
                    }
                    if (dk == 6)
                    {
                        li = query.OrderByDescending(p => p.DonGia).ToList();
                    }

                    ViewBag.DK = dk;

                    li = li.Skip((page - 1) * pageSz).Take(pageSz).ToList();

                    foreach (var i in li)
                    {
                        HANGDIENTHOAI lx = ql.HANGDIENTHOAIs.Where(p => p.MaHang == i.MaHang).FirstOrDefault();
                        NHASANXUAT nsx = ql.NHASANXUATs.Where(p => p.MaNSX == i.MaNSX).FirstOrDefault();

                        EditProductModel pro = new EditProductModel
                        {
                            MaDT = i.MaDT,
                            TenDT = i.TenDT,
                            NgayNhap = (DateTime)i.NgayNhap,
                            SLTon = (int)i.SLTon,
                            DonGia = (int)i.DonGia,
                            TenHang = lx.TenHang,
                            TenNSX = nsx.TenNSX
                        };

                        model.Add(pro);
                    }
                    return View(model);
                }
            }
        }

        //POST: /Admin/Product/SortOrderPro
        [HttpPost]
        public ActionResult SortOrderPro(int dk)
        {
            int pageSz = 10;
            int page = 1;

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                var query = ql.DIENTHOAIs;

                int count = query.Count();
                int npage = count / pageSz + (count % pageSz > 0 ? 1 : 0);

                ViewBag.PageCount = npage;
                ViewBag.CurPage = page;

                List<DIENTHOAI> li = new List<DIENTHOAI>();
                List<EditProductModel> model = new List<EditProductModel>();
                if (dk == 0)
                {
                    return RedirectToAction("GetAllProduct", "Product");
                }
                if (dk == 1)
                {
                    li = query.OrderBy(p => p.NgayNhap).ToList();
                }
                if (dk == 2)
                {
                    li = query.OrderByDescending(p => p.NgayNhap).ToList();
                }
                if (dk == 3)
                {
                    li = query.OrderBy(p => p.SLTon).ToList();
                }
                if (dk == 4)
                {
                    li = query.OrderByDescending(p => p.SLTon).ToList();
                }
                if (dk == 5)
                {
                    li = query.OrderBy(p => p.DonGia).ToList();
                }
                if (dk == 6)
                {
                    li = query.OrderByDescending(p => p.DonGia).ToList();
                }

                ViewBag.DK = dk;

                li = li.Skip((page - 1) * pageSz).Take(pageSz).ToList();

                foreach (var i in li)
                {
                    HANGDIENTHOAI lx = ql.HANGDIENTHOAIs.Where(p => p.MaHang == i.MaHang).FirstOrDefault();
                    NHASANXUAT nsx = ql.NHASANXUATs.Where(p => p.MaNSX == i.MaNSX).FirstOrDefault();

                    EditProductModel pro = new EditProductModel
                    {
                        MaDT = i.MaDT,
                        TenDT = i.TenDT,
                        NgayNhap = (DateTime)i.NgayNhap,
                        SLTon = (int)i.SLTon,
                        DonGia = (int)i.DonGia,
                        TenHang = lx.TenHang,
                        TenNSX = nsx.TenNSX
                    };

                    model.Add(pro);
                }
                return View("SortOrderPro", model);
            }

        }

    }
}