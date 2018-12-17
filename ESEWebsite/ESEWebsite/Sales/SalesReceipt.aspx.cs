using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ESELibrary;
using ESELibrary.dsSalesTableAdapters;
using System.Data;
using System.Drawing;

namespace ESEWebsite.Sales
{
    public partial class SalesReceipt : System.Web.UI.Page
    {
        private static dsSales dsSales = new dsSales();
        private static decimal productPrice;
        private static decimal servicePrice;
        private static decimal PurchaseTotalPrice;
        private static decimal ServiceTotalPrice;
        private static decimal totalPrice;
        private static List<int[]> services;
        private static List<int> productIds;
        private static List<bool> orderRequired;
        private static DataTable dtPurchase;
        private static DataTable dtService;

        static SalesReceipt()
        {
            ProductsTableAdapter productsTableAdapter = new ProductsTableAdapter();
            servicesTableAdapter servicesTableAdapter = new servicesTableAdapter();
            receiptModifyTableAdapter receiptModifyTableAdapter = new receiptModifyTableAdapter();
            order_lineTableAdapter order_LineTableAdapter = new order_lineTableAdapter();
            try
            {
                receiptModifyTableAdapter.Fill(dsSales.receiptModify);
                productsTableAdapter.Fill(dsSales.Products);
                servicesTableAdapter.Fill(dsSales.services);
                order_LineTableAdapter.Fill(dsSales.order_line);
            }
            catch (Exception) { }
        }

        //Initial when page load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.IsPostBack) return;
            if (Request.QueryString["id"] == null)
                Response.Redirect("NewCustomer.aspx");
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
            productPrice = 0;
            servicePrice = 0;
            PurchaseTotalPrice = 0;
            ServiceTotalPrice = 0;
            totalPrice = 0;
            services = new List<int[]>();
            productIds = new List<int>();
            orderRequired = new List<bool>();
            dtPurchase = new DataTable();
            dtPurchase.Columns.Add("Product", typeof(string));
            dtPurchase.Columns.Add("Order Quantity", typeof(string));
            dtPurchase.Columns.Add("Price", typeof(string));
            dtService = new DataTable();
            dtService.Columns.Add("Service", typeof(string));
            dtService.Columns.Add("Equipment", typeof(string));
            dtService.Columns.Add("Price", typeof(string));
            display("none", "none", "none", "true");
        }

        //select sales type
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlType.Text.Equals("Purchase"))
                display("true","none","none","true");
            else if (ddlType.Text.Equals("Repair"))
                display("none", "true", "none", "true");
            else
                display("none", "none", "none", "true");
        }
        //select a service
        protected void ddlService_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtServicePrice.Text = dsSales.services[ddlService.SelectedIndex - 1].serPrice.ToString();
        }

        //select a product
        protected void ddlProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlQuantity.Items.Clear();
            lblCount.Text = "";
            if (ddlProduct.SelectedIndex != 0)
            {
                ddlQuantity.Enabled = true;
                int i = 0;
                for (; i <= dsSales.Products[ddlProduct.SelectedIndex-1].invQuantity; i++)
                    ddlQuantity.Items.Add(i.ToString());
                lblCount.Text = "In Stock";
                lblCount.ForeColor = Color.Red;
                if (i > 3)
                    lblCount.ForeColor = Color.Green;
                else if (i-1 > 0 && i <= 3)
                    lblCount.Text = "Left Few";
                else
                    lblCount.Text = "Sold out";
                txtProductPrice.Text = dsSales.Products[ddlProduct.SelectedIndex-1].invPrice.ToString();
            }
            else
            {
                ddlQuantity.Enabled = false;
                txtProductPrice.Text = "";
            }
        }

        //cancel check out, and go back to order
        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (lblResult.Text.Contains("submit"))
                Response.Redirect("CustomersSearch");
            ddlType.SelectedIndex = 0;
            display("none", "none", "none", "true");
            lblResult.Text = "";
        }
        //add service
        protected void btnAdd2_Click(object sender, EventArgs e)
        {
            if (txtServicePrice.Text == "0" || ddlService.SelectedValue == "0" || ddlEqipment.SelectedValue == "0") return;
            servicePrice = Convert.ToDecimal(txtServicePrice.Text);
            ServiceTotalPrice += servicePrice;
            int[] ids = { Convert.ToInt32(ddlService.SelectedValue), Convert.ToInt32(ddlEqipment.SelectedValue) };
            services.Add(ids);
            addOrder(gvServices, dtService,ddlService.SelectedItem.ToString(), ddlEqipment.SelectedItem.ToString(), servicePrice.ToString(),ServiceTotalPrice.ToString());
        }
        //add product
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtProductPrice.Text == "0" || ddlQuantity.SelectedIndex == 0 || ddlProduct.SelectedValue=="0") return;
            productPrice = Convert.ToDecimal(txtProductPrice.Text) * Convert.ToDecimal(ddlQuantity.SelectedIndex);
            PurchaseTotalPrice += productPrice;
            productIds.Add(Convert.ToInt32(ddlProduct.SelectedValue));
            if (lblCount.ForeColor.Equals(Color.Red))
                orderRequired.Add(true);
            else
                orderRequired.Add(false);
            addOrder(gvItems, dtPurchase,ddlProduct.SelectedItem.ToString(), ddlQuantity.SelectedIndex.ToString(), productPrice.ToString(), PurchaseTotalPrice.ToString());
        }
        
        //add to orders
        private void addOrder(GridView gv, DataTable dt,string name,string number_Equpment,string price, string total)

        {
            DataRow NewRow = dt.NewRow();
            NewRow[0] = name;
            NewRow[1] = number_Equpment;
            NewRow[2] = price;
            dt.Rows.Add(NewRow);
            dataBind(gv, dt, total);
        }
        //delete an item in order list
        protected void gvItems_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            PurchaseTotalPrice -= Convert.ToDecimal(gvItems.Rows[e.RowIndex].Cells[3].Text);
            dtPurchase.Rows.RemoveAt(e.RowIndex);
            productIds.RemoveAt(e.RowIndex);
            orderRequired.RemoveAt(e.RowIndex);
            dataBind(gvItems,dtPurchase, PurchaseTotalPrice.ToString());
        }
        //delete a service
        protected void gvServices_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            ServiceTotalPrice -= Convert.ToDecimal(gvServices.Rows[e.RowIndex].Cells[3].Text);
            services.RemoveAt(e.RowIndex);
            dtService.Rows.RemoveAt(e.RowIndex);
            dataBind(gvServices,dtService, ServiceTotalPrice.ToString());
        }

        private void dataBind(GridView gv,DataTable dt, string total)
        {
            gv.DataSource = dt;
            gv.DataBind();
            gv.FooterRow.Cells[3].Text = total;
            gv.FooterRow.Cells[2].Text = "Total Price:";
        }

        //Check out
        protected void btnSubmitPurchase_Click1(object sender, EventArgs e)
        {
            createBill();
        }

        //Check out
        protected void btnSubmitRepair_Click(object sender, EventArgs e)
        {
            createBill();
        }

        //Create bill
        private void createBill()
        {
            totalPrice = ServiceTotalPrice + PurchaseTotalPrice;
            if (totalPrice > 0)
            {
                display("none", "none", "true", "none");
                txtOrderNum.Text = (Convert.ToInt32(dsSales.receiptModify[dsSales.receiptModify.Count - 1].ordNumber)+1).ToString();
            }
        }
        //display attribute for views
        private void display(string purchase, string repair, string order, string receipt)
        {
            this.purchase.Attributes.Add("style", "display:" + purchase);
            this.repair.Attributes.Add("style", "display:" + repair);
            this.order.Attributes.Add("style", "display:" + order);
            this.receipt.Attributes.Add("style", "display:" + receipt);
        }
        //Submit orders
        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            if(lblResult.Text.Contains("submit"))
            {
                lblResult.Text = "Can not submit again!";
                return;
            }
            try
            {
                DataRow row = dsSales.receiptModify.NewRow();
                row[1] = txtOrderNum.Text;
                row[2] = Convert.ToDateTime(txtDate.Text);
                row[3] = ckbPaid.Checked;
                row[4] = ddlPayment.SelectedValue;
                row[5] = Convert.ToInt32(Request.QueryString["id"]);
                row[6] = ddlSalePerson.SelectedValue;
                dsSales.receiptModify.Rows.Add(row);
                if (SaveReceipt())
                {
                    int receiptId = Convert.ToInt32(dsSales.receiptModify.Rows[dsSales.receiptModify.Count - 1]["id"]);
                    try
                    {
                        for(int i=0;i< dtPurchase.Rows.Count; i++)
                        {
                            row = dsSales.order_line.NewRow();
                            row[1] = Convert.ToDecimal(dtPurchase.Rows[i]["Price"]);
                            row[2] = Convert.ToInt32(dtPurchase.Rows[i]["Order Quantity"]);
                            row[3] = orderRequired[i];
                            row[4] = txtNote.Text;
                            row[5] = productIds[i];
                            row[6] = receiptId;
                            dsSales.order_line.Rows.Add(row);
                            SaveOrder();
                        }
                        if (services.Count > 0)
                        {
                            Session["ids"] = services;
                            Response.Redirect("~/Repairs/RepairNew.aspx?receiptId=" + receiptId + "&empId=" + ddlSalePerson.SelectedValue);
                        }
                        else
                            lblResult.Text = "Order submited!";
                    }
                    catch { }
                }
                else return;
            }
            catch { }
        }

        //method to save changes back to the receipt table
        private bool SaveReceipt()
        {
            receiptModifyTableAdapter receiptModifyTableAdapter = new receiptModifyTableAdapter();
            try
            {
                receiptModifyTableAdapter.Update(dsSales.receiptModify);
                dsSales.AcceptChanges();
                dsSales.receiptModify.Clear();
                receiptModifyTableAdapter.Fill(dsSales.receiptModify);
                return true;
            }
            catch
            {
                dsSales.RejectChanges();
                return false;
            }
        }

        //method to save changes back to the order_line table
        private bool SaveOrder()
        {
            order_lineTableAdapter order_LineTableAdapter = new order_lineTableAdapter();
            try
            {
                order_LineTableAdapter.Update(dsSales.order_line);
                dsSales.AcceptChanges();
                dsSales.order_line.Clear();
                order_LineTableAdapter.Fill(dsSales.order_line);
                return true;
            }
            catch
            {
                dsSales.RejectChanges();
                return false;
            }
        }

        //Fill form with demo data
        protected void btnDemo_Click(object sender, EventArgs e)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd"); ;
            ckbPaid.Checked = true;
            ddlPayment.SelectedIndex = 1;
            ddlSalePerson.SelectedIndex = 1;
            txtNote.Text = "None";
        }
    }
}