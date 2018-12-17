<%--Andrew Butler--%>

<%@ Page Title="Search Repairs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RepairSearch.aspx.cs" Inherits="ESEWebsite.Repairs.RepairSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlHide" runat="server" Visible="False">
        <asp:Panel ID="pnlSearch" runat="server" Visible="False">
            <div>
                <br />
                <h1 class="text-center">Repair Search</h1>
                <div class="row">
                    <div class="panel panel-primary center-block">
                        <asp:Label ID="lblMessage" Style="padding: 2px" CssClass="text-primary" runat="server"></asp:Label>
                        <div class="text-center panel-body">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="h6">Start Date:</label>
                                    <asp:TextBox ID="txtStartDate" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="h6">End Date:</label>
                                    <asp:TextBox ID="txtEndDate" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="h6">Model:</label>
                                    <asp:DropDownList ID="ddlEquipment" class="center-block dropdown form-control" runat="server" DataSourceID="dsModel" DataTextField="equModel" DataValueField="equModel" AppendDataBoundItems="True">
                                        <asp:ListItem Value="None">None</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="h6">Service Type:</label>
                                    <asp:DropDownList ID="ddlService" class="center-block dropdown form-control" runat="server" DataSourceID="dsServiceType" DataTextField="serName" DataValueField="serName" AppendDataBoundItems="True">
                                        <asp:ListItem Value="None">None</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label class="h6">Employee:</label>
                                    <asp:DropDownList ID="ddlEmployee" class="center-block dropdown form-control" runat="server" DataSourceID="dsEmployee" DataTextField="empFull" DataValueField="empFull" AppendDataBoundItems="True">
                                        <asp:ListItem Value="None">None</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnSubmit" class="btn btn-primary btn-md" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnClear" class="btn btn-danger btn-md" runat="server" Text="Clear" visible="true" OnClick="btnClear_Click"/>
                                
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <br />
        <div>
            <asp:Button ID="btnNewSearch" class="btn btn-primary btn-md" runat="server" Text="New Search" visible="false" OnClick="btnNewSearch_Click"/>
        </div>

        <asp:Label ID="lblResults" Style="padding: 2px" CssClass="text-danger" runat="server"></asp:Label>

        <asp:GridView ID="gvRepair" runat="server" AllowSorting="True" AutoGenerateColumns="false" class="table" CellPadding="4" ForeColor="#34495E" GridLines="None" DataKeyNames="id" OnSelectedIndexChanged="gvRepair_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="serordDateIn" HeaderText="Start Date" SortExpression="serordDateIn" DataFormatString="{0:d}" />
                <asp:BoundField DataField="serordDateOut" HeaderText="End Date" SortExpression="serordDateOut" DataFormatString="{0:d}" />
                <asp:BoundField DataField="serordIssue" HeaderText="Issue" SortExpression="serordIssue" />
                <asp:CheckBoxField DataField="serordWarranty" HeaderText="Warranty" SortExpression="serordWarranty">
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CheckBoxField>
                <asp:BoundField DataField="receiptID" HeaderText="Receipt ID" SortExpression="receiptID" />
                <asp:BoundField DataField="empFull" HeaderText="Employee" SortExpression="empFull" ReadOnly="True" />
                <asp:BoundField DataField="equModel" HeaderText="Model" SortExpression="equModel" />
                <asp:BoundField DataField="serName" HeaderText="Service" SortExpression="serName" />
                <asp:CommandField ShowSelectButton="True">
                    <ItemStyle ForeColor="#1ABC9C" />
                </asp:CommandField>
            </Columns>
        </asp:GridView>

        <br />

        <asp:Panel ID="pnlEdit" runat="server" Visible="False">
            <div>

                <div class="row">
                    <div class="panel panel-primary center-block">
                        <asp:Label ID="lblSave" Style="padding: 20px" CssClass="text-danger" runat="server"></asp:Label>
                        <div class="text-center panel-body">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="h6">Start Date:</label>
                                    <asp:TextBox ID="txtStartDateEdit" class="center-block form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="h6">End Date:</label>
                                    <asp:TextBox ID="txtEndDateEdit" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="vEndDate" runat="server" ControlToValidate="txtEndDateEdit" ErrorMessage="End date required." ForeColor="#1ABC9C"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <label class="h6">Issue:</label>
                                    <asp:TextBox ID="txtIssue" class="center-block form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="h6">Model:</label>
                                    <asp:DropDownList ID="ddlEquipEdit" class="center-block dropdown form-control" runat="server" DataSourceID="dsModel" DataTextField="equModel" DataValueField="id" AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="h6">Warranty:</label>

                                    <asp:CheckBox ID="cbWarranty" runat="server" />

                                </div>
                                <div class="form-group">
                                    <label class="h6">Service Type:</label>
                                    <asp:DropDownList ID="ddlSerEdit" class="center-block dropdown form-control" runat="server" DataSourceID="dsServiceType" DataTextField="serName" DataValueField="id" AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label class="h6">Employee:</label>
                                    <asp:DropDownList ID="ddlEmpEdit" class="center-block dropdown form-control" runat="server" DataSourceID="dsEmployee" DataTextField="empFull" DataValueField="id" AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div>
                                <asp:Button ID="btnUpdate" class="btn btn-primary btn-md" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnOrder" class="btn btn-info btn-md" runat="server" Text="Order" visible="true" OnClick="btnOrder_Click" CausesValidation="False"/>
                                <asp:Button ID="btnDelete" class="btn btn-danger btn-md" runat="server" Text="Delete" OnClick="btnDelete_Click" CausesValidation="False" />

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:LinkButton ID="btnBack" runat="server" OnClick="btnBack_Click" CausesValidation="False">Back to Results</asp:LinkButton>

        <br />
        <asp:ObjectDataSource ID="dsRepairSearch" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.service_orderTableAdapter"></asp:ObjectDataSource>

        <asp:ObjectDataSource ID="dsModel" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.equipmentTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsServiceType" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.serviceTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsEmployee" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.employeeTableAdapter"></asp:ObjectDataSource>

        

        <br />

    </asp:Panel>
</asp:Content>
