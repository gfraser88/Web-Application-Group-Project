<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ESEWebsite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:Panel ID="pnlHide" runat="server" Visible="False">
    <div class="jumbotron">
        <div class="row">
        <div class="col-md-6">
        <h1>Welcome <asp:Label ID="lblUser" runat="server"></asp:Label>
            </h1>
        <h2 class="lead">Quote of the day:</h2>
        <i class="lead">"A little progress each day adds up to big results."</i>
        </div>
        <div class="col-md-6">
            <img src="images/homepage.png" alt="Lawnmower cutting grass" class="img-responsive">
        </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Inventory Changes</h2>
            <p>
                Hey staff I just wanted to notify you guys that there have been some new items added to out inventory! If you would like to check them out
                feel free to head on over to the inventory section!
            </p>
        </div>
        <div class="col-md-4">
            <h2>Upcoming Team Meeting</h2>
            <p>
                This post is to notify all staff members that a team meeting will be held on December 9 2018 at 8:00AM. All staff members are expected to be there! Breakfast
                will be provided
            </p>
        </div>
        <div class="col-md-4">
            <h2>Black Friday Update</h2>
            <p>
                Just wanted to notify all staff members that Black Friday was a success and I am very proud of all team members that played a part on our success! It was a very busy day but we were
                able to push through and gt through the day. Good job Team!
            </p>
        </div>
    </div>
</asp:Panel>
</asp:Content>
