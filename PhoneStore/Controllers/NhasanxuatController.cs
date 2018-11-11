using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneStore.Models;

namespace PhoneStore.Controllers
{
    public class NhasanxuatController : Controller
    {
        // GET: Nhasanxuat
        public ActionResult PartialList()
        {
            using (QLPhoneStoreEntities ql = new QLPhoneStoreEntities())
            {
                List<NHASANXUAT> list = ql.NHASANXUATs.ToList();
                return PartialView(list);
            }
              
        }
    }
}