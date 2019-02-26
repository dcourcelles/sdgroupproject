using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class viewProfile : System.Web.UI.Page
    {
        DAL myDal;
        string viewUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            viewUser = Request.QueryString["followedUser"].ToString();

            if (!IsPostBack)
            {
                if (Request.QueryString["followedUser"] != null)
                {
                    viewUser = Request.QueryString["followedUser"].ToString();
                    loadOtherUser(viewUser);
                    loadRecentlyAdded(viewUser);
                    loadArt(viewUser);
                    loadPhotography(viewUser);
                    loadWriting(viewUser);
                    loadVideo(viewUser);
                    loadFollowed(viewUser);
                }
                else
                {

                }
            }
        }
        private void loadOtherUser(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadAccount");
            myDal.addParm("username", viewUser);
            DataSet ds = myDal.getDataSet();

            imgProfilePicture.ImageUrl = "./Images/" + ds.Tables[0].Rows[0]["profileImage"].ToString();

            lblUsername.Text = ds.Tables[0].Rows[0]["username"].ToString();
            lblFirstName.Text = ds.Tables[0].Rows[0]["firstName"].ToString();
            lblLastName.Text = ds.Tables[0].Rows[0]["lastName"].ToString();
            txtBio.Text = ds.Tables[0].Rows[0]["bio"].ToString();
            lblDOB.Text = ds.Tables[0].Rows[0]["dob"].ToString();
            lblEmail.Text = ds.Tables[0].Rows[0]["email"].ToString();
            lblDateJoined.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["joinDate"]).ToString();
        }
        private void loadRecentlyAdded(string viewUser)
        {
            Security sec = new Security();

            myDal = new DAL("spRecentlyAdded");
            myDal.addParm("username", viewUser);

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
                lblpostID.Text= "Nothing here yet";
                lblpostID2.Text = "Nothing here yet";
                lblpostID3.Text = "Nothing here yet";
            }
        }
        private void loadArt(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserArt");
            myDal.addParm("username", viewUser);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlArt.DataSource = dtA;
            dlArt.DataBind();
        }
        private void loadPhotography(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserPhotography");
            myDal.addParm("username", viewUser);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlPhotots.DataSource = dtA;
            dlPhotots.DataBind();
        }
        private void loadWriting(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserWriting");
            myDal.addParm("username", viewUser);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlWriting.DataSource = dtA;
            dlWriting.DataBind();
        }
        private void loadVideo(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadUserVideo");
            myDal.addParm("username", viewUser);

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlVideos.DataSource = dtA;
            dlVideos.DataBind();
        }
        private void loadFollowed(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spReadFollow");
            myDal.addParm("username", viewUser);
            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlFollowing.DataSource = dtA;
            dlFollowing.DataBind();
        }

        protected void dlArt_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlArt.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
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

        protected void dlVideos_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlVideos.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=writing");
            }
        }

        protected void dlWriting_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlWriting.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=video");
            }
        }
        protected void btnFollow_Click(object sender, EventArgs e)
        {            
            followUser(viewUser);            
        }

        private void followUser(string ViewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spCreateFollow");
            myDal.addParm("username", sec.username);
            myDal.addParm("followedUser", ViewUser);
            
            string message = myDal.execScalar();

            if (message == "followed")
            {
               btnFollow.Text = "Followed";
               followNofitication(ViewUser);
            }   

           else if (message == "unfollowed")
            {
                btnFollow.Text = "Follow";
                //unfollowNotification(viewUser);
            }
        }

        private void followNofitication(string ViewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spCreateNotification");
            myDal.addParm("username", ViewUser);
            myDal.addParm("notificationText", sec.username + " is following you.");
            myDal.execNonQuery();
        }

        //private void unfollowNotification(string viewUser)
        //{
        //    Security sec = new Security();
        //    myDal = new DAL("spCreateNotification");
        //    myDal.addParm("username", viewUser);
        //    myDal.addParm("notificationText", sec.username + " is no longer following you.");
        //    myDal.execNonQuery();
        //}

        protected void dlFollowing_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string otherProfile = Convert.ToString(dlFollowing.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("viewProfile.aspx?followedUser=" + otherProfile);
            }
        }

        protected void btnBlock_Click(object sender, EventArgs e)
        {
            blockUser(viewUser);       
        }

        private void blockUser(string viewUser)
        {
            Security sec = new Security();
            myDal = new DAL("spCreateBlock");
            myDal.addParm("username", sec.username);
            myDal.addParm("blockedUser", viewUser);
            string message = myDal.execScalar();

            if (message == "blocked")
            {
                btnBlock.Text = "Unblock";
            }
            else if (message == "unblocked")
            {
                btnBlock.Text = "Block";
            }
        }
    }
}