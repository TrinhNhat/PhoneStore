using PhoneStore.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PhoneStore.Filters
{
    public class LoginRequiredAttribute: ActionFilterAttribute
    {
        public string Permisson { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (!CurrentContext.IsLogin() && Permisson=="AKH")
            {
                string controller = filterContext.RouteData.Values["controller"].ToString();
                string action = filterContext.RouteData.Values["action"].ToString();

                filterContext.Result = new RedirectResult(string.Format("~/Taikhoan/Dangnhap?retUrl=/{0}/{1}", controller, action));
            }

            if (!CurrentContext.IsLogin() && Permisson == "AAD")
            {
                string controller = filterContext.RouteData.Values["controller"].ToString();
                string action = filterContext.RouteData.Values["action"].ToString();

                filterContext.Result = new RedirectResult(string.Format("~/Admin/Login/Index?retUrl=/Admin/{0}/{1}", controller, action));
            }

            if (CurrentContext.IsLogin() == true)
            {
                if (CurrentContext.GetCurAcc().LoaiTK =="AAD")
                {

                }
                else if (CurrentContext.GetCurAcc().LoaiTK != Permisson)
                {
                    filterContext.Result = new HttpUnauthorizedResult();
                    return;
                }
                    //if (CurrentContext.GetCurAcc().LoaiTK != Permisson) Permission ="AKH,AAD"   <-->  Permission ="AKH" | "AAD"
                //    if (!Permisson.Contains(CurrentContext.GetCurAcc().LoaiTK)) //Kiểm tra loại tài khoản chứa trong Permission nếu không có k cho zo
                //{
                //    filterContext.Result = new HttpUnauthorizedResult();
                //    return;
                //}                      
            }

            base.OnActionExecuting(filterContext);
        }
    }
}