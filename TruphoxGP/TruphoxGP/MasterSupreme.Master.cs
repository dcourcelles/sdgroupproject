using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        //DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {
            Security sec = new Security();
            if (!sec.isLoggedIn)
            {
                pnlRegister.Visible = true;
                pnlLogin.Visible = true;
                pnlNotifications.Visible = false;
                pnlLogout.Visible = false;
                pnlSubmit.Visible = false;
            }
            else
            {
                if (!IsPostBack)
                {
                    pnlRegister.Visible = false;
                    pnlLogin.Visible = false;
                    pnlNotifications.Visible = true;
                    pnlLogout.Visible = true;
                    pnlSubmit.Visible = true;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
    }
}