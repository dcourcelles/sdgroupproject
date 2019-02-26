using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Results : System.Web.UI.Page
    {
        DAL mydal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string search = Request.QueryString["result"].ToString();
                string type = Request.QueryString["filter"].ToString();

                if (type == "users")
                {
                    loadUserSearch(search);
                }

                if (type == "posts")
                {
                    loadPostSearch(search);
                }
            }
        }

        private void loadUserSearch(string Search)
        {
            Security sec = new Security();
            mydal = new DAL("spUSearch");
            mydal.addParm("@input", Search);

            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            if (ds.Tables[0].Rows.Count != 0)
            {
                dlUserSearch.DataSource = dtA;
                dlUserSearch.DataBind();
            }
            else
            {
                lblNotFound.Visible = true;
                lblNotFound.Text = Search + " not found";
            }
        }

        private void loadPostSearch(string Search)
        {
            Security sec = new Security();
            mydal = new DAL("spSearchUnion");
            mydal.addParm("@input", Search);

            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            if (ds.Tables[0].Rows.Count != 0)
            {
                dlUnity.DataSource = dtA;
                dlUnity.DataBind();
            }
            else
            {
                lblNotFound.Visible = true;
                lblNotFound.Text = Search + " not found";
            }
        }

        protected void dlUserSearch_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Security mySecurity = new Security();
            string viewUser = dlUserSearch.DataKeys[e.Item.ItemIndex].ToString();

            if (e.CommandName == "Select")
            {
                if (viewUser != mySecurity.username)
                {
                    Response.Redirect("viewProfile.aspx?followedUser=" + viewUser);
                }
                else
                {
                    Response.Redirect("Profile.aspx");
                }
            }
        }

        protected void dlUnity_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int postID = Convert.ToInt32(dlUnity.DataKeys[e.Item.ItemIndex]);
            Label lblType = (Label)e.Item.FindControl("lblType");

            if (e.CommandName == "Select")
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