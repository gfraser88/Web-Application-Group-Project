<%@ Page Title="New Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewCustomer.aspx.cs" Inherits="ESEWebsite.Sales.SalesNew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">
    <div>
        <br />
        <h1 class="text-center">New Customer</h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="lblFN" runat="server" Text="First Name" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtFN" runat="server" CssClass="center-block form-control" MaxLength="30"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqFName" runat="server" ControlToValidate="txtFN" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter a first name." ValidationGroup="validation"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblAddress" runat="server" Text="Address" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="center-block form-control" MaxLength="60"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPhone" runat="server" Text="Phone" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="center-block form-control" MaxLength="10"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="Phone Number is Invalid" ForeColor="#FF3300" ValidationExpression="^[0-9]{10}$" ValidationGroup="validation"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="lblLN" runat="server" Text="Last Name" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtLN" runat="server" CssClass="center-block form-control" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqLName" runat="server" ControlToValidate="txtLN" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter a last name." ValidationGroup="validation"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblCity" runat="server" Text="City" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="center-block form-control" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCity" runat="server" ControlToValidate="txtCity" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please enter a city." ValidationGroup="validation"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="center-block form-control" MaxLength="30"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email Address is Invalid" ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$" ValidationGroup="validation"></asp:RegularExpressionValidator>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPC" runat="server" Text="Post Code" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtPC" runat="server" CssClass="center-block form-control" MaxLength="6"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revPC" runat="server" ControlToValidate="txtPC" Display="Dynamic" ErrorMessage="Post Code is Invalid" ForeColor="#FF3300" ValidationExpression="(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstv‌​xy]{1} *\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvxy]{1}\d{1}$)" ValidationGroup="validation"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
                <hr style="background-color:#48C9B0;height:3px;"/>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="Owned Equipment" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtEquipment" runat="server" CssClass="center-block form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Equipment Type" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlType" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsType" DataTextField="eqtType" DataValueField="id" >
                                <asp:ListItem Selected="True" Value="-1">-- Select a Type --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" Text="Equipment Manufacturer" CssClass="h6"></asp:Label>
                            <asp:DropDownList ID="ddlManufacturer" runat="server" AppendDataBoundItems="True" CssClass="center-block dropdown form-control" DataSourceID="dsManufacturer" DataTextField="manName" DataValueField="id" >
                                <asp:ListItem Selected="True" Value="-1">-- Select a Munufacturer --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="Owned Equipments" CssClass="h6"></asp:Label>
                            <asp:ListBox ID="lstEquipment" class="center-block" runat="server" Rows="5" Width="456px" Height="200px"></asp:ListBox>
                            <asp:Label ID="lblRequired" runat="server" CssClass="text-danger" Text=""></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnAdd" runat="server" Text="Add Equipment" CssClass="btn btn-primary btn-md" OnClick="btnAdd_Click" />
                            &nbsp;
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-md" Text="Delete Equipment" OnClick="btnDelete_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <div>
                    <asp:Button ID="btnSubmit" runat="server" Text="Create Customer" OnClick="btnSubmit_Click" CssClass="btn btn-primary btn-hg" ValidationGroup="validation" />
                </div>
            </div>
        </div>
    </div>
    <div class="text-center">
        <asp:Button ID="btnDemo" runat="server" Text="Fill" OnClick="btnDemo_Click" />
        <asp:ObjectDataSource ID="dsType" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.equip_typeTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsManufacturer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.manufacturerTableAdapter"></asp:ObjectDataSource>
    </div>
</asp:Panel>
</asp:Content>
