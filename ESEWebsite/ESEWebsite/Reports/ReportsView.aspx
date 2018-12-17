<%--Graeme Fraser--%>
<%@ Page Title="View Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportsView.aspx.cs" Inherits="ESEWebsite.Reports.ReportsView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:Panel ID="pnlHide" runat="server" Visible="False">    
    <div>
        <br />
        <h1 class="text-center">View Report</h1>
        <div class="panel panel-primary center-block">
            <div class="panel-body">
            <div class="row">
            <div class="text-center col-md-3">
            <asp:RequiredFieldValidator ID="valStartDate" runat="server" ControlToValidate="txtStartDate" CssClass="small text-danger" Display="Dynamic" ErrorMessage="Please enter a starting date." ValidationGroup="valReport"></asp:RequiredFieldValidator>
            </div>
            <div class="text-center col-md-3">
            <asp:RequiredFieldValidator ID="valEndDate" runat="server" ControlToValidate="txtEndDate" CssClass="small text-danger" Display="Dynamic" ErrorMessage="Please enter an ending date." ValidationGroup="valReport"></asp:RequiredFieldValidator>
            </div>
            </div>
                <div class="row">
                <div class="text-center form-group col-md-3">
                    <label class="h6">Starting Date:</label>
                    <asp:TextBox ID="txtStartDate" runat="server" class="center-block form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="text-center form-group col-md-3">
                    <label class="h6">End Date:</label>
                    <asp:TextBox ID="txtEndDate" runat="server" class="center-block form-control" TextMode="Date" OnTextChanged="txtEndDate_TextChanged"></asp:TextBox>
                </div>
                <div class="text-center form-group col-md-2">
                <label class="h6">Customer:</label>
                <asp:DropDownList ID="ddlCustomer" class="center-block dropdown form-control" runat="server" DataSourceID="odsCustomer" DataTextField="custFull" DataValueField="custFull" AppendDataBoundItems="True" style="left: 4px; top: 0px">
                    <asp:ListItem Selected="True">All Customers</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="text-center form-group col-md-2">
                <label class="h6">Employee:</label>
                <asp:DropDownList ID="ddlEmployee" class="center-block dropdown form-control" runat="server" DataSourceID="odsEmployee" DataTextField="Employee" DataValueField="Employee" AppendDataBoundItems="True" style="left: 4px; top: 0px">
                    <asp:ListItem Selected="True">All Employees</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="text-center form-group col-md-2">
                <label class="h6">Warranty:</label>
                <asp:DropDownList ID="ddlWarranty" class="center-block dropdown form-control" runat="server" AppendDataBoundItems="True" style="left: 4px; top: 0px">
                    <asp:ListItem Selected="True" Value="True">With Warranty</asp:ListItem>
                    <asp:ListItem Value="False">Without Warranty</asp:ListItem>
                    <asp:ListItem>Both</asp:ListItem>
                    </asp:DropDownList>
                </div>
                </div>
                <div class="text-center form-group">
                    <asp:Button ID="btnSearch" class="btn btn-primary btn-hg" runat="server" Text="Search Report" OnClick="btnSearch_Click" ValidationGroup="valReport" />
                </div>
                
                <asp:Panel ID="pnlReport" runat="server">
                    <h5 class="h5">Services</h5>
                    <asp:Label ID="lblServiceResults" CssClass="text-danger" runat="server"></asp:Label>
                    <asp:GridView ID="gvService" runat="server" AllowSorting="True" AutoGenerateColumns="false" class="table table-hover" CellPadding="4" ForeColor="#34495E" GridLines="None" OnSorting="gvService_Sorting">
                    <Columns>
                        <asp:BoundField DataField="ordNumber" HeaderText="Order Number" SortExpression="services[0]" />
                        <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                        <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                        <asp:BoundField DataField="ordDate" HeaderText="Order Date" SortExpression="ordDate" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="serPrice" HeaderText="Service Price" SortExpression="serPrice" DataFormatString="{0:c}"/>
                        <asp:BoundField DataField="payType" HeaderText="Payment Type" SortExpression="payType" />
                        <asp:BoundField DataField="serName" HeaderText="Service Type" SortExpression="serName" />         
                        <asp:CheckBoxField DataField="serordWarranty" HeaderText="Warranty" SortExpression="serordWarranty">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                    </Columns>
                    </asp:GridView>
                    <h6 class="h6">Services Total: </h6><asp:Label ID="lblServiceTotal" class="text-primary" runat="server"></asp:Label>
                    <hr class="hrReport" />
                    <br />
                    <h5 class="h5">Sales</h5>
                    <asp:Label ID="lblSalesResults" CssClass="text-danger" runat="server"></asp:Label>
                    <asp:GridView ID="gvSales" runat="server" AllowSorting="True" AutoGenerateColumns="false" class="table table-hover" CellPadding="4" ForeColor="#34495E" GridLines="None" OnSorting="gvSales_Sorting">
                    <Columns>
                        <asp:BoundField DataField="ordNumber" HeaderText="Order Number" SortExpression="services[0]" />
                        <asp:BoundField DataField="Customer" HeaderText="Customer" SortExpression="Customer" />
                        <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
                        <asp:BoundField DataField="ordDate" HeaderText="Order Date" SortExpression="ordDate" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="orlQuantity" HeaderText="Quantity" SortExpression="orlQuantity"/>
                        <asp:BoundField DataField="orlPrice" HeaderText="Sale Price" SortExpression="orlPrice" DataFormatString="{0:c}"/>
                        <asp:BoundField DataField="payType" HeaderText="Payment Type" SortExpression="payType" />
                        <asp:BoundField DataField="prodName" HeaderText="Product" SortExpression="prodName" />
                    </Columns>
                    </asp:GridView>
                    <h6 class="h6">Sales Total: </h6><asp:Label ID="lblSalesTotal" class="text-primary" runat="server"></asp:Label>
                    <hr class="hrReport" />
                    <h4 class="h4">Combined Total: </h4><asp:Label ID="lblTotal" class="text-primary h5" runat="server"></asp:Label>
                    <h4 class="h4">2% Savings: </h4><asp:Label ID="lblPartySavings" class="text-primary h5" runat="server"></asp:Label>

                    </asp:Panel>
                    <asp:ObjectDataSource ID="odsService" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsReportTableAdapters.reportServiceTableAdapter"></asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="odsSale" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsReportTableAdapters.reportSaleTableAdapter"></asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="odsCustomer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsReportTableAdapters.customerTableAdapter"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsEmployee" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsReportTableAdapters.employeeTableAdapter"></asp:ObjectDataSource>
                </div>
              </div>  
        </div>
</asp:Panel>
</asp:Content>
