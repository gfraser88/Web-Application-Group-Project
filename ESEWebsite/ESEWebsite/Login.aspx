<%--Andrew Butler--%>
<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ESEWebsite.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <br />
        <h1 class="text-center">Login</h1>
        <div class="panel panel-primary center-block">
            <div class="panel-body">
                <div class="col-md-2"></div>
                <div class="col-md-4">
                <div class="form-group">
                    <label class="h6">Username:</label>
                    <asp:TextBox ID="txtUsername" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="h6">Password:</label>
                    <asp:TextBox ID="txtPassword"  class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                </div>
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                <br />
                <div>
                    <asp:Button ID="btnLogin" class="btn btn-primary btn-hg" runat="server" Text="Login" OnClick="btnLogin_Click" /> 
                    <asp:Button ID="btnRegister" class="btn btn-link btn-hg" runat="server" Text="Register" OnClick="btnRegister_Click" />
                </div>
            </div>
            <div class="col-md-5">
            <img src="images/login.png" alt="Login Icon" height="350" width="350">
            </div>
        </div>
            
    </div>
        
</div>

</asp:Content>
