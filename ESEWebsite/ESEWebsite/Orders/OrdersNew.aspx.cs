using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ESEWebsite.Orders
{
    public partial class OrdersNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UnderConstruction.aspx");
        }
    }
}