using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ESEWebsite
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                pnlHide.Visible = true;

            }
            else
                Response.Redirect("~/Login.aspx");
            if (Session["username"] != null)
                this.lblUser.Text = Session["username"].ToString() + "!";
            else
                this.lblUser.Text = "!";

        }
    }
}