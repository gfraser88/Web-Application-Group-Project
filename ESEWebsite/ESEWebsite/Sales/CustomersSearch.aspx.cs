using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ESELibrary;
using ESELibrary.dsSalesTableAdapters;
using System.Data;

namespace ESEWebsite.Sales
{
    public partial class SalesSearch : System.Web.UI.Page
    {
        private static dsSales dsSales;
        static SalesSearch()
        {
            dsSales = new dsSales();
            customerModifyTableAdapter customerModifyTableAdapter = new customerModifyTableAdapter();
            equipmentModifyTableAdapter equipmentModifyTableAdapter = new equipmentModifyTableAdapter();
            receiptModifyTableAdapter receiptModifyTableAdapter = new receiptModifyTableAdapter();
            order_lineTableAdapter order_LineTableAdapter = new order_lineTableAdapter();
            service_orderTableAdapter service_OrderTableAdapter = new service_orderTableAdapter();
            try
            {
                customerModifyTableAdapter.Fill(dsSales.customerModify);
                equipmentModifyTableAdapter.Fill(dsSales.equipmentModify);
                receiptModifyTableAdapter.Fill(dsSales.receiptModify);
                order_LineTableAdapter.Fill(dsSales.order_line);
                service_OrderTableAdapter.Fill(dsSales.service_order);
            }
            catch (Exception) { }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
            loadPage(true, false);
        }
        //search
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loadPage(true, false);
        }
        //new Customer
        protected void btnNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewCustomer.aspx");
        }
        //switch to details view
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loadPage(false, true);
            dvCustomer.DefaultMode = DetailsViewMode.ReadOnly;
        }
        //start a new sale
        protected void btnNewSales_Click(object sender, EventArgs e)
        {
            int CustomerId = Convert.ToInt32(gvCustomer.SelectedValue);
            Response.Redirect("SalesReceipt.aspx?id=" + CustomerId + "&name=" + ((Label)dvCustomer.FindControl("Label1")).Text+" "+ ((Label)dvCustomer.FindControl("Label2")).Text);
        }
        //switch to grid view
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomersSearch");
        }
        //switch the views visibility
        private void loadPage(bool gv, bool dv)
        {
            gvCustomer.Visible = gv;
            dvCustomer.Visible = dv;
            gvServiceHistory.Visible = dv;
            gvPurchaseHistory.Visible = dv;
            gvEquipment.Visible = dv;
        }
        protected void gvCustomer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[7].Style["display"] = "none ";
        }
        //update customer
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!getRev("revEmail").Text.Equals("") || !getRev("revPC").Text.Equals("") || !getRev("revPhone").Text.Equals("")) return;
            int CustomerId = Convert.ToInt32(gvCustomer.SelectedValue);
            try
            {
                dsSales.customerModify.FindByid(CustomerId).custFirst = GetTextBox("txtFN").Text;
                dsSales.customerModify.FindByid(CustomerId).custLast = GetTextBox("txtLN").Text;
                dsSales.customerModify.FindByid(CustomerId).custPhone = GetTextBox("txtPhone").Text;
                dsSales.customerModify.FindByid(CustomerId).custAddress = GetTextBox("txtAddress").Text;
                dsSales.customerModify.FindByid(CustomerId).custCity = GetTextBox("txtCity").Text;
                dsSales.customerModify.FindByid(CustomerId).custPostal = GetTextBox("txtPC").Text;
                dsSales.customerModify.FindByid(CustomerId).custEmail = GetTextBox("txtEmail").Text;
                if(Save())
                    dvCustomer.DefaultMode = DetailsViewMode.ReadOnly;
            }
            catch { }
        }
        private TextBox GetTextBox(string textboxID)
        {
            return (TextBox)dvCustomer.FindControl(textboxID);
        }
        private RegularExpressionValidator getRev(string revID)
        {
            return (RegularExpressionValidator)dvCustomer.FindControl(revID);
        }
        //delete customer
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int CustomerId = Convert.ToInt32(gvCustomer.SelectedValue);
            DataRow row = dsSales.customerModify.FindByid(CustomerId);
            if(row != null)
            {
                DataRow[] receipts = dsSales.receiptModify.Select("custID = " + Convert.ToInt32(row.ItemArray[0]));
                if (receipts.Length > 0)
                    foreach (DataRow receipt in receipts)
                    {
                        DataRow[] serviceOrders = dsSales.service_order.Select("receiptID = " + Convert.ToInt32(receipt.ItemArray[0]));
                        if (serviceOrders.Length > 0)
                            foreach (DataRow serviceOrder in serviceOrders)
                                serviceOrder.Delete();
                        DataRow[] orderLines = dsSales.order_line.Select("receiptID = " + Convert.ToInt32(receipt.ItemArray[0]));
                        if (orderLines.Length > 0)
                            foreach (DataRow orderLine in orderLines)
                                orderLine.Delete();
                        receipt.Delete();
                    }
                DataRow[] equipments = dsSales.equipmentModify.Select("custID = " + Convert.ToInt32(row.ItemArray[0]));
                if (equipments.Length > 0)
                    foreach (DataRow equipment in equipments)
                        equipment.Delete();
                row.Delete();
                if (Save())
                    Response.Redirect("CustomersSearch");
            }
        }
        //save change to database
        private bool Save()
        {
            equipmentModifyTableAdapter equipmentModifyTableAdapter = new equipmentModifyTableAdapter();
            order_lineTableAdapter order_LineTableAdapter = new order_lineTableAdapter();
            service_orderTableAdapter service_OrderTableAdapter = new service_orderTableAdapter();
            receiptModifyTableAdapter receiptModifyTableAdapter = new receiptModifyTableAdapter();
            customerModifyTableAdapter customerModifyTableAdapter = new customerModifyTableAdapter();
            try
            {
                order_LineTableAdapter.Update(dsSales.order_line);
                service_OrderTableAdapter.Update(dsSales.service_order);
                receiptModifyTableAdapter.Update(dsSales.receiptModify);
                equipmentModifyTableAdapter.Update(dsSales.equipmentModify);
                customerModifyTableAdapter.Update(dsSales.customerModify);
                dsSales.AcceptChanges();
                dsSales.customerModify.Clear();
                dsSales.receiptModify.Clear();
                dsSales.order_line.Clear();
                dsSales.service_order.Clear();
                dsSales.equipmentModify.Clear();
                customerModifyTableAdapter.Fill(dsSales.customerModify);
                receiptModifyTableAdapter.Fill(dsSales.receiptModify);
                order_LineTableAdapter.Fill(dsSales.order_line);
                service_OrderTableAdapter.Fill(dsSales.service_order);
                equipmentModifyTableAdapter.Fill(dsSales.equipmentModify);
                return true;
            }
            catch
            {
                dsSales.RejectChanges();
                return false;
            }
        }
  
        protected void btnCancelUpdate_Click(object sender, EventArgs e)
        {
            dvCustomer.DefaultMode = DetailsViewMode.ReadOnly;
        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {
            dvCustomer.DefaultMode = DetailsViewMode.Edit;
        }

        protected void gvEquipment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[0].Style["display"] = "none ";
        }
        //Delete an Equipment
        protected void btnDeleteEquipment_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string hiddenID = ((Label)row.FindControl("lblID")).Text;
            int id = Convert.ToInt32(hiddenID);
            DataRow r = dsSales.equipmentModify.FindByid(id);
            r.Delete();
            if (Save())
                gvEquipment.DataBind();
        }
        //Add new equipment to exsiting customer
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            TextBox equipment = GetTextBox("txtEquipment");
            DropDownList type = (DropDownList)dvCustomer.FindControl("ddlType");
            DropDownList manufacturer = (DropDownList)dvCustomer.FindControl("ddlManufacturer");
            if (equipment.Text.Equals("") || type.SelectedValue.Equals("-1") || manufacturer.SelectedValue.Equals("-1")) return;
            int CustomerId = Convert.ToInt32(gvCustomer.SelectedValue);
            DataRow row = dsSales.equipmentModify.NewRow();
            row[1] = equipment.Text;
            row[2] = getSerial();
            row[3] = CustomerId;
            row[4] = type.SelectedValue;
            row[5] = manufacturer.SelectedValue;
            dsSales.equipmentModify.Rows.Add(row);
            if(Save())
                gvEquipment.DataBind();
        }

        //random create a serial number
        private string getSerial()
        {
            string serial = "";
            Random random = new Random();
            int count = random.Next(10, 15);
            for (int i = 0; i < count; i++)
            {
                int num = random.Next(0, 10);
                serial += num.ToString();
            }
            return serial;
        }
    }
}