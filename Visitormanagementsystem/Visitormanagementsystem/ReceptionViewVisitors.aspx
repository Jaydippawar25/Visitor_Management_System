<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReceptionViewVisitors.aspx.cs" Inherits="Visitormanagementsystem.ReceptionViewVisitors" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Reception View Visitors</title>
    <style>
        body{
            margin:0;
            font-family:'Segoe UI';
            background: linear-gradient(120deg,#e0eafc,#cfdef3);

        }
        .sidebar{
            width:220px;
            height:100vh;
            background:#111827;
            position:fixed;
            color:white;
            padding-top:20px;

        }
        .sidebar h2{text-align:center;}
        .sidebar a{
            display:block;
            padding:12px 20px;
            color:white;
            text-decoration:none;

        }
        .sidebar a:hover{background:#374151;}
        .header{
            margin-left:220px;
            padding:15px 25px;
            background:white;
            border-bottom:1px solid #ddd;
            display:flex;
            justify-content:space-between;

        }
        .logout-btn{
            background:#ef4444;
            border:none;
            padding:8px 15px;
            color:white;
            order-radius:5px;
            cursor:pointer;

        }
        .main{
            margin-left:220px;
            padding:30px;

        }
        .card{
            background:white;
            padding:25px;
            border-radius:10px;
            box-shadow:0 10px 25px rgba(0,0,0,0.15);

        }
        table{
            width:100%;
            border-collapse:collapse;
            margin-top:20px;

        }
        th{
            background:#2563eb;
            color:white;
            padding:10px;

        }
        tr{border-bottom:1px solid #ddd;}
        tr:hover{background:#f1f5f9;}
        .btn_checkout{
            background:#f59e0b;
            color:white;
            border:none;
            padding:5px 10px;
            border-radius:10px;
            cursor:pointer;

        }
        .btn_print{
            background:#3b82f6;
            color:white;
            border:none;
            padding:5px 10px;
            border-radius:10px;
            cursor:pointer;

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
                <a href="ReceptionDashboard.aspx">🏠 Dashboard</a>
                <a href="ReceptionVisitorEntry.aspx">➕ Add Visitor</a>
                <a href="ReceptionViewVisitors.aspx">👁 View Visitors</a>

            </div>
            <div class="header">
                <div><b>Visitor Management System</b></div>
                <div>
                    Welcome, <b><asp:Label ID="lblAdmin" runat="server"></asp:Label></b>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnLogout" runat="server" Text="Logout"
                        CssClass="logout-btn" OnClick="btnLogout_Click"/>

                </div>

            </div>
            <div class="main">
                <div class="card">
                    <h2>Visitor Records</h2>
                    
                    <asp:GridView ID="GridView1" runat="server"
                        AutoGenerateColumns="false"
                        DataKeyNames="VisitID"
                        OnRowCommand="GridView1_RowCommand"
                        OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="VisitID" HeaderText="ID"/>
                            <asp:BoundField DataField="FullName" HeaderText="Name"/>
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone"/>
                            <asp:BoundField DataField="Purpose" HeaderText="Purpose"/>
                            <asp:BoundField DataField="WhomToMeet" HeaderText="Meet Person" />
                            <asp:BoundField DataField="CheckInTime" HeaderText="Check-In Time"/>
                            <asp:BoundField DataField="CheckOutTime" HeaderText="Check-Out Time"/>
                            <asp:BoundField DataField="Status" HeaderText="Status"/>
                            <asp:TemplateField HeaderText="Checkout">
                                <ItemTemplate>
                                    <asp:Button ID="btnCheckout" runat="server"
                                        Text="Check-Out"
                                        CommandName="Checkout"
                                        CommandArgument="<%# Container.DataItemIndex %>"
                                        CssClass="btn_checkout"/>

                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Print">
                                <ItemTemplate>
                                    <asp:Button ID="btnPrint" runat="server"
                                        Text="Print"
                                        CommandName="Print"
                                        CommandArgument="<%# Container.DataItemIndex %>"
                                        CssClass="btn_print"/>

                                </ItemTemplate>

                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

            </div>

        </form>

    </body>

</html>