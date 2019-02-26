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
    public partial class Recover : System.Web.UI.Page
    {
        DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRecover_Click(object sender, EventArgs e)
        {
            myDal = new DAL("spRecoverUsername");
            myDal.addParm("email", txtEmail.Text);
            DataSet ds = myDal.getDataSet();

            string message = ds.Tables[0].Rows[0]["message"].ToString();
            string username = ds.Tables[0].Rows[0]["username"].ToString();

            //Send email containing username if email is a match
            if (message == "VALID")
            {
                MailMessage emailMessage = new MailMessage();
                emailMessage.From = new MailAddress("truphox@gmail.com", "Truphox Admin");
                emailMessage.To.Add(new MailAddress(txtEmail.Text));
                emailMessage.Subject = "Username Recovery";
                emailMessage.Body = "You requested to recover your username. The username attached to the email account " + txtEmail.Text + " is " + username.ToString();
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new
                    System.Net.NetworkCredential("truphox@gmail.com", "ilovephp");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Send(emailMessage);

                lblMessage.Text = "Please check your email account for a message containing your username.";
            }
            else
            {
                lblMessage.Text = "No account is attached to this email.";
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            myDal = new DAL("spRecoverPassword");
            myDal.addParm("username", txtUsername.Text);
            DataSet ds = myDal.getDataSet();

            string message = ds.Tables[0].Rows[0]["MESSAGE"].ToString();
            string email = ds.Tables[0].Rows[0]["email"].ToString();

            //Send email containing reset password link if there is a match for username and email
            if (message == "VALID")
            {
                Guid recoveryGuid = Guid.NewGuid();

                myDal = new DAL("spInsertGuid");
                myDal.addParm("email", email);
                myDal.addParm("recoveryGuid", recoveryGuid.ToString());

                myDal.execNonQuery();

                MailMessage emailMessage = new MailMessage();
                emailMessage.From = new MailAddress("truphox@gmail.com", "Truphox Admin");
                emailMessage.To.Add(new MailAddress(email));
                emailMessage.Subject = "Password Reset";
                emailMessage.Body = "You have requested to reset your password. Please click the following link. http://localhost:63156/Reset.aspx?g=" + recoveryGuid.ToString();
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.Credentials = new
                       System.Net.NetworkCredential("truphox@gmail.com", "ilovephp");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Send(emailMessage);

                lblMessage.Text = "Please check your email account for a link to reset your password.";
            }
            else
            {
                lblMessage.Text = "No account is attached to this email and username.";
            }
        }
    }
}