using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace TruphoxGP
{
    public partial class Reset : System.Web.UI.Page
    {
        DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        private void validChheck()
        {
            //retrive guid
            string guid = Request.QueryString["g"].ToString();

            //check to see if guid matches
            myDal = new DAL("spValidCheck");
            myDal.addParm("recoveryGuid", guid.ToString());
            DataSet ds = myDal.getDataSet();

            string message = ds.Tables[0].Rows[0]["MESSAGE"].ToString();
            lblUsername.Text = ds.Tables[0].Rows[0]["customerUsername"].ToString();

            //if guid does not match or no guid provided, return to login
            if (message == "VALID")
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text == txtRetypePassword.Text)
            {
                myDal = new DAL("spResetPassword");
                myDal.addParm("username", lblUsername.Text);
                myDal.addParm("userPassword", txtNewPassword.Text);
                myDal.execNonQuery();

                lblMessage.Text = "Password reset successfully.";
                btnHome.Visible = true;
                pnlReset.Visible = false;
            }

            else
            {
                lblMessage.Text = "Passwords do not match. Please re-enter password.";
            }
        }
    }
}