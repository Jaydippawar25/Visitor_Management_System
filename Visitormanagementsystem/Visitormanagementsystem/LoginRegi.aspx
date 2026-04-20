<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginRegi.aspx.cs" Inherits="Visitormanagementsystem.LoginRegi" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
       html,body{
            margin:0;
            padding:0;
            height:100%;
            overflow:hidden;

       }
       body{
           font-family:Arial;
            background:url('Images/vms3.jpg') no-repeat center center ;
            background-size:cover;

       }

        .overlay{
            position:fixed;
            width:100%;
            height:100%;
            background: rgba(0,0,0,0.1);
            top:0;
            left:0;
            z-index:-1;
        }

        .container{
            width:100%;
            height:100vh;

            display:flex;
            align-items:center;
            justify-content:flex-end;
            padding-right: 120px;
             
        }

        .card{
            width:380px;
            background: rgba(255,255,255,0.95);
            padding: 35px 30px;
            border-radius:12px;
            box-shadow:0 15px 40px rgba(0,0,0,0.4);
            backdrop-filter: blur(10px);
            margin-right:50px;
            margin-bottom:190px;
            transform:translateY(-20px)
             
            
        }

        h2{
            text-align:center;
            margin-bottom:20px;
            color:#333;
        }
        input{
            width:100%;
            padding:10px;
            margin:10px 0;
            border:1px solid #ccc;
            border-radius:8px;
        }
        .btn{
            width:100%;
            padding:10px;
            background:#007bff;
            border:none;
            color:white;
            border-radius:8px;
            cursor:pointer;
            font-weight:bold;
        }
        .btn:hover{
            background:#0056b3;
        }
        .link{
            text-align:center;
            margin-top:10px;
            cursor:pointer;
            color:#007bff;
        }
        .form-box{
            display:none;
        }
        .active{
            display:block;
        }

    </style>
    
</head>
<body>
    <form id="form1" runat="server">
        <div class="overlay"></div>
        <div class="container">
            <div class="card">

            <div id="loginForm" class="form-box active">
                <h2>Login</h2>

                <asp:TextBox ID="txtLoginEmail" runat="server" Placeholder="Email" TextMode="Email"></asp:TextBox>
                <asp:TextBox ID="txtLoginPass" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="btnLogin_Click" />
                 <asp:Label ID="lblLoginMsg" runat="server" Forecolor="red"></asp:Label>
                 
                 
             </div>
            </div>
        </div>
    </form>
</body>
</html>
