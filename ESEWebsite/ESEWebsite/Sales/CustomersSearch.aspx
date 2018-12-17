<%@ Page Title="Search Customers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomersSearch.aspx.cs" Inherits="ESEWebsite.Sales.SalesSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlHide" runat="server" Visible="False">    
    <div>
    <br />
    <h1 class="text-center">Search Customers</h1>
        <div class="panel panel-primary center-block">
            <div class="text-center panel-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblFN" runat="server" Text="First Name:" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtFN" class="center-block form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPhone" runat="server" Text="Phone Number:" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtPhone" class="center-block form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <asp:Label ID="lblLN" runat="server" Text="Last Name:" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtLN" class="center-block form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblModel" runat="server" Text="Email Address:" CssClass="h6"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" class="center-block form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <br/>
                <div>
                    <asp:Button ID="btnSearch"  class="btn btn-primary btn-hg" runat="server" Text="Search" OnClick="btnSearch_Click"/>
                </div>
            </div>
        </div>
    </div>
                    <asp:Label ID="lblResults" runat="server" CssClass="text-danger" Style="padding: 2px"></asp:Label>
                    <asp:GridView ID="gvCustomer" onrowdatabound="gvCustomer_RowDataBound" DataKeyNames="id" runat="server" AutoGenerateColumns="False" DataSourceID="dsCustomer" CellPadding="4"  ForeColor="Black" GridLines="Horizontal" Width="1148px" HorizontalAlign="Center" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" AllowSorting="True" PageSize="15">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="btnNew" runat="server" OnClick="btnNew_Click">New Customer</asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" OnClick="LinkButton1_Click" Text="Detail"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Fullname" HeaderText="Fullname" SortExpression="Fullname" ReadOnly="True" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                            <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                            <asp:BoundField DataField="Postal" HeaderText="Postal" SortExpression="Postal" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" InsertVisible="False" ReadOnly="True" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="White" ForeColor="Black" />
                        <SortedAscendingCellStyle BackColor="White" />
                        <SortedAscendingHeaderStyle BackColor="White" />
                        <SortedDescendingCellStyle BackColor="White" />
                        <SortedDescendingHeaderStyle BackColor="White" />
                    </asp:GridView>
                    <asp:DetailsView ID="dvCustomer" runat="server" AutoGenerateRows="False" DataSourceID="dsCustomerDetail" Height="50px" Width="720px" HorizontalAlign="Center" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" DataKeyNames="id" HeaderText="Customer information">
                        <EditRowStyle BackColor="White" ForeColor="Black" />
                        <Fields>
                            <asp:TemplateField HeaderText="First Name" SortExpression="First Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFN" runat="server" Text='<%# Bind("[First Name]") %>' MaxLength="30"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[First Name]") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("[First Name]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" SortExpression="Last Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLN" runat="server" Text='<%# Bind("[Last Name]") %>' MaxLength="50"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("[Last Name]") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("[Last Name]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' MaxLength="10"></asp:TextBox>
                                    <br />
                                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="Phone Number is Invalid" ForeColor="#FF3300" ValidationExpression="^[0-9]{10}$"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Phone") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>' MaxLength="60"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="City" SortExpression="City">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' MaxLength="50"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Postal Code" SortExpression="Postal Code">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPC" runat="server" Text='<%# Bind("[Postal Code]") %>' MaxLength="6"></asp:TextBox>
                                    <br />
                                    <asp:RegularExpressionValidator ID="revPC" runat="server" ControlToValidate="txtPC" Display="Dynamic" ErrorMessage="Post Code is Invalid" ForeColor="#FF3300" ValidationExpression="(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXYabceghjklmnprstvxy]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstv‌​xy]{1} *\d{1}[ABCEGHJKLMNPRSTVWXYZabceghjklmnprstvxy]{1}\d{1}$)"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("[Postal Code]") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("[Postal Code]") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="30"></asp:TextBox>
                                    <br />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email Address is Invalid" ForeColor="#FF3300" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <div class="text-center">
                                        Equipment
                                        <asp:TextBox ID="txtEquipment" runat="server" MaxLength="50"></asp:TextBox>
                                        <br />
                                        Type
                                        <asp:DropDownList ID="ddlType" runat="server" AppendDataBoundItems="True" DataSourceID="dsType" DataTextField="eqtType" DataValueField="id">
                                            <asp:ListItem Selected="True" Value="-1">--Select a Type--</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;<br /> Manufacturer
                                        <asp:DropDownList ID="ddlManufacturer" runat="server" AppendDataBoundItems="True" DataSourceID="dsManufacturer" DataTextField="manName" DataValueField="id">
                                            <asp:ListItem Selected="True" Value="-1">--Select a Munufacturer--</asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary btn-md" OnClick="btnAdd_Click" Text="Add Equipment" />
                                        <asp:ObjectDataSource ID="dsManufacturer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.manufacturerTableAdapter"></asp:ObjectDataSource>
                                        <asp:ObjectDataSource ID="dsType" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.equip_typeTableAdapter"></asp:ObjectDataSource>
                                    </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnNewSales" runat="server" CausesValidation="false" CommandName="Cancel" OnClick="btnNewSales_Click" Text="New Sales"></asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CommandName="Cancel" OnClick="btnCancel_Click" Text="Cancel"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CausesValidation="false" CommandName="Cancel" OnClick="btnUpdate_Click" Text="Update"></asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnCancelUpdate" runat="server" CausesValidation="false" CommandName="Cancel" OnClick="btnCancelUpdate_Click" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Cancel" OnClick="LinkButton1_Click1" Text="Edit"></asp:LinkButton>
                                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="Cancel" Text="Delete" OnClientClick="javascript:return confirm('Are you sure you want to delete? Be aware that also all related sales records will be deleted.');" OnClick="btnDelete_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    </asp:DetailsView>
                    <asp:GridView ID="gvEquipment" runat="server" AutoGenerateColumns="False" GridLines="Horizontal" Width="720px" HorizontalAlign="Center" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" DataKeyNames="id" DataSourceID="dsEquipment" OnRowDataBound="gvEquipment_RowDataBound" >
                        <Columns>
                            <asp:TemplateField HeaderText="id" InsertVisible="False" SortExpression="id">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblID" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="equModel" HeaderText="Owned Equipments" SortExpression="equModel" />
                            <asp:BoundField DataField="eqtType" HeaderText="Type" SortExpression="eqtType" />
                            <asp:BoundField DataField="manName" HeaderText="Manufacturer" SortExpression="manName" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDeleteEquipment" runat="server" CausesValidation="False" CommandName="Select" OnClick="btnDeleteEquipment_Click" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:GridView ID="gvServiceHistory" runat="server" AutoGenerateColumns="False" DataSourceID="dsServiceHistory" GridLines="Horizontal" Width="720px" HorizontalAlign="Center" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" >
                        <Columns>
                            <asp:BoundField DataField="Service" HeaderText="Service" SortExpression="Service" />
                            <asp:BoundField DataField="Equipment" HeaderText="Equipment" SortExpression="Equipment" />
                            <asp:BoundField DataField="Order Date" HeaderText="Order Date" SortExpression="Order Date" />
                            <asp:BoundField DataField="Employee" HeaderText="Employee" ReadOnly="True" SortExpression="Employee" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
                    <asp:GridView ID="gvPurchaseHistory" runat="server" AutoGenerateColumns="False" DataSourceID="dsPurchaseHistory" GridLines="Horizontal" Width="720px" HorizontalAlign="Center" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black">
                        <Columns>
                            <asp:BoundField DataField="Purchase History" HeaderText="Purchase" SortExpression="Purchase History" />
                            <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                            <asp:BoundField DataField="Order Date" HeaderText="Order Date" SortExpression="Order Date" />
                            <asp:BoundField DataField="Employee" HeaderText="Employee" ReadOnly="True" SortExpression="Employee" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
                    <asp:ObjectDataSource ID="dsCustomer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.customerTableAdapter">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtPhone" DefaultValue="" Name="phone" PropertyName="Text" Type="String" Size="10" />
                            <asp:ControlParameter ControlID="txtFN" DefaultValue="" Name="first" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtLN" DefaultValue="" Name="last" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" Type="String" />
                        </SelectParameters>
    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="dsCustomerDetail" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.CustomerDetailTableAdapter">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvCustomer" DefaultValue="-1" Name="id" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="dsServiceHistory" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.ServiceHistoryTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCustomer" DefaultValue="-1" Name="id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="dsPurchaseHistory" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.PurchaseHistoryTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvCustomer" DefaultValue="-1" Name="id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsEquipment" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ESELibrary.dsSalesTableAdapters.ownedEquipmentsTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="gvCustomer" DefaultValue="-1" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
</asp:Panel>
</asp:Content>
