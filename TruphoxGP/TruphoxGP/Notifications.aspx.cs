﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Notifications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security();
            if (!mySecurity.isLoggedIn)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}