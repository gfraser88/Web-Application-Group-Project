<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GreenlightStudios.aspx.cs" Inherits="ESEWebsite.GreenlightStudios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div>
        <br />
        <div class="row">
            <div class="panel panel-primary center-block">
                <div class="text-center panel-body">
                    <img src="../images/greenlightlogo.png" />
                    <hr style="background-color: #48C9B0; height: 3px;" />
                    <div class="row">
                        <div class="col-md-6">

                            <h4>Members</h4>

                            <h6>Aaron Buchwald</h6>
                            <h6>Andrew Butler</h6>
                            <h6>Ziwei Chen</h6>
                            <h6>Graeme Fraser</h6>
                            <h6>Alex Gomez</h6>

                        </div>
                        <div class="col-md-6">
                            <h4>Agenda</h4>
                            <h6>1) Design Choices</h6>
                            <h6>2) User Management</h6>
                            <h6>3) Sale Navigation</h6>
                            <h6>4) Repair Navigation</h6>
                            <h6>5) Reports</h6>
                            <h6>6) Inventory</h6>
                            <h6>7) Questions</h6>
                        </div>

                    </div>
                    <hr style="background-color: #48C9B0; height: 3px;" />
                    <div class="row">
                        <h2><i>Emma's Small Engines</i></h2>
                    </div>
                    <div class="row">

                        <asp:Button ID="btnEnter" class="btn btn-primary btn-hg" runat="server" Text="Enter" OnClick="btnEnter_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
