using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class Writing : System.Web.UI.Page
    {
        DAL mydal;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadWriteTrending();
                loadWriteRecent();
            }
        }
        private void loadWriteTrending()
        {
            mydal = new DAL("spReadWriting");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlWriteTrending.DataSource = dtA;
            dlWriteTrending.DataBind();
        }

        private void loadWriteRecent()
        {
            mydal = new DAL("spReadRecentWriting");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

            dlWriteRecent.DataSource = dtA;
           dlWriteRecent.DataBind();
        }

        private void loadWriteFav()
        {
            mydal = new DAL("spReadWriting");
            DataSet ds = mydal.getDataSet();
            DataTable dtA = ds.Tables[0];

           dlWriteFav.DataSource = dtA;
            dlWriteFav.DataBind();
        }

        protected void dlWriteTrending_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlWriteTrending.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=writing");
            }
        }

        protected void dlWriteRecent_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlWriteRecent.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=writing");
            }
        }

        protected void dlWriteFav_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int itemID = Convert.ToInt32(dlWriteFav.DataKeys[e.Item.ItemIndex]);

            if (e.CommandName == "Select")
            {
                Response.Redirect("Post.aspx?postID=" + itemID.ToString() + "&postType=writing");
            }
        }
    }
}