using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class PhoxFourms : System.Web.UI.Page
    {
        DAL myDal;
        protected void Page_Load(object sender, EventArgs e)
        {
            Security sec = new Security();
            if (!sec.isLoggedIn)
            {
                pnlLoginDiv.Visible = true;
                btnCreate.Visible = false;
            }
            else
            {
                if (!IsPostBack)
                {
                    pnlLoginDiv.Visible = false;
                    loadgvForum();
                    loadgvUnion();
                }
            }
        }

        private void loadgvForum()
        {
           myDal = new DAL("spReadForums");
           DataSet ds = myDal.getDataSet();
           DataTable dtA = ds.Tables[0];

            gvForum.DataSource = dtA;
            gvForum.DataBind();

        }

        private void loadgvUnion()
        {
            myDal = new DAL("spPhoxUnion");
            myDal.addParm("input", "");

            DataSet ds = myDal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlUnion.DataSource = dtA;
            dlUnion.DataBind();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void rblMature_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblMature.SelectedIndex.ToString() == "Yes" )
            {
                lblMature.Visible = true;
            }
            else
            {
                lblMature.Visible = false;
            }
        }

        protected void btnSubmitForum_Click(object sender, EventArgs e)
        {
            createForum();
            pnlcreateForum.Visible = false;
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            pnlcreateForum.Visible = true;
        }

        private void createForum()
        {
            Security sec = new Security();
            myDal = new DAL("spForums");
            myDal.addParm("username", sec.username);
            myDal.addParm("rating", rblMature.SelectedValue);
            myDal.addParm("forumTitle", txtforumTitle.Text);
            myDal.addParm("forumText", txtForumText.Text);

            int forumID = Convert.ToInt32(myDal.execScalar());
        }

        protected void gvForum_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvForum.PageIndex = e.NewPageIndex;
            loadgvForum();
        }

        protected void gvForum_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "Page")
            {
                return;
            }

            gvForum.SelectedIndex = Convert.ToInt32(e.CommandArgument);
            int forumID = Convert.ToInt32(gvForum.SelectedDataKey.Value);

            if (e.CommandName == "More")
            {
                Response.Redirect("ForumPost.aspx?forumID=" + forumID.ToString());
            }
        }

        protected void dlUnion_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int postID = Convert.ToInt32(dlUnion.DataKeys[e.Item.ItemIndex]);
            Label lblType = (Label)e.Item.FindControl("lblType");

            if (e.CommandName == "post")
            {
                switch (lblType.Text)
                {

                    case "Art":
                        Response.Redirect("Post.aspx?postID=" + postID.ToString() + "&postType=artwork");
                        break;

                    case "Photography":
                        Response.Redirect("Post.aspx?postID=" + postID.ToString() + "&postType=photography");
                        break;

                    case "Video":
                        Response.Redirect("Post.aspx?postID=" + postID.ToString() + "&postType=video");
                        break;
                }         
            }
        }
    }
}