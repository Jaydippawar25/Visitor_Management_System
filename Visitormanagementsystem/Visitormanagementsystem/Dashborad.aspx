<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashborad.aspx.cs" Inherits="Visitormanagementsystem.Dashborad" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body{
            margin:0;
            font-family:'Segoe UI';
            background: linear-gradient(120deg, #e0eafc, #cfdef3);
            
        }
        .Sidebar{
            width:220px;
            height:100vh;
            background:#111827;
            position:fixed;
            color:white;
            padding-top:20px;
        }
        .Sidebar h2{
            text-align:center;
        }
        .Sidebar a{
            display:block;
            padding:12px 20px;
            color: white;
            text-decoration:none;
            transition:0.3s;
        }
        .Sidebar a:hover{
            background:#374151;
        }
        .header {
            margin-left: 220px;
            padding: 15px 25px;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
}
        .logout-btn{
            background:#ef4444;
            border:none;
            padding:8px 15px;
            color:white;
            border-radius:6px;
            cursor:pointer;
        }
        .main{
            margin-left:220px;
            padding:30px;
        }

        .stats{
            display:grid;
            grid-template-columns:repeat(2,1fr);
            gap:20px;
            margin-bottom:30px;
        }
        .stat-card{
             
             
            padding:30px;
            border-radius:15px;
            color:white;
            text-align:center;
            box-shadow:0 10px 20px rgba(0,0,0,0.2);
            transition:0.3s;

        }
        .stat-card:hover{
            transform:translateY(-5px) scale(1.02);
        }
        .total{
            background: linear-gradient(45deg, #667eea,#764ba2);

        }
        .today{
            background:linear-gradient(45deg, #43cea2,#185a9d);
        }

        .stat-card h3{
            margin:0;
            font-size:20px;
            letter-spacing:1px;

        }
        .stat-card span{
            display:block;
            margin-top:10px;
            font-size:30px;
            font-weight:bold;
        }

        .cards{
            display:flex;
            gap:20px;
        }
        .card{
            margin-bottom:100px;
            width:600px;
            height:150px;
            border-radius:15px;
            background:rgba(255,255,255,0.3);
            backdrop-filter:blur(10px);
            padding:20px;
            cursor:pointer;
            transition:0.3s;
            text-align:center;

        }
        .card:hover{
            transform: translateY(-8px)scale(1.03);
        }
        .card h3{
             
            margin:0;
        }

         
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Sidebar">
            <h2>VMS</h2>
            <a href="Dashborad.aspx">🏠 Dashboard</a>
            <a href="VisitorEntry.aspx">➕ Add Visitor</a>
            <a href="ViewVisitors.aspx">👁 View Visitors</a>
            <a href="AddUser.aspx">👤 Add User</a>

        </div>
        <div class="header">
            <div>
                <h1 style="margin:0; font-size:22px;">Visitor Management System</h1>
                <span style="font-size:12px; color:#555;">
                    Smart Visitor Tracking Dashboard

                </span>
                
            </div>
            <div>
               Welcome, <b><asp:Label ID="lblAdmin" runat="server"></asp:Label></b>&nbsp;&nbsp;
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />

            </div>

        </div>
        <div class="main">
            <div class="stats">
                <div class="stat-card total">
                <h3>Total Visitors</h3>
                 <span><asp:Label ID="lblTotal" runat="server"></asp:Label></span>
                
            </div>
                <div class="stat-card today">
                    <h3>Today Visitors</h3>
                    <span><asp:Label ID="lblToday" runat="server"></asp:Label></span>

                </div>

        </div>
            <div class="cards">
                <div class="card" onclick="location.href='VisitorEntry.aspx'">
                    <h3>Add Visitor</h3>
                    <p>Registor new Visitor</p>

                </div>
                <div class="card" onclick="location.href='ViewVisitors.aspx'">
                    <h3>View Visitors</h3>
                    <p>Check Records</p>
                </div>
            </div>
        </div>
        
    </form>
</body>
</html>
