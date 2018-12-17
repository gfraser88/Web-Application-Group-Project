<%--Andrew Butler--%>

<%@ Page Title="New Repair" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RepairNew.aspx.cs" Inherits="ESEWebsite.Repairs.NewRepair" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlHide" runat="server" Visible="False">
        <div>
            <br />
            <h1 class="text-center">Create Repair</h1>
            <div class="row">
                <div class="panel panel-primary center-block">
                    <div class="text-center panel-body">
        <div class="col-md-3">
                <div class="form-group">
                    <label class="h6">Repair Ticket To Create:</label>
                    <br />
                <asp:ListBox ID="lstServices" class="center-block form-control"  Style="height:100px;" runat="server" OnSelectedIndexChanged="lstServices_SelectedIndexChanged"></asp:ListBox>
                </div>
                    <br />
                    <div>
                    <asp:Button ID="btnSelect" class="btn btn-primary btn-hg" runat="server" Text="Select" OnClick="btnSelect_Click" CausesValidation="False" />
                    </div>
            <br />
            <div>
                
                <asp:Label ID="lblWarning" runat="server" Text="Remember, a repair ticket can only be created after a repair order has been processed.<br> Unless you know the required information, please create a <a href='../Sales/CustomersSearch.aspx'>new repair sale</a> order to make a repair ticket."></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblSave" runat="server" Text="Label"></asp:Label>
            </div>
            </div>
        <div class="col-md-1">
            <div style="margin: 0 auto; border-left: 3px solid #1abc9c; height: 500px;"></div>
        </div>
        <div class="col-md-4">
                <div class="form-group">
                    <label class="h6">Start Date:</label>
                    <asp:TextBox ID="txtStartDate" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="vStartDate" runat="server" ControlToValidate="txtStartDate" ErrorMessage="Please enter a start date." ForeColor="#1ABC9C" ValidationGroup="v"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label class="h6">End Date:</label>
                    <asp:TextBox ID="txtEndDate" TextMode="Date" class="center-block form-control" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="h6">Issue:</label>
                    <asp:TextBox ID="txtIssue" class="center-block form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="vIssue" runat="server" ControlToValidate="txtIssue" ErrorMessage="Please enter a brief description of the issue." ForeColor="#1ABC9C" ValidationGroup="v"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label class="h6">Warranty:</label>
                    <asp:CheckBox ID="cbWarranty" runat="server" />
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <label class="h6">Receipt:</label>
                    <asp:TextBox ID="txtReceipt" class="center-block form-control" runat="server" CausesValidation="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="vReceipt" runat="server" ErrorMessage="A receipt number is required." ControlToValidate="txtReceipt" ForeColor="#1ABC9C" ValidationGroup="v"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label class="h6">Service Type:</label>
                     <asp:DropDownList ID="ddlService" class="center-block dropdown form-control" runat="server" DataSourceID="dsService" DataTextField="serName" DataValueField="id">
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="h6">Equipment Type:</label>
                    <asp:DropDownList ID="ddlEquipment" class="center-block dropdown form-control" runat="server" DataSourceID="dsEquipment" DataTextField="equModel" DataValueField="id">
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="h6">Employee:</label>
                    <asp:DropDownList ID="ddlEmployee" class="center-block dropdown form-control" runat="server" DataSourceID="dsEmployee" DataTextField="empFull" DataValueField="id">
                    </asp:DropDownList>
                </div>
                <br />
                </div>
                <div>
                    <asp:Button ID="btnSubmit" class="btn btn-primary btn-hg" runat="server" Text="Create" OnClick="btnSubmit_Click" ValidationGroup="v" />
                    <br />
                </div>

                
                    </div>
                </div>
            </div>
        </div>
        
            <asp:ObjectDataSource ID="dsEquipment" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.equipmentTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsRepairSearch" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.service_orderTableAdapter"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsEmployee" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.employeeTableAdapter"></asp:ObjectDataSource>
        
        <asp:ObjectDataSource ID="dsService" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsRepairSearchTableAdapters.serviceTableAdapter"></asp:ObjectDataSource>
        
        <br />
        
        <br />
        <br />
    </asp:Panel>
</asp:Content>
