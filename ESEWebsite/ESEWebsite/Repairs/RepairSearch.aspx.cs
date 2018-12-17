//Andrew Butler
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Data;
using ESELibrary;
using ESELibrary.dsRepairSearchTableAdapters;

namespace ESEWebsite.Repairs
{
    public partial class RepairSearch : System.Web.UI.Page
    {
        private static dsRepairSearch dsRepair;

        private static DataRow[] rows;

        static RepairSearch()
        {
            //load data at the beginning of the session
            dsRepair = new dsRepairSearch();
            service_orderTableAdapter daRepair = new service_orderTableAdapter();
            service_orderUpdateTableAdapter daRepairUpdate = new service_orderUpdateTableAdapter();

            try
            {
                daRepair.Fill(dsRepair.service_order);
                daRepairUpdate.Fill(dsRepair.service_orderUpdate);
            }
            catch { }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
            pnlEdit.Visible = false;
            pnlSearch.Visible = true;
            btnBack.Visible = false;
            service_orderTableAdapter daRepair = new service_orderTableAdapter();
            daRepair.Fill(dsRepair.service_order);
            dsRepair.GetChanges();
            service_orderUpdateTableAdapter daRepairUpdate = new service_orderUpdateTableAdapter();
            daRepairUpdate.Fill(dsRepair.service_orderUpdate);
            gvRepair.AllowSorting = false;
        }

        //event method retrieves repair records - SEARCH/FILTER
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblResults.Visible = true;
            pnlSearch.Visible = false;
            btnNewSearch.Visible = true;
            this.lblMessage.Text = "";
            gvRepair.Visible = true;
            if (dsRepair.service_order.Count > 0)
            {
                string criteria = GetRepairCriteria();
                rows = (criteria.Length > 0) ? dsRepair.service_order.Select(criteria) : dsRepair.service_order.Select();

                gvRepair.DataSource = rows;
                gvRepair.DataBind();
                lblResults.Text = "Search Results: " + ((rows.Length > 0) ? rows.Length.ToString() : "0");
            }
        }

        //gridview filtering criteria
        private string GetRepairCriteria()
        {
            string criteria = "";
            criteria = (this.ddlEquipment.SelectedValue != "None") ? "equModel = '" + this.ddlEquipment.SelectedValue + "'" : "";
            criteria += (this.ddlEmployee.SelectedValue != "None" && criteria.Length > 0) ? " AND empFull = '" + this.ddlEmployee.SelectedValue + "'"
                : (this.ddlEmployee.SelectedValue != "None") ? " empFull = '" + this.ddlEmployee.SelectedValue + "'" : "";
            criteria += (this.ddlService.SelectedValue != "None" && criteria.Length > 0) ? " AND serName = '" + this.ddlService.SelectedValue + "'"
                : (this.ddlService.SelectedValue != "None") ? " serName = '" + this.ddlService.SelectedValue + "'" : "";
            criteria += (this.txtStartDate.Text.Length > 0 && criteria.Length > 0) ? " AND serordDateIn >= #" + this.txtStartDate.Text + "#"
                : (this.txtStartDate.Text.Length > 0) ? "serordDateIn >= #" + this.txtStartDate.Text + "#" : "";
            criteria += (this.txtEndDate.Text.Length > 0 && criteria.Length > 0) ? " AND serordDateOut <= #" + this.txtEndDate.Text + "#"
                : (this.txtEndDate.Text.Length > 0) ? "serordDateOut <= #" + this.txtEndDate.Text + "#" : "";
            return criteria;
        }

        private static int id = -1;

        //populate edit form based on gridview selection
        protected void gvRepair_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblResults.Visible = false; ;
            gvRepair.Visible = false;
            pnlSearch.Visible = false;
            pnlEdit.Visible = true;
            btnBack.Visible = true;
            if (this.gvRepair.SelectedIndex != -1)
            {
                int id = Convert.ToInt32(this.gvRepair.SelectedValue);
                DataRow repair = dsRepair.service_orderUpdate.FindByid(id);
                if (rows != null && repair != null)
                {
                    this.txtStartDateEdit.Text = repair.ItemArray[1].ToString();
                    this.txtStartDateEdit.ReadOnly = true;
                    this.txtEndDateEdit.Text = repair.ItemArray[2].ToString();
                    this.txtIssue.Text = repair.ItemArray[3].ToString();
                    this.cbWarranty.Checked = Convert.ToBoolean(repair.ItemArray[4]);
                    this.ddlEquipEdit.SelectedValue = repair.ItemArray[7].ToString();
                    this.ddlSerEdit.SelectedValue = repair.ItemArray[6].ToString();
                    this.ddlEmpEdit.SelectedValue = repair.ItemArray[8].ToString();
                }
                lblSave.Text = "Pending Update";

            }
        }

        protected void gvRepairResults_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        //UPDATE REPAIR
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            pnlSearch.Visible = true;
            pnlEdit.Visible = false;
            btnNewSearch.Visible = false;
            int id = Convert.ToInt32(this.gvRepair.SelectedValue);
            if (id != -1)
            {
                try
                {
                    dsRepair.service_orderUpdate.FindByid(id).serordDateIn = Convert.ToDateTime(this.txtStartDateEdit.Text);
                    dsRepair.service_orderUpdate.FindByid(id).serordDateOut = Convert.ToDateTime(this.txtEndDateEdit.Text);
                    dsRepair.service_orderUpdate.FindByid(id).serordIssue = this.txtIssue.Text;
                    dsRepair.service_orderUpdate.FindByid(id).serordWarranty = this.cbWarranty.Checked;
                    dsRepair.service_orderUpdate.FindByid(id).equipID = Convert.ToInt32(this.ddlEquipEdit.SelectedValue);
                    dsRepair.service_orderUpdate.FindByid(id).empID = Convert.ToInt32(this.ddlEmpEdit.SelectedValue);
                    dsRepair.service_orderUpdate.FindByid(id).serviceID = Convert.ToInt32(this.ddlSerEdit.SelectedValue);
                    Save();
                    this.lblMessage.Text = "Success updating record.";
                }
                catch
                {
                    this.lblMessage.Text = "Unable to update - Invalid Input";
                }
            }
        }

        //Save and refresh data
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
                this.lblSave.Text = "Data Saved";
            }
            catch
            {
                dsRepair.RejectChanges();
                this.lblSave.Text = "Unable to update";
            }
        }

        //Delete Repair
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            btnNewSearch.Visible = false;
            pnlSearch.Visible = true;
            pnlEdit.Visible = false;
            int id = Convert.ToInt32(this.gvRepair.SelectedValue);
            if (id != -1)
            {
                DataRow r = dsRepair.service_orderUpdate.FindByid(id);
                r.Delete();
                this.Save();
                this.lblMessage.Text = "Success deleting record.";
            }
        }

        protected void btnNewSearch_Click(object sender, EventArgs e)
        {
            btnNewSearch.Visible = false;
            gvRepair.Visible = false;
            lblResults.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlSearch.Visible = false;
            gvRepair.Visible = true;
            lblResults.Visible = true;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            this.txtStartDate.Text = "";
            this.txtEndDate.Text = "";
            this.ddlEquipment.SelectedValue = "None";
            this.ddlService.SelectedValue = "None";
            this.ddlEmployee.SelectedValue = "None";
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Orders/OrdersNew.aspx");
        }
    }
}