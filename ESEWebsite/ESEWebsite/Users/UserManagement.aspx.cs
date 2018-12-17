using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ESEWebsite
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
        }

        protected void gvEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            fvEmployee.PageIndex = gvEmployee.SelectedIndex;
            lblError.Text = "";
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            fvEmployee.PageIndex = gvEmployee.SelectedIndex;
            lblError.Text = "";
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            fvEmployee.ChangeMode(FormViewMode.Insert);
            lblError.Text = "";
        }

        protected void fvEmployee_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            gvEmployee.DataBind();
            lblError.Text = "";

            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblError.Text = e.Exception.Message;
            }
        }

        protected void fvEmployee_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            gvEmployee.DataBind();
            lblError.Text = "";

            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                lblError.Text = e.Exception.Message;
            }
        }

        protected void fvEmployee_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            gvEmployee.DataBind();
            lblError.Text = "";

            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                if(e.Exception.Message == "Exception has been thrown by the target of an invocation.")
                {
                    lblError.Text = "Cannot delete Employee connected to sales or repair.";
                }
            }
        }

    }
}