using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class submitLit : System.Web.UI.Page
    {
        DAL myDal;
        public int postID { get; set; }
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
                    if (Request.QueryString["postID"] != null)
                    {
                        postID = Convert.ToInt32(Request.QueryString["postID"].ToString());
                        pnlUpdate.Visible = true;
                        pnlSubmit.Visible = false;
                        loadLit(postID);
                    }
                    else
                    {
                        pnlSubmit.Visible = true;
                        pnlUpdate.Visible = false;
                    }
                }
            }
        }
        private void loadLit(int PostID)
        {
            Security sec = new Security();
            myDal = new DAL("spReadWriting");
            myDal.addParm("postID", PostID.ToString());
            DataSet ds = myDal.getDataSet();

            lblPostID.Text = ds.Tables[0].Rows[0]["postID"].ToString();
            txtUTitle.Text = ds.Tables[0].Rows[0]["postTitle"].ToString();
            txtUSubtitle.Text = ds.Tables[0].Rows[0]["postSubTitle"].ToString();
            txtUText.Text = ds.Tables[0].Rows[0]["writingText"].ToString();
        }

        protected void btnSubmitLit_Click(object sender, EventArgs e)
        {
            Security sec = new Security();
            myDal = new DAL("spCreateWriting");
            myDal.addParm("username", sec.username);

            myDal.addParm("rating", rblMature.SelectedValue);
            myDal.addParm("postTitle", txtTitle.Text);
            myDal.addParm("postSubtitle", txtSubtitle.Text);
            myDal.addParm("writingText", txtWriting.Text);

            myDal.execNonQuery();

            int postID = Convert.ToInt32(myDal.execScalar());

            Response.Redirect("Post.aspx?postID=" + postID + "&postType=writing");
        }

        protected void btnUpdateLit_Click(object sender, EventArgs e)
        {
            Security sec = new Security();
            myDal = new DAL("spUpdateWriting");
           myDal.addParm("username", sec.username);

            myDal.addParm("postID", lblPostID.ToString());
            myDal.addParm("rating", rblUMature.SelectedValue);
            myDal.addParm("postTitle", txtUTitle.Text);
            myDal.addParm("postSubTitle", lblUSubtitle.Text);
            myDal.addParm("writingText", txtUText.Text);

            Response.Redirect("Post.aspx?postID=" + lblPostID.Text + "&postType=writing");
        }
    }
}