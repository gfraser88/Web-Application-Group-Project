<%--Graeme Fraser--%>
<%@ Page Title="Search Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrdersSearch.aspx.cs" Inherits="ESEWebsite.Orders.OrdersSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">
        <div>
        <br />
        <h1 class="text-center">Search Order</h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">                            
                <div class="form-group">
                    <label class="h6">Invoice Number:</label>
                    <asp:TextBox ID="txtInvoiceNumber" class="center-block form-control" runat="server"></asp:TextBox>
                </div>                
                <div class="form-group">
                    <label class="h6">Product:</label>
                    <asp:DropDownList ID="ddlProduct" class="center-block dropdown form-control" runat="server">
                    </asp:DropDownList>
                </div>                          
                <div class="form-group">
                    <label class="h6">Arrival Date:</label>
                    <asp:TextBox ID="txtArrivalDate" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                </div>
                <br />
                <div>
                    <asp:Button ID="btnSearch" class="btn btn-primary btn-hg" runat="server" Text="Search Order" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>
    </asp:Panel>
</asp:Content>

