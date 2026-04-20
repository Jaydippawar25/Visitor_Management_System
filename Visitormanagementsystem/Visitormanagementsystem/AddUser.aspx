<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="Visitormanagementsystem.AddUser" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add User</title>

    <style>
        
        html,body{
            padding:0;
            height:100%;
            overflow:hidden;
            margin-left: 0;
            margin-right: 0;
            margin-top: 0;
        }
        
        body {
            
            font-family: 'Segoe UI';
             
            background:  url('Images/vms.jpg') no-repeat center center fixed;
            background-size:cover;
           
        }

        .sidebar{
            width:220px;
            height:100vh;
            background:#111827;
            position:fixed;
            left:0;
            top:0;
            color:white;
            padding-top:20px;

        }

        .sidebar h2{
            text-align:center;
            margin-bottom:20px;
        }

        .sidebar a{
            display:block;
            padding:12px 20px;
            color:white;
            text-decoration:none;
            transition:0.3s;
        }

        .sidebar a:hover{
            background:#374151;
        }

        .overlay{
            position: fixed;
            width:100%;
            height:100%;
             
            top: 0;
            left:0;
            z-index: 0;
        }

         
        .navbar {
            height: 60px;
            background: rgba(0,0,0,0.2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            margin-left:220px;
        }

        .navbar h2 {
            margin: 0;
            font-size: 20px;
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
            height: calc(100vh - 60px);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-left:220px;
        }

         
        .card {
            width: 420px;
            background: rgba(255,255,255,0.95);
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
        }

        .card h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1e293b;
        }

         
        .input-box {
            margin-bottom: 18px;
        }

        .input-box label {
            font-size: 13px;
            color: #475569;
        }

        .input-box input,
        .input-box select {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        .input-box input:focus,
        .input-box select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 8px rgba(37,99,235,0.4);
            outline: none;
        }

         
        .btn {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            background: linear-gradient(45deg,#2563eb,#1d4ed8);
            border: none;
            color: white;
            font-size: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37,99,235,0.4);
        }

        .back-btn{
            background:#22c55e;
            border:none;
            padding:8px 15px;
            color:white;
            border-radius:5px;
            cursor:pointer;
            margin-right:10px;
        }
        .back-btn:hover{
            background:#16a34a;
        }

        
        .msg {
            text-align: center;
            margin-top: 12px;
            color: green;
        }

        .error {
            text-align: center;
            margin-top: 12px;
            color: red;
        }

    </style>
</head>

<body>

<form id="form1" runat="server">
    <div class="overlay"></div>

    <div class="sidebar">
    <h2>VMS</h2>

    <a href="Dashborad.aspx">🏠 Dashboard</a>
    <a href="VisitorEntry.aspx">➕ Add Visitor</a>
    <a href="ViewVisitors.aspx">👁 View Visitors</a>
    <a href="AddUser.aspx">👤 Add User</a>
</div>

     
    <div class="navbar">
        <h2>Visitor Management System</h2>
        <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />

    </div>


     
    <div class="main">
        <div class="card">

            <h2>Add New User</h2>

            <div class="input-box">
                <label>Full Name</label>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            </div>

            <div class="input-box">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" TextMode="Email" runat="server"></asp:TextBox>
            </div>

            <div class="input-box">
                <label>Password</label>
                <asp:TextBox ID="txtPass" TextMode="Password" runat="server"></asp:TextBox>
            </div>

            <div class="input-box">
                <label>Select Role</label>
                <asp:DropDownList ID="ddlRole" runat="server">
                    <asp:ListItem Text="Receptionist" />
                    <asp:ListItem Text="Admin" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnAdd" runat="server" Text="Add User" CssClass="btn" OnClick="btnAdd_Click" />

            <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
            <asp:Label ID="lblTest" runat="server" CssClass="test"></asp:Label>

         
    </div>

    </div>

</form>

</body>
</html>