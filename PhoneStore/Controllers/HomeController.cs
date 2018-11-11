using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home/Index
        public ActionResult Index()
        {
            MyViewModel my = new MyViewModel();

            using (QLPhoneStoreEntities ctx = new QLPhoneStoreEntities())
            {
                my.list1 = ctx.DIENTHOAIs.OrderByDescending(p => p.NgayNhap).Take(3).ToList();
                my.list2 = ctx.DIENTHOAIs.OrderByDescending(p => p.SLXem).Take(3).ToList();
                my.list3 = ctx.DIENTHOAIs.OrderByDescending(p => p.SLBan).Take(3).ToList();
                return View(my);
            }
        }
    }
}