<%--Andrew Butler--%>
<%@ Page Title="Register User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="ESEWebsite.RegisterPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <br />
        <h1 class="text-center">Register</h1>
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
                            <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label class="h6">Confirm:</label>
                            <asp:TextBox ID="txtPasswordConfirm" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                      
                        <div>
                            <asp:Button ID="btnRegister" class="btn btn-primary btn-hg" runat="server" Text="Register" OnClick="btnRegister_Click" />
                        </div>
                        <div>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" class="text-danger" ControlToValidate="txtUsername" ErrorMessage="Username is required." SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" class="text-danger" ControlToValidate="txtPassword" ErrorMessage="Password is required." SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" class="text-danger" ControlToCompare="txtPassword" ControlToValidate="txtPasswordConfirm" ErrorMessage="Password does not match." SetFocusOnError="True" Display="Dynamic"></asp:CompareValidator>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" class="text-danger" ControlToValidate="txtPasswordConfirm" ErrorMessage="Must confirm password." SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div>
                            <asp:Label ID="lblMessage" runat="server" class="text-danger" Text=""></asp:Label>
                        </div>
                    </div>
                    </div>
                <div class="col-md-5">
                        <img src="images/register.png" alt="Register Icon" height="350" width="350">
                    </div>
                 </div>
          </div>      
</asp:Content>
