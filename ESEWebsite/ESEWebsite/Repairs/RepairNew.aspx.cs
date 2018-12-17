//Andrew Butler
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ESELibrary;
using ESELibrary.dsRepairSearchTableAdapters;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace ESEWebsite.Repairs
{
    public partial class NewRepair : System.Web.UI.Page
    {

        private static dsRepairSearch dsRepair;

        private static DataRow[] rows;
        List<int> serIDs = new List<int>();
        List<int> equipIDs = new List<int>();
        List<int> test = new List<int>();

        //load dataset for new repair
        static NewRepair()
        {
            //load data at the beginning of the session
            dsRepair = new dsRepairSearch();
            service_orderUpdateTableAdapter daRepairUpdate = new service_orderUpdateTableAdapter();

            try
            {
                daRepairUpdate.Fill(dsRepair.service_orderUpdate);
            }
            catch { }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblSave.Visible = false;
            if (this.Page.IsPostBack) return;
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");

            List<int[]> services = (List<int[]>)Session["ids"];

            if (services != null)
                for (int i = 0; i < services.Count; i++)
                {
                    var a = i + 1;
                    this.lstServices.Items.Add("Create repair ticket: " + a );
                }
            if (this.lstServices.Items.Count == 0)
            {
                lblWarning.Visible = true;
            }
            else
            {
                lblWarning.Visible = false;
            }
            this.ddlEmployee.SelectedValue = Request.QueryString["empId"];
            this.txtReceipt.Text = Request.QueryString["receiptId"];

        }

        //private static int id = -1;

        //populate create form with data from URL
        protected void btnSelect_Click(object sender, EventArgs e)
        {
            if (this.lstServices.SelectedIndex != -1)
            {

                List<int[]> services = (List<int[]>)Session["ids"];
                if (services != null)
                {
                    for (int i = 0; i < services.Count; i++)
                    {
                        serIDs.Add(services[i][0]);
                        equipIDs.Add(services[i][1]);
                    }
                    this.txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtStartDate.ReadOnly = true;
                    this.txtEndDate.Text = "9999-01-01";
                    this.txtIssue.Text = "";
                    this.cbWarranty.Checked = false;
                    this.ddlService.SelectedValue = serIDs[lstServices.SelectedIndex].ToString();
                    this.ddlEquipment.SelectedValue = equipIDs[lstServices.SelectedIndex].ToString();
                    txtReceipt.ReadOnly = true;
                }
            }
        }

        //create new repair ticket
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblSave.Visible = true;
            try
            {
                DataRow r = dsRepair.service_orderUpdate.NewRow();
                r[1] = this.txtStartDate.Text;
                r[2] = this.txtEndDate.Text;
                r[3] = this.txtIssue.Text;
                r[4] = this.cbWarranty.Checked;
                r[5] = this.txtReceipt.Text;
                r[6] = this.ddlService.SelectedValue;
                r[7] = this.ddlEquipment.SelectedValue;
                r[8] = this.ddlEmployee.SelectedValue;
                dsRepair.service_orderUpdate.Rows.Add(r);
                Save();
                //lstServices.Items.RemoveAt(lstServices.SelectedIndex);
            }
            catch
            {
                this.lblSave.Text = "Unable to create new repair.";
            }
        }

        //save new repair ticket
        private void Save()
        {
            service_orderUpdateTableAdapter daRepairUpdate = new service_orderUpdateTableAdapter();
            service_orderTableAdapter daRepair = new service_orderTableAdapter();
            try
            {
                daRepairUpdate.Update(dsRepair.service_orderUpdate);
                dsRepair.AcceptChanges();
                dsRepair.service_order.Clear();
                daRepair.Fill(dsRepair.service_order);
                this.lblSave.Text = "Data Saved. Repair ticket created.";
            }
            catch
            {
                dsRepair.RejectChanges();
                this.lblSave.Text = "Unable to update";
            }
        }

        protected void lstServices_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

    }
}