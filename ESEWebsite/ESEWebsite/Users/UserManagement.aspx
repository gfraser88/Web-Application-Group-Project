<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="ESEWebsite.Users" %>
<%--<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">  
    <h1>Current Employees</h1>
     <div class="panel panel-primary center-block">
            <div class="text-center panel-body">                            
                <div class="form-group">
                    <label class="h6">Choose An Employee</label><br />
                    <br />
                    <asp:ObjectDataSource ID="odsEmployeeSearch" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsEmployeeTableAdapters.employeeTableAdapter"></asp:ObjectDataSource>    
                    <asp:ObjectDataSource ID="odsEmployee" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsEmployeeTableAdapters.UpdateemployeeTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_id" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="empFirst" Type="String" />
                            <asp:Parameter Name="empLast" Type="String" />
                            <asp:Parameter Name="posID" Type="Int32" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvEmployee" DefaultValue="0" Name="Param1" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="empFirst" Type="String" />
                            <asp:Parameter Name="empLast" Type="String" />
                            <asp:Parameter Name="posID" Type="Int32" />
                            <asp:Parameter Name="Original_id" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <div class="gvCreate">
                        <asp:Button  style="float:left" ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary btn-hg" OnClick="btnNew_Click"/>
                        <br />
                        <br />
                    <asp:GridView ID="gvEmployee" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="lead" DataKeyNames="id" DataSourceID="odsEmployeeSearch" GridLines="Horizontal" HorizontalAlign="Center" OnSelectedIndexChanged="gvEmployee_SelectedIndexChanged" Width="750px" BorderColor="#4A5F75">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select" Text="Select" OnClick="btnSelect_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FullName" HeaderText="Name" ReadOnly="True" SortExpression="FullName" />
                            <asp:BoundField DataField="posName" HeaderText="Position" SortExpression="posName" />
                        </Columns>
                        <HeaderStyle BorderColor="#F2F6F8" BorderStyle="None" />
                    </asp:GridView>
                        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <asp:ObjectDataSource ID="odsPosition" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsEmployeeTableAdapters.positionTableAdapter"></asp:ObjectDataSource>
                    <br />
                    <asp:FormView ID="fvEmployee" runat="server" BorderStyle="None" CssClass="lead" DataKeyNames="id" DataSourceID="odsEmployee" HorizontalAlign="Center" Width="450px" BorderColor="White" OnItemDeleted="fvEmployee_ItemDeleted" OnItemInserted="fvEmployee_ItemInserted" OnItemUpdated="fvEmployee_ItemUpdated">
                        <EditItemTemplate>
                            <table style="width:100%;">
                                <tr>
                                    <td> </td>
                                    <td><asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' Visible="False" /></td>
                                </tr>
                                <tr>
                                    <td>First Name: <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter First Name" ControlToValidate="TextBox1" Display="Dynamic" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                                    </td>
                                    <td> <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("empFirst") %>' CssClass="center-block dropdown form-control" /></td>
                                </tr>
                                <tr>
                                    <td>Last Name: <br />
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="TextBox2" Display="Dynamic" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                                    </td>
                                    <td><asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("empLast") %>' CssClass="center-block dropdown form-control" /></td>
                                </tr>
                                <tr>
                                    <td>Position:</td>
                                    <td> 
                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="odsPosition" DataTextField="posName" DataValueField="id"  SelectedValue='<%# Bind("posID") %>' CssClass="center-block dropdown form-control">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" /></td>
                                    <td>&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" /></td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table style="width:100%">
                                <tr>
                                    <td style="height: 67px;">First Name: <br />
                                        <asp:RequiredFieldValidator ID="vFirstNew" runat="server" ErrorMessage="Enter First Name" ControlToValidate="TextBox3" Display="Dynamic" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="height: 67px;"> <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("empFirst") %>' CssClass="center-block dropdown form-control" /> </td>
                                </tr>
                                <tr>
                                    <td>Last Name:<br />
                                        <asp:RequiredFieldValidator ID="vLastNew" runat="server" ErrorMessage="Enter Last Name" ControlToValidate="TextBox4" Display="Dynamic" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                                    </td>
                                    <td><asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("empLast") %>' CssClass="center-block dropdown form-control" /></td>
                                </tr>
                                <tr>
                                    <td>Position:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="odsPosition" DataTextField="posName" DataValueField="id" SelectedValue='<%# Bind("posID") %>'>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table style="width:100%;">
                                <tr>
                                    <td style="text-align:left; width:80%;" >&nbsp;</td>
                                    <td style="text-align:left; width:20%; "> <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>' Visible="False" /> </td>
                                </tr>
                                <tr>
                                    <td style="text-align:left; width:80%;">First Name:</td>
                                    <td style="text-align:left; width:20%;"><asp:Label ID="empFirstLabel" runat="server" Text='<%# Bind("empFirst") %>' /></td>
                                </tr>
                                <tr>
                                    <td style="text-align:left; width:80%;">Last Name:</td>
                                    <td style="text-align:left; width:20%;"><asp:Label ID="empLastLabel" runat="server" Text='<%# Bind("empLast") %>' /></td>
                                </tr>
                                <tr>
                                    <td style="text-align:left; width:80%;">Position:</td>
                                    <td style="text-align:left; width:%;">
                                        <asp:DropDownList  ID="ddlPosition" runat="server" AutoPostBack="True" DataSourceID="odsPosition" DataTextField="posName" DataValueField="id" SelectedValue='<%# Bind("posID") %>' BackColor="#F2F6F8" Enabled="False" EnableTheming="True" ForeColor="#34495E" CssClass="noselect">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"/>
                            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                        </ItemTemplate>
                    </asp:FormView>
                    <br />
                    <br />
            </div>
        </div>
         </div>
    </asp:Panel>
</asp:Content>
