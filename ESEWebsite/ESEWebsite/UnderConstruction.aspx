<%@ Page Title="Under Construction" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UnderConstruction.aspx.cs" Inherits="ESEWebsite.UnderConstruction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h1 class="h1 text-center">Under Construction</h1>
        <br />
        <div class="text-center">
        <img src="images/toolbox.png" alt="Toolbox" class="img img-fluid" width="500px">
        </div>
        <br />
        <br />
        <div class="row">
        <div class="col-md-4"></div>
        <div class="text-center col-md-2">
        <asp:Button ID="btnHome" class="btn btn-primary btn-hg" runat="server" Text="Go Home" OnClick="btnHome_Click" />
        </div>
        <div class="text-center col-md-2">
        <asp:Button ID="btnBack" class="btn btn-primary btn-hg" runat="server" Text="Go Back" />
        </div>
        <div class="col-md-4"></div>
        </div>
    </div>
</asp:Content>
