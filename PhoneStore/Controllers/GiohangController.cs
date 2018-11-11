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
    public class GiohangController : Controller
    {
        // GET: Giohang/Index
        [LoginRequired(Permisson = "AKH")]
        public ActionResult Index(int err = 0)
        {
            Decimal total = 0;

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                List<CartItemModel> ls = new List<CartItemModel>();

                Cart cart = CurrentContext.GetCart();

                foreach (var item in cart.Items)
                {
                    DIENTHOAI x = ql.DIENTHOAIs.Where(p => p.MaDT == item.ProID).First();
                    Decimal amount = Convert.ToDecimal(item.Quantity * x.DonGia);

                    CartItemModel cim = new CartItemModel
                    {
                        item = item,
                        product = x,
                        Amount = amount
                    };

                    total += amount;

                    ls.Add(cim);
                }

                ViewBag.Total = total;
                if (err == -1) ViewBag.Err = "Có sản phẩm không đủ số lượng để bán.";
                if (err == 1) ViewBag.Err = "Đơn hàng đã được ghi nhận.";
                return View(ls);
            }
        }

        // POST: /Giohang/RemoveItem
        [HttpPost]
        public ActionResult RemoveItem(string proID)
        {
            CurrentContext.GetCart().RemoveItem(proID);
            return RedirectToAction("Index", "Giohang");
        }

        // POST: /Giohang/UpdateItem
        [HttpPost]
        public ActionResult UpdateItem(string proID, int quantity)
        {
            CurrentContext.GetCart().UpdateItem(proID, quantity);
            return RedirectToAction("Index", "Giohang");
        }

        // POST: /Cart/UpdateCartAll
        [HttpPost]
        public ActionResult UpdateCartAll(FormCollection f)
        {
            Cart cart = CurrentContext.GetCart();

            foreach (var item in cart.Items)
            {
                string sl = f["txtQuantity_" + item.ProID];
                int quantity = int.Parse(sl);
                CurrentContext.GetCart().UpdateItem(item.ProID, quantity);
            }
            return RedirectToAction("Index", "Giohang");
        }

        // POST: /Giohang/Checkout
        [HttpPost]
        public ActionResult Checkout(decimal total)
        {
            DONHANG dh = new DONHANG
            {
                NgayDatHang = DateTime.Now,
                NguoiDat = CurrentContext.GetCurAcc().TenKH,
                MaTK = CurrentContext.GetCurAcc().MaTK,
                TongCong = total,
                TinhTrang = "Chưa giao hàng"
            };

            Cart cart = CurrentContext.GetCart();

            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                foreach (CartItem item in cart.Items)
                {
                    DIENTHOAI dt = ql.DIENTHOAIs.Where(p => p.MaDT == item.ProID).FirstOrDefault();

                    if (dt.SLTon < item.Quantity)
                    {
                        return RedirectToAction("Index", "Giohang", new { err = -1 });
                    }
                }

                foreach (CartItem item in cart.Items)
                {
                    DIENTHOAI dt = ql.DIENTHOAIs.Where(p => p.MaDT == item.ProID).FirstOrDefault();

                    dt.SLTon -= item.Quantity;
                    dt.SLBan += item.Quantity;
                    ql.SaveChanges();

                    if (dt != null)
                    {
                        CHITIETDONHANG ct = new CHITIETDONHANG
                        {
                            MaDT = dt.MaDT,
                            SoLuong = item.Quantity,
                            DonGia = dt.DonGia,
                            ThanhTien = item.Quantity * dt.DonGia
                        };

                        dh.CHITIETDONHANG.Add(ct);
                    }
                }

                ql.DONHANGs.Add(dh);
                ql.SaveChanges();
            }

            CurrentContext.GetCart().Items.Clear();
            return RedirectToAction("Index", "Giohang", new { err = 1 });
        }

        // POST: /Giohang/AddToCart
        [HttpPost]
        public ActionResult AddToCart(CartItem item)
        {
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("Chitiet", "Dienthoai", new { id = item.ProID });
        }

        // POST: /Giohang/AddToCartAdHome
        [HttpPost]
        public ActionResult AddToCartAtHome(CartItem item)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("Index", "Home");
        }

        // POST: /Giohang/AddToCartAtType
        [HttpPost]
        public ActionResult AddToCartAtType(CartItem item, int typeid, int page)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("ByHang", "Dienthoai", new { id = typeid, page = page });
        }

        // POST: /Giohang/AddToCartAtNSX
        [HttpPost]
        public ActionResult AddToCartAtNSX(CartItem item, int nsxid, int page)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("ByNSX", "Dienthoai", new { id = nsxid, page = page });
        }

        // POST: /Giohang/AddToCartAtAllProduct
        [HttpPost]
        public ActionResult AddToCartAtAllProduct(CartItem item, int page)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("AllProduct", "Dienthoai", new { page = page });
        }

        // POST: /Giohang/AddToCartAtDetail
        [HttpPost]
        public ActionResult AddToCartAtDetail(CartItem item, string id)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("Chitiet", "Dienthoai", new { id = id });
        }

        // POST: /Giohang/ATCAtSearchName
        [HttpPost]
        public ActionResult ATCAtSearchName(CartItem item, string ten, int page)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("TimkiemTheoTen", "Dienthoai", new { Ten = ten, page = page });
        }

        //
        // POST: /Giohang/ATCAtSearchNC
        [HttpPost]
        public ActionResult ATCAtSearchNC(CartItem item, int hang, int nsx, int min, int max, int page)
        {
            item.Quantity = 1;
            CurrentContext.GetCart().Add(item);
            return RedirectToAction("TimkiemNC", "Dienthoai", new { Hang = hang, NSX = nsx, GiaMin = min, GiaMax = max, page = page });
        }

        // GET: /Giohang/GetAllOrder
        [LoginRequired(Permisson = "AKH")]
        public ActionResult GetAllOrder()
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                int matk = CurrentContext.GetCurAcc().MaTK;
                var li = ql.DONHANGs.Where(d => d.MaTK == matk).ToList();
                return View(li);
            }
        }

        // GET: /Giohang/GetDetailOrder
        [LoginRequired(Permisson = "AKH")]
        public ActionResult GetDetailOrder()
        {
            return RedirectToAction("GetAllOrder", "Giohang");
        }

        //
        // POST: /Giohang/GetDetailOrder
        [HttpPost]
        public ActionResult GetDetailOrder(int MaDH)
        {
            if (MaDH > 0)
            {
                List<OrderDetailModel> model = new List<OrderDetailModel>();
                using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
                {
                    var li = ql.CHITIETDONHANGs.Where(d => d.MaDH == MaDH).ToList();

                    foreach (var item in li)
                    {
                        OrderDetailModel odm = new OrderDetailModel();
                        DIENTHOAI dt = ql.DIENTHOAIs.Where(p => p.MaDT == item.MaDT).FirstOrDefault();
                        odm.dt = dt;
                        odm.Soluong = (int)item.SoLuong;
                        odm.ThanhTien = (int)item.ThanhTien;
                        odm.DonGia = (int)item.DonGia;

                        model.Add(odm);
                    }

                    ViewBag.MaDH = MaDH;
                    return View(model);
                }
            }
            else
            {
                return RedirectToAction("GetAllOrder", "Giohang");
            }
        }

        //POST: /Giohang/SortOrder
        [HttpPost]
        public ActionResult SortOrder(int dk)
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                int matk = CurrentContext.GetCurAcc().MaTK;

                var query = ql.DONHANGs.Where(d => d.MaTK == matk);

                List<DONHANG> li = new List<DONHANG>();

                if (dk == 0)
                {
                    return RedirectToAction("GetAllOrder", "Giohang");
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
                return View("GetAllOrder", li);
            }

        }
    }
}