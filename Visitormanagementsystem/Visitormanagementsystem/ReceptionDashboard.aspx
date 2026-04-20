<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReceptionDashboard.aspx.cs" Inherits="Visitormanagementsystem.ReceptionDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Reception Dashboard</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI';
    background:#f1f5f9;
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

/* Header */
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
    border-radius:5px;
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
}
.stat-card h1{
    margin-top:10px;
    font-size:35px;
}

/* Action Cards */
.cards{
    display:flex;
    gap:20px;
}
.card{
    width:50%;
    height:150px;
    border-radius:15px;
    background:rgba(255,255,255,0.5);
    backdrop-filter:blur(10px);
    padding:20px;
    cursor:pointer;
    transition:0.3s;
    text-align:center;
}
.card:hover{
    transform: translateY(-8px)scale(1.03);
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
        Welcome, <b><asp:Label ID="lblUser" runat="server"></asp:Label></b>
        &nbsp;&nbsp;
        <asp:Button ID="btnLogout" runat="server" Text="Logout"
            CssClass="logout-btn" OnClick="btnLogout_Click" />
    </div>
</div>

 
<div class="main">

 
    <div class="stats">
        <div class="stat-card total">
            <h3>Total Visitors</h3>
            <h1><asp:Label ID="lblTotal" runat="server"></asp:Label></h1>
        </div>

        <div class="stat-card today">
            <h3>Today Visitors</h3>
            <h1><asp:Label ID="lblToday" runat="server"></asp:Label></h1>
        </div>
    </div>

   
    <div class="cards">

        <div class="card" onclick="window.location='ReceptionVisitorEntry.aspx'">
            <h3>➕ Add Visitor</h3>
            <p>Register new visitor</p>
        </div>

        <div class="card" onclick="window.location='ReceptionViewVisitors.aspx'">
            <h3>👁 View Visitors</h3>
            <p>Check records</p>
        </div>

    </div>

</div>

</form>
</body>
</html>