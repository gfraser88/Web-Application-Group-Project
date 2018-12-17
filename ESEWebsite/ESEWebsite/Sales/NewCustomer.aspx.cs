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
    public partial class SalesNew : System.Web.UI.Page
    {
        private static dsSales dsSales;
        private static List<string[]> ownedequipments;
        static SalesNew()
        {
            dsSales = new dsSales();
            customerModifyTableAdapter customerModifyTableAdapter = new customerModifyTableAdapter();
            equipmentModifyTableAdapter equipmentModifyTableAdapter = new equipmentModifyTableAdapter();
            try
            {
                customerModifyTableAdapter.Fill(dsSales.customerModify);
                equipmentModifyTableAdapter.Fill(dsSales.equipmentModify);
            }
            catch (Exception) { }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.IsPostBack) return;
            if (User.Identity.IsAuthenticated)
                pnlHide.Visible = true;
            else
                Response.Redirect("~/Login.aspx");
            ownedequipments = new List<string[]>();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (lstEquipment.Items.Count == 0)
            {
                lblRequired.Text = "Please add at least one equipment";
                return;
            }
            txtPC.Text = txtPC.Text.ToUpper();
            txtEmail.Text = txtEmail.Text.ToLower();
            txtFN.Text = txtFN.Text.Substring(0,1).ToUpper()+ txtFN.Text.Substring(1).ToLower();
            txtLN.Text = txtLN.Text.Substring(0, 1).ToUpper() + txtLN.Text.Substring(1).ToLower();
            txtCity.Text = txtCity.Text.Substring(0, 1).ToUpper() + txtCity.Text.Substring(1).ToLower();
            if (!revEmail.Text.Equals("") || !revPC.Text.Equals("") || !revPhone.Text.Equals("")||txtEquipment.Text.Equals("")||ddlType.SelectedIndex==0||ddlManufacturer.SelectedIndex==0) return;
            try
            {
                DataRow row = dsSales.customerModify.NewRow();
                row[1] = txtFN.Text;
                row[2] = txtLN.Text;
                row[3] = txtPhone.Text;
                row[4] = txtAddress.Text;
                row[5] = txtCity.Text;
                row[6] = txtPC.Text;
                row[7] = txtEmail.Text;
                dsSales.customerModify.Rows.Add(row);
                if (SaveCustomer())
                {
                    int id = Convert.ToInt32(dsSales.customerModify.Rows[dsSales.customerModify.Count - 1]["id"]);
                    try
                    {
                        foreach(string[] equipment in ownedequipments)
                        {
                            row = dsSales.equipmentModify.NewRow();
                            row[1] = equipment[0];
                            row[2] = getSerial();
                            row[3] = id;
                            row[4] = equipment[1];
                            row[5] = equipment[2];
                            dsSales.equipmentModify.Rows.Add(row);
                        }
                    }
                    catch { }
                    if (SaveEquipment())
                        Response.Redirect("SalesReceipt.aspx?id=" + id + "&name=" + txtFN.Text + " " + txtLN.Text);
                    else return;
                }
                else return;
            }
            catch { }
        }

        //update customer to database
        private bool SaveCustomer()
        {
            customerModifyTableAdapter customerModifyTableAdapter = new customerModifyTableAdapter();
            try
            {
                customerModifyTableAdapter.Update(dsSales.customerModify);
                dsSales.AcceptChanges();
                dsSales.customerModify.Clear();
                customerModifyTableAdapter.Fill(dsSales.customerModify);
                return true;
            }
            catch
            {
                dsSales.RejectChanges();
                return false;
            }
        }

        //update eqipment to database
        private bool SaveEquipment()
        {
            equipmentModifyTableAdapter equipmentModifyTableAdapter = new equipmentModifyTableAdapter();
            try
            {
                equipmentModifyTableAdapter.Update(dsSales.equipmentModify);
                dsSales.AcceptChanges();
                dsSales.equipmentModify.Clear();
                equipmentModifyTableAdapter.Fill(dsSales.equipmentModify);
                return true;
            }
            catch
            {
                dsSales.RejectChanges();
                return false;
            }
        }

        //random create a serial number
        private string getSerial()
        {
            string serial = "";
            Random random = new Random();
            int count = random.Next(10, 15);
            for (int i=0;i<count;i++)
            {
                int num = random.Next(0, 10);
                serial += num.ToString();
            }
            return serial;
        }

        //fill some demo data
        protected void btnDemo_Click(object sender, EventArgs e)
        {
            txtFN.Text = "John";
            txtLN.Text = "Smith";
            txtPhone.Text = "9051234567";
            txtAddress.Text = "Niagara College";
            txtCity.Text = "Welland";
            txtPC.Text = "L3C3L1";
            txtEmail.Text = "greenlightstudios@outlook.com";
            txtEquipment.Text = "demo equipment";
            ddlType.SelectedIndex = 1;
            ddlManufacturer.SelectedIndex = 1;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if(txtEquipment.Text.Equals("") || ddlType.SelectedValue=="-1"|| ddlManufacturer.SelectedValue=="-1") return;
            lstEquipment.Items.Add(txtEquipment.Text);
            string[] equpment = { txtEquipment.Text, ddlType.SelectedValue, ddlManufacturer.SelectedValue };
            ownedequipments.Add(equpment);
            lblRequired.Text = "";
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (lstEquipment.SelectedIndex == -1) return;
            ownedequipments.RemoveAt(lstEquipment.SelectedIndex);
            lstEquipment.Items.RemoveAt(lstEquipment.SelectedIndex);
        }
    }
}