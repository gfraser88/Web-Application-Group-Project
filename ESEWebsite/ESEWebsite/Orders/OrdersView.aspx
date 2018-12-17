<%@ Page Title="View Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrdersView.aspx.cs" Inherits="ESEWebsite.Orders.OrdersView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:Panel ID="pnlHide" runat="server" Visible="False">
    <div>
        <h1>Order Records
        </h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" class="table" DataSourceID="ObjectDataSource1" CellPadding="4" ForeColor="#34495e" GridLines="None">
            <AlternatingRowStyle BackColor="#edf0f4" />
            <Columns>
                <asp:BoundField DataField="onordInvoiceNum" HeaderText="Invoice Number" SortExpression="onordInvoiceNum" />
                <asp:BoundField DataField="onordArriveDate" HeaderText="Arrival Date" SortExpression="onordArriveDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="onordNumInOrder" HeaderText="Quantity" SortExpression="onordNumInOrder" />
                <asp:BoundField DataField="onordPrice" HeaderText="Price" SortExpression="onordPrice" DataFormatString="{0:c}" />
                <asp:BoundField DataField="prodName" HeaderText="Name" SortExpression="prodName" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsViewOrderTableAdapters.on_orderTableAdapter"></asp:ObjectDataSource>
        <br />

    </div>
</asp:Panel>
</asp:Content>
