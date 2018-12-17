<%--Graeme Fraser--%>
<%@ Page Title="New Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrdersNew.aspx.cs" Inherits="ESEWebsite.Orders.OrdersNew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<asp:Panel ID="pnlHide" runat="server" Visible="False">
    <div>
        <br />
        <h1 class="text-center">New Order</h1>
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
                    <label class="h6">Quantity:</label>
                    <asp:TextBox ID="txtQuantity" class="center-block form-control" runat="server"></asp:TextBox>
                </div>
                <br />
                <div>
                <div class="form-group">
                    <label class="h6">Order Price:</label>
                    <asp:TextBox ID="txtPrice" class="center-block form-control" runat="server" ReadOnly="True"></asp:TextBox>
                </div>
                    <asp:Button ID="btnSubmit" class="btn btn-primary btn-hg" runat="server" Text="Create Order" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Panel>
</asp:Content>

