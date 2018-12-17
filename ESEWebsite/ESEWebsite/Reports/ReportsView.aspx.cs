using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using ESELibrary;
using ESELibrary.dsReportTableAdapters;
using System.Data;

namespace ESEWebsite.Reports
{
    public partial class ReportsView : System.Web.UI.Page
    {
        private static dsReport dsReport;
        private static DataRow[] services;
        private static DataRow[] sales;

        static ReportsView()
        {
            dsReport = new dsReport();
            reportServiceTableAdapter daReportService = new reportServiceTableAdapter();
            reportSaleTableAdapter daReportSale = new reportSaleTableAdapter();
            try
            {
                daReportService.Fill(dsReport.reportService);
                daReportSale.Fill(dsReport.reportSale);
            }
            catch { }
        }

        private string GetReportCriteria()
        {
            string criteria = "";
            criteria = (this.ddlCustomer.SelectedValue != "All Customers") ? "Customer = '" + this.ddlCustomer.SelectedValue + "'" : "";

            criteria += (this.ddlEmployee.SelectedValue != "All Employees" && criteria.Length > 0) ? " AND Employee = '" + this.ddlEmployee.SelectedValue + "'"
                    : (this.ddlEmployee.SelectedValue != "All Employees" && criteria.Length <= 0) ? " Employee = '" + this.ddlEmployee.SelectedValue + "'" : "";

            criteria += (criteria.Length > 0) ? " AND ordDate >= #" + Convert.ToDateTime(this.txtStartDate.Text) + "#"
                : " ordDate >= #" + this.txtStartDate.Text + "#";

            criteria += (criteria.Length > 0) ? " AND ordDate <= #" + Convert.ToDateTime(this.txtEndDate.Text) + "#"
                : " ordDate <= #" + this.txtEndDate.Text + "#";

            return criteria;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            pnlReport.Visible = false;
            gvService.Visible = true;
            //this.txtEndDate.Text = DateTime.Today.ToShortDateString();
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
            //refresh instances of services and sales on page refresh
            reportServiceTableAdapter daReportService = new reportServiceTableAdapter();
            reportSaleTableAdapter daReportSale = new reportSaleTableAdapter();
            try
            {
                daReportService.Fill(dsReport.reportService);
                daReportSale.Fill(dsReport.reportSale);
            }
            catch { }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            decimal serviceTotal = 0;
            decimal saleTotal = 0;
            decimal total = 0;
            pnlReport.Visible = true;
            gvService.Visible = true;
            gvSales.Visible = true;
            if (dsReport.reportService.Count > 0)
            {
                string criteria = GetReportCriteria();
                criteria += (this.ddlWarranty.SelectedValue != "Both" && criteria.Length > 0) ? " AND serordWarranty = " + this.ddlWarranty.SelectedValue + ""
                    : (this.ddlWarranty.SelectedValue != "Both" && criteria.Length <= 0) ? " serordWarranty = " + this.ddlWarranty.SelectedValue + "" : "";

                services = (criteria.Length > 0) ? dsReport.reportService.Select(criteria) : dsReport.reportService.Select();
                gvService.DataSource = services;
                gvService.DataBind();
                lblServiceResults.Text = "Search Results: " + services.Count().ToString();
                foreach (DataRow row in services)
                    serviceTotal += Convert.ToDecimal(row.ItemArray[4]);
                lblServiceTotal.Text = "<b>" + String.Format("{0:C2}", serviceTotal) + "</b>";
            }
            else if (dsReport.reportService.Count <= 0)
            {
                lblServiceResults.Text = "No service sales were found.";
            }

            if (dsReport.reportSale.Count > 0)
            {
                string criteria = GetReportCriteria();
                sales = (criteria.Length > 0) ? dsReport.reportSale.Select(criteria) : dsReport.reportSale.Select();
                gvSales.DataSource = sales;
                gvSales.DataBind();
                lblSalesResults.Text = "Search Results: " + sales.Count().ToString();
                foreach (DataRow row in sales)
                    saleTotal += Convert.ToDecimal(row.ItemArray[5]) * Convert.ToDecimal(row.ItemArray[4]);
                lblSalesTotal.Text = "<b>" + String.Format("{0:C2}", saleTotal) + "</b>";
            }
            else
            {
                lblServiceResults.Text = "No sales were found.";
            }

            total = serviceTotal + saleTotal;
            this.lblTotal.Text = "<b>" + String.Format("{0:C2}", total) + "</b>";
            this.lblPartySavings.Text = "<b>" + String.Format("{0:C2}", Decimal.Multiply(total, 0.02m)) + "</b>";
        }

        protected void txtEndDate_TextChanged(object sender, EventArgs e)
        {
            //if (this.txtEndDate.Text == "yyyy-mm-dd")
            //    this.txtEndDate.Text = DateTime.Today.ToString();
        }


        //SORTING
        public SortDirection dir
        {
            get
            {
                if (ViewState["dirState"] == null)
                {
                    ViewState["dirState"] = SortDirection.Ascending;
                }
                return (SortDirection)ViewState["dirState"];
            }
            set
            {
                ViewState["dirState"] = value;
            }

        }

        protected void gvService_Sorting(object sender, GridViewSortEventArgs e)
        {
            string SortDir = string.Empty;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                SortDir = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                SortDir = "Asc";
            }
            DataView sortedView = new DataView(dsReport.reportService);
            sortedView.Sort = e.SortExpression + " " + SortDir;
            gvService.DataSource = sortedView;
            gvService.DataBind();
        }

        protected void gvSales_Sorting(object sender, GridViewSortEventArgs e)
        {
            string SortDir = string.Empty;
            if (dir == SortDirection.Ascending)
            {
                dir = SortDirection.Descending;
                SortDir = "Desc";
            }
            else
            {
                dir = SortDirection.Ascending;
                SortDir = "Asc";
            }
            DataView sortedView = new DataView(dsReport.reportSale);
            sortedView.Sort = e.SortExpression + " " + SortDir;
            gvSales.DataSource = sortedView;
            gvSales.DataBind();
        }
    }
}