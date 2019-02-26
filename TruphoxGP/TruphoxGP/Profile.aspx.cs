using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TruphoxGP;
using System.Data;
using System.Web.Security;
using System.Data.SqlClient;

namespace TruphoxGP
{
    public partial class Profile : System.Web.UI.Page
    {
        DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {
            Security mySecurity = new Security();
            if (!mySecurity.isLoggedIn)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    loadUser();
                    loadRecentlyAdded();
                    loadArt();
                    loadPhotography();
                    loadWriting();
                    loadVideo();
                    loadFollow();
                }
            }
        }
        private void loadUser()
        {
            Security sec = new Security();
            myDal = new DAL("spReadAccount");
            myDal.addParm("username", sec.username);
            DataSet ds = myDal.getDataSet();

            imgProfilePicture.ImageUrl = "./Images/" + ds.Tables[0].Rows[0]["profileImage"].ToString();

            lblUsername.Text = HttpContext.Current.Session["username"].ToString();
            lblFirstName.Text = ds.Tables[0].Rows[0]["firstName"].ToString();
            lblLastName.Text = ds.Tables[0].Rows[0]["lastName"].ToString();
            txtBio.Text = ds.Tables[0].Rows[0]["bio"].ToString();
            lblDOB.Text = ds.Tables[0].Rows[0]["dob"].ToString();
            lblEmail.Text = ds.Tables[0].Rows[0]["email"].ToString();
            lblDateJoined.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["joinDate"]).ToString();
        }

        private void loadRecentlyAdded()
        {
            Security sec = new Security();

            myDal = new DAL("spRecentlyAdded");
            myDal.addParm("username", sec.username);

            DataSet ds = myDal.getDataSet();
            try
            {
                lblpostID.Text = ds.Tables[0].Rows[0]["postID"].ToString();
                lblTitle.Text = ds.Tables[0].Rows[0]["postTitle"].ToString();
                lblSubTitle.Text = ds.Tables[0].Rows[0]["postSubTitle"].ToString();
                lblDateCreated.Text = ds.Tables[0].Rows[0]["postDate"].ToString();

                lblpostID2.Text = ds.Tables[0].Rows[1]["postID"].ToString();
                lblTitle2.Text = ds.Tables[0].Rows[1]["postTitle"].ToString();
                lblSubTitle2.Text = ds.Tables[0].Rows[1]["postSubTitle"].ToString();
                lblDateCreated2.Text = ds.Tables[0].Rows[1]["postDate"].ToString();

                lblpostID3.Text = ds.Tables[0].Rows[2]["postID"].ToString();
                lblTitle3.Text = ds.Tables[0].Rows[2]["postTitle"].ToString();
                lblSubTitle3.Text = ds.Tables[0].Rows[2]["postSubTitle"].ToString();
                lblDateCreated3.Text = ds.Tables[0].Rows[2]["postDate"].ToString();
            }
            catch
            {
                lblpostID.Text = "Nothing here yet";
                lblpostID2.Text = "Nothing here yet";
                lblpostID3.Text = "Nothing here yet";
            }
        }

        private void loadArt()
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserArt");
            myDal.addParm("username", sec.username);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlArt.DataSource = dtA;
            dlArt.DataBind();
        }

        private void loadPhotography()
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserPhotography");
            myDal.addParm("username", sec.username);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlPhotots.DataSource = dtA;
            dlPhotots.DataBind();
        }
        private void loadVideo()
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserVideo");
            myDal.addParm("username", sec.username);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlVideos.DataSource = dtA;
            dlVideos.DataBind();
        }

        private void loadWriting()
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserWriting");
            myDal.addParm("username", sec.username);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlWriting.DataSource = dtA;
            dlWriting.DataBind();
        }

        protected void dlArt_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlArt.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                //string postDet = ("Post.aspx?postID=" + itemID.ToString() + "postType=artwork");               
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=artwork");
            }
        }

        protected void dlPhotots_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlPhotots.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=photography");
            }
        }

        protected void dlWriting_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlWriting.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=writing");
            }
        }

        protected void dlVideos_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlVideos.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=video");
            }
        }
        private void loadFollow()
        {
            Security sec = new Security();
            myDal = new DAL("spReadFollow");
            myDal.addParm("username", sec.username);
            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlFollowing.DataSource = dtA;
            dlFollowing.DataBind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = true;
            pnlImgChanges.Visible = false;

            Security sec = new Security();
            myDal = new DAL("spReadAccount");
            myDal.addParm("username", sec.username);
            DataSet ds = myDal.getDataSet();

            lblUsernameEdit.Text = HttpContext.Current.Session["username"].ToString();
            txtPassEdit.Text = ds.Tables[0].Rows[0]["userPassword"].ToString();
            txtPassConfirm.Text = ds.Tables[0].Rows[0]["userPassword"].ToString();

            txtFirstNameEdit.Text = ds.Tables[0].Rows[0]["firstName"].ToString();
            txtLastNameEdit.Text = ds.Tables[0].Rows[0]["lastName"].ToString();
            txtBioEdit.Text = ds.Tables[0].Rows[0]["bio"].ToString();
            txtDOBEdit.Text = ds.Tables[0].Rows[0]["dob"].ToString();
            txtEmailEdit.Text = ds.Tables[0].Rows[0]["email"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Security sec = new Security();
            myDal = new DAL("spUpdateAccount");
            myDal.addParm("username", sec.username);

            myDal.addParm("firstName", txtFirstNameEdit.Text);
            myDal.addParm("lastName", txtLastNameEdit.Text);
            myDal.addParm("bio", txtBioEdit.Text);
            myDal.addParm("dob", txtDOBEdit.Text);
            myDal.addParm("email", txtEmailEdit.Text);
            myDal.addParm("userPassword", txtPassConfirm.Text);

            DataSet ds = myDal.getDataSet();
            loadUser();
            pnlEdit.Visible = false;
        }

        protected void btnPictureEdit_Click(object sender, EventArgs e)
        {
            pnlImgChanges.Visible = true;
            pnlEdit.Visible = false;
        }

        protected void btnSaveProfilePicture_Click(object sender, EventArgs e)
        {
            Security sec = new Security();

            myDal = new DAL("spUpdateProfilePict");
            myDal.addParm("username", sec.username);
            myDal.addParm("profileImage", fuProfileImage.FileName);

            string profileImage = Server.MapPath(".") + "\\Images\\";
            string fileName = fuProfileImage.FileName;
            string pathAfile = profileImage + fileName;
            fuProfileImage.PostedFile.SaveAs(pathAfile);

            DataSet ds = myDal.getDataSet();

            loadUser();
            pnlImgChanges.Visible = false;

        }

        protected void dlFollowing_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string viewUser = dlFollowing.DataKeys[e.Item.ItemIndex].ToString();

            if (e.CommandName == "Select")
            {
                Response.Redirect("viewProfile.aspx?followedUser=" + viewUser);
            }
        }
    }
}