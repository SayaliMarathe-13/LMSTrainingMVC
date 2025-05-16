using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication2.Controllers
{
    public class AuthenticationController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult SignUp()
        {
            return View();
        }
    }
}