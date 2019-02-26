using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;


namespace TruphoxGP
{
    public partial class Register : System.Web.UI.Page
    {
        DAL myDal;
        DateTime dob { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text == txtpswRepeat.Text)
            {
                dob = Convert.ToDateTime(txtDOB.Text);

                myDal = new DAL("spCreateAccount");
                myDal.addParm("username", txtUsername.Text);
                myDal.addParm("userPassword", txtPassword.Text);
                myDal.addParm("email", txtEmail.Text);
                myDal.addParm("firstName", txtFirst.Text);
                myDal.addParm("lastName", txtLast.Text);
                myDal.addParm("dob", Convert.ToString(dob.Date));
                myDal.getDataSet();

                //Send email with confirmation link
                MailMessage emailMessage = new MailMessage();
                emailMessage.From = new MailAddress("truphox@gmail.com", "Truphox Admin");
                emailMessage.To.Add(new MailAddress(txtEmail.Text));
                emailMessage.Subject = "Confirmation Link";
                emailMessage.Body = "<h3>Welcome to Truphox!</h3><br>" + "";
                emailMessage.IsBodyHtml = true;
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new
                System.Net.NetworkCredential("truphox@gmail.com", "ilovephp");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Send(emailMessage);

                lblMessage.Text = "A confirmation email has been sent to the email address provided. Please activate your account through the link in the email.";
            }

            else
            {
                lblMessage.Text = "Password do not match. Please recheck your password.";
            }
            followTruphox(txtUsername.Text);            
        }

        private void followTruphox(string username)
        {
            Security sec = new Security();
            myDal = new DAL("spCreateFollow");
            myDal.addParm("username", username);
            myDal.addParm("followedUser", "Truphox");
        }
    }
}