<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewVisitors.aspx.cs" Inherits="Visitormanagementsystem.ViewVisitors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style> 
        body {
            margin:0;
             font-family:'Segoe UI';
            background: linear-gradient(120deg, #e0eafc, #cfdef3);
        }

        
        .sidebar {
            width: 220px;
            height: 100vh;
            background: #111827;
            position: fixed;
            color: white;
            padding-top: 20px;
        }

        .sidebar h2 {
            text-align: center;
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            color: white;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #374151;
        }

         
        .header {
            margin-left: 220px;
            padding: 15px 25px;
            background: white;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
        }

        .logout-btn {
            background: #ef4444;
            border: none;
            padding: 8px 15px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

         
        .main {
            margin-left: 220px;
            padding: 30px;
        }

         
        .card{
            background: white;
            padding:25px;
            border-radius:10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
         
        table{
            width:100%;
            border-collapse:collapse;
            margin-top: 20px;

        }

        th{
            background:#2563eb;
            color:white;
            padding:10px;
            text-align:left;
        }

        tr{
            padding:10px;
            border-bottom:1px solid #ddd;

        }

        tr:hover{
            background:#f1f5f9
        }
        .btn_approve{
            background: #22c55e;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius:15px;

        }
        .btn_reject{
            background:#ef4444;
            color:white;
            border:none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius:15px;
        }
        .search-box{
            display:flex;
            gap:10px;
            align-items:center;
            margin-bottom:20px;
            padding:15px;
            border-radius:12px;
            background: rgba(255,255,255,0.5);
            backdrop-filter: blur(10px);
            box-shadow:0 8px 20px rgba(0,0,0,0.1);

        }
        .search-input{
            flex:1;

        }
        .input{
            width:90%;
            padding:12px 15px;
            border-radius:10px;
            border:1px solid #ccc;
            font-size:14px;
            transition:0.3s;

        }
        .input:focus{
            outline:none;
            border-color:#2563eb;
            box-shadow:0 0 10px rgba(37,99,235,0.4);
            transform:scale(1.02);

        }
        .btn-search{
            padding:10px 18px;
            border:none;
            border-radius:8px;
            background: linear-gradient(45deg,#2563eb,#1e40af);
            color:white;
            cursor:pointer;
            transition:0.3s;

        }
        .btn-reset{
            padding:10px 18px;
            border:none;
            border-radius:8px;
            background: linear-gradient(45deg,#6b7280,#374151);
            color:white;
            cursor:pointer;
            transition:0.3s;

        }
        .btn-search:hover{
            transform:translateY(-2px);
            box-shadow:0 5px 15px rgba(37,99,235,0.4);

        }
        .btn-reset:hover{
            transform:translateY(-2px);
            box-shadow:0 5px 15px rgba(107,114,128,0.4);

        }
        .btn-search:active,
        .btn-reset:active{
            transform:scale(0.95);

        }
        .input::placeholder{
            color:#6b7280;
            transition:0.3s;

        }
        .input:focus::placeholder{
            opacity:0.5;
            transform:translateX(5px);

        }
        .btn_checkout{
            background:#f59e0b;
            color:white;
            border:none;
            padding: 5px 10px;
            border-radius:5px;
            cursor:pointer;
            align-items:center;
        }

        .btn_checkout:hover{
            background:#d97706;
        }

        .btn_checkout[disabled]{
            background:gray !important;
            cursor:not-allowed;

        }
        .btn_Print{
            background:#3b82f6;
            color:white;
            border:none;
            padding:5px 10px;
            border-radius:5px;
        }
         #GridView1{
            text-align:center;
            align-items:center;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
         <div class="sidebar">
            <h2>VMS</h2>
            <a href="Dashborad.aspx">🏠 Dashboard</a>
             <a href="VisitorEntry.aspx">➕ Add Visitor</a>
             <a href="ViewVisitors.aspx">👁 View Visitors</a>
    
        </div>

        <div class="header">
        <div>
            <b>Visitor Management System</b></div>

        <div>
            Welcome, <b><asp:Label ID="lblAdmin" runat="server"></asp:Label></b>
            &nbsp;&nbsp;
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
        </div>
    </div>
         <div class="main">
             <div class="search-box">

    <div class="search-input">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="input"
            Placeholder="🔍 Search by Name or Phone"></asp:TextBox>
    </div>
                 <asp:Button ID="btnSearch" runat="server"
                     Text="Search"
                     CssClass="btn-search"
                     OnClick="btnSearch_Click" />
                 <asp:Button ID="btnReset" runat="server"
                     Text="Reset"
                     CssClass="btn-reset"
                     OnClick="btnReset_Click" />

             </div>

        <div class="card">
            <h2>Visitor Records</h2>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
                   CssClass="table"
                   DataKeyNames="VisitID"
                   OnRowCommand="GridView1_RowCommand"
                   OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="VisitID" HeaderText="ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
                    <asp:BoundField DataField="Purpose" HeaderText="Purpose" />
                    <asp:BoundField DataField="WhomToMeet" HeaderText="Meet Person" />
                    <asp:BoundField DataField="status" HeaderText="status" />
                    <asp:BoundField DataField="CheckInTime" HeaderText="Check-In Time" />

                    <asp:BoundField DataField="CheckOutTime" HeaderText="Check-Out Time" />
                    
                   <asp:TemplateField HeaderText="Approve">
                       <ItemTemplate>
                           <asp:Button 
                               ID="btnapprove"
                               runat="server"
                               Text="Approve"
                               CommandName="Approve"
                               CommandArgument="<%# Container.DataItemIndex %>"
                               CssClass="btn_approve"
                               OnClientClick="return confirm('Approve this visitor?');"
                               />

                       </ItemTemplate>

                   </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject">
                        <ItemTemplate>
                            <asp:Button 
                                ID="btnreject"
                                runat="server"
                                Text="Reject"
                                CommandName="Reject"
                                CommandArgument="<%# Container.DataItemIndex %>"
                                CssClass="btn_reject"
                                OnClientClick="return confirm('Reject this visitor?');"/>

                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Checkout">
                        <ItemTemplate>
                            <asp:Button 
                                ID="btnCheckout"
                                runat="server"
                                Text="Check-Out"
                                CommandName="Checkout"
                                CommandArgument="<%# Container.DataItemIndex %>"
                                CssClass="btn_checkout"
                                OnClientClick="return confirm('Confirm Check-Out?');"/>

                        </ItemTemplate>

                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Print">
                       <ItemTemplate>
                           <asp:Button 
                                ID="btnPrint"
                               runat="server"
                               Text="Print"
                               CommandName="Print"
                               CommandArgument="<%# Container.DataItemIndex %>"
                               CssClass="btn_Print" 
                               OnClientClick="return confirm('Print visitor pass?');"/>

                       </ItemTemplate>

                   </asp:TemplateField>



                </Columns>
            </asp:GridView>

        </div>

    </div>
    </form>
</body>
</html>
