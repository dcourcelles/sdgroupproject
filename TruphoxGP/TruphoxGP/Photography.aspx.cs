using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Photography : System.Web.UI.Page
    {
        DAL mydal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadPTrending();
                loadPRecent();
            }
        }
        private void loadPTrending()
        {
            mydal = new DAL("spReadPhotography");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlPhotoTrending.DataSource = dtA;
            dlPhotoTrending.DataBind();
        }
        private void loadPRecent()
        {
            mydal = new DAL("spReadRecentPhoto");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlPhotoRecent.DataSource = dtA;
            dlPhotoRecent.DataBind();
        }

        protected void dlPhotoTrending_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlPhotoTrending.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=photography");
            }
        }

        protected void dlPhotoRecent_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlPhotoRecent.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=photography");
            }
        }

        protected void dlPhotoFav_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlPhotoFav.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=photography");
            }
        }
    }
}