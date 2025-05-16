using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication2.Controllers
{
    public class HomeController : Controller
    {

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult AboutUs()
        {
            return View();
        }
        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult Error()
        {
            return View("~/Views/Shared/Error.cshtml");
        }
    }
}