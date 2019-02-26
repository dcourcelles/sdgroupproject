using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCookie();
            }
        }

        private void getCookie()
        {
            if (Request.Cookies["cookie"] != null)
            {
                txtUsername.Text = Request.Cookies["cookies"]["username"];
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Security mySecurity = new Security(txtUsername.Text, txtPassword.Text);
            if (mySecurity.isLoggedIn)
            {                
                if (chkRememberMe.Checked)
                {
                    saveUser();
                }

                Response.Redirect("Home.aspx");
            }
        }

        private void saveUser()
        {
            HttpCookie myCookie = new HttpCookie("cookie");
            myCookie.Expires = DateTime.Now.AddMinutes(120);
            myCookie["username"] = txtUsername.Text;
            Response.Cookies.Add(myCookie);
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnRecover_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recover.aspx");
        }
    }
}