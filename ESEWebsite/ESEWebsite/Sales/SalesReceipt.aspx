<%@ Page Title="New Sale" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesReceipt.aspx.cs" Inherits="ESEWebsite.Sales.SalesReceipt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">    
    <br />
    <div>
        <div id="receipt" runat="server" >
        <h1 class="text-center">Sales For <%=Request.QueryString["name"] %></h1>
        <div class="form-group">
            <asp:DropDownList ID="ddlType" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                <asp:ListItem Selected="True" Value="Null">--Select Sale Type--</asp:ListItem>
                <asp:ListItem>Purchase</asp:ListItem>
                <asp:ListItem>Repair</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div id="purchase" runat="server">
    <h1 class="text-center">Purchase</h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label6" runat="server" Text="Product" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlProduct" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" AutoPostBack="True" DataSourceID="dsProducts" DataTextField="product" DataValueField="id" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0">--Select a Product--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lblCount" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="Product Price" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtProductPrice" runat="server" ReadOnly="True" CssClass="center-block form-control" ForeColor="Black">0</asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label8" runat="server" Text="Quantity" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlQuantity" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" Enabled="False" AutoPostBack="True">
                            <asp:ListItem Selected="True">0</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    </div>
                <br />
                <div>
                    <div  class="col-md-6">
                        <asp:Button ID="btnAdd" runat="server" Text="Add To Orders" CssClass="btn btn-primary btn-hg" OnClick="btnAdd_Click" />
                    </div>
                    <div  class="col-md-6">
                        <asp:Button ID="btnSubmitPurchase" runat="server" Text="Check Out" CssClass="btn btn-primary btn-hg" OnClick="btnSubmitPurchase_Click1" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="repair" runat="server">
        <h1 class="text-center">Service</h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">
                 <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="Service" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlService" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsServices" DataTextField="serName" DataValueField="id" AutoPostBack="True" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="0">--Select a Service--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label11" runat="server" Text="Service Price" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtServicePrice" runat="server" ReadOnly="True" CssClass="center-block form-control" ForeColor="Black">0</asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Equipment" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlEqipment" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsEuipment" DataTextField="equModel" DataValueField="id">
                            <asp:ListItem Selected="True" Value="0">--Select an Equipment--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div> 
                 </div>
                <br />
                <div>
                    <div class="col-md-6">
                        <asp:Button ID="btnAdd2" runat="server" Text="Add To Orders" CssClass="btn btn-primary btn-hg" OnClick="btnAdd2_Click" />
                    </div>
                    <div class="col-md-6">
                        <asp:Button ID="btnSubmitRepair" runat="server" Text="Check Out" CssClass="btn btn-primary btn-hg" OnClick="btnSubmitRepair_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="order" runat="server">
    <h1 class="text-center">Orders For <%=Request.QueryString["name"] %></h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label13" runat="server" Text="Order Date" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="center-block form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label12" runat="server" Text="Order Number" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtOrderNum" runat="server" CssClass="center-block form-control" ReadOnly="True" ForeColor="Black">0</asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label15" runat="server" Text="Payment" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlPayment" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsPaymentType" DataTextField="payType" DataValueField="id">
                            <asp:ListItem Selected="True" Value="Null">--Select a Payment--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label16" runat="server" Text="Sale Person" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlSalePerson" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsSalesPerson" DataTextField="Employee Fullname" DataValueField="id">
                            <asp:ListItem Selected="True" Value="Null">--Select a Sale--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label10" runat="server" Text="Order Note" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtNote" runat="server" CssClass="center-block form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label14" runat="server" Text="Order Paid" CssClass="h6"></asp:Label>
                            <asp:CheckBox ID="ckbPaid" runat="server" CssClass="center-block" />
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4">
                        <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit" CssClass="btn btn-primary btn-hg" OnClick="btnSubmitOrder_Click" />
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="lblResult" runat="server" ForeColor="#48C9B0" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-primary btn-hg" OnClick="btnBack_Click" />
                    </div>
                </div>
                <br />
                <div class="text-center">
                    <asp:Button ID="btnDemo" runat="server" Text="Fill" OnClick="btnDemo_Click" />
                </div>
            </div>
        </div>
    </div>
    </div>
    <asp:GridView ID="gvItems" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Center" Width="1148px" AutoGenerateDeleteButton="True" OnRowDeleting="gvItems_RowDeleting" ShowFooter="True">
        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    <br />
    <asp:GridView ID="gvServices" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Center" Width="1148px" AutoGenerateDeleteButton="True" OnRowDeleting="gvServices_RowDeleting" ShowFooter="True">
        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    <asp:ObjectDataSource ID="dsSalesPerson" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.employeeTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsProducts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.ProductsTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsServices" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.servicesTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsPaymentType" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.PaymentTypesTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsEuipment" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.equipmentTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Panel>
</asp:Content>