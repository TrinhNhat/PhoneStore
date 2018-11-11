using PhoneStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Controllers
{
    public class HangDTController : Controller
    {
        // GET: HangDT
        public ActionResult PartialList()
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                List<HANGDIENTHOAI> list = ql.HANGDIENTHOAIs.ToList();
                return PartialView(list);
            }
        
        }
    }
}