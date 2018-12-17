<%--Aaron Buchwald--%>

<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="ESEWebsite.Purchasing.Inventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">
        <div>
            <br />
            <h1 class="text-center">Inventory</h1>
            <div class="row">
                <div class="panel panel-primary center-block">
                    <div class="text-center panel-body">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="h6">Item Name:</label>
                                <asp:TextBox ID="txtItemName" class="center-block form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="h6">Item #:</label>
                                <asp:TextBox ID="txtItemNumber" class="center-block form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="h6">In Stock:</label>
                                <asp:CheckBox runat="server" ID="chkInStock"/>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="h6">En Route:</label>
                                <asp:CheckBox runat="server" ID="chkEnRoute"/>
                            </div>
                        </div>
                    </div>        
                <div style="text-align:center; padding-bottom:2em;">
                    <asp:Button ID="btnSubmit" class="btn btn-primary btn-hg" runat="server" Text="Search" OnClick="btnSubmit_Click" />
                <div/>
                </div>
                </div>
                </div>
            </div>
    </asp:Panel>
</asp:Content>

