using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class submitVideo : System.Web.UI.Page
    {
        DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {
            Security sec = new Security();
            if (!sec.isLoggedIn)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                if (!IsPostBack)
                {

                }
            }
        }

        protected void btnSubmitVideo_Click(object sender, EventArgs e)
        {
            if (fuVideo.FileName != "")
            {
                Security sec = new Security();
                myDal = new DAL("spCreateVideo");
                myDal.addParm("username", sec.username);

                myDal.addParm("rating", rblMature.SelectedValue);
                myDal.addParm("postTitle", txtTitle.Text);
                myDal.addParm("postSubTitle", txtSubtitle.Text);
                myDal.addParm("videoLink", fuVideo.FileName);

                string videoLink = Server.MapPath(".") + "\\Video\\";
                string fileName = fuVideo.FileName;
                string pathAfile = videoLink + fileName;
                fuVideo.PostedFile.SaveAs(pathAfile);

                int postID = Convert.ToInt32(myDal.execScalar());

                Response.Redirect("Post.aspx?postID=" + postID + "&postType=video");
            }           
        }
    }
}