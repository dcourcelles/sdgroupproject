using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TruphoxGP
{
    public partial class TAP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnFrench_Click(object sender, EventArgs e)
        {
            frenchPnl.Visible = true;
            englishPnl.Visible = false;
        }

        protected void btnEnglish_Click(object sender, EventArgs e)
        {
            frenchPnl.Visible = false;
            englishPnl.Visible = true;
        }
    }
}