using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Video : System.Web.UI.Page
    {
        DAL mydal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadVTrending();
                loadVRecent();
            }
        }
        private void loadVTrending()
        {
            mydal = new DAL("spReadVideo");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlVideoTrending.DataSource = dtA;
            dlVideoTrending.DataBind();
        }
        private void loadVRecent()
        {
            mydal = new DAL("spReadVideo");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlVideoRecent.DataSource = dtA;
            dlVideoRecent.DataBind();
        }
        private void loadVFav()
        {
            mydal = new DAL("spReadVideo");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlVideoFav.DataSource = dtA;
            dlVideoFav.DataBind();
        }

        protected void dlVideoTrending_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlVideoTrending.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=video");
            }
        }

        protected void dlVideoRecent_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlVideoRecent.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=video");
            }
        }

        protected void dlVideoFav_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlVideoFav.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=video");
            }
        }
    }
}