<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintPass.aspx.cs" Inherits="Visitormanagementsystem.PrintPass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body{
            font-family:'Segoe UI';
            background:#f3f4f6;
            text-align:center;
        }

        .Pass{
            width:350px;
            margin:50px auto;
            background: white;
            padding:20px;
            border-radius:15px;
            box-shadow:0 10px 25px rgba(0,0,0,0.2);
        }
        
        .header{
            background: linear-gradient(45deg,#2563eb,#1e3a8a);
            color:white;
            text-align:center;
            padding:15px;

        }

        .header h2{
            margin:0;
        }

        .contect{
            padding:20px;
        }

        .detail{
             
            margin-bottom:10px;
            font-size:15px;
        }

        .detail b{
            color:#111827;
        }

        .status{
            margin-top:15px;
            text-align:center;
            padding:8px;
            border-radius:8px;
            background:#16a34a;
            color:white;
            font-weight:bold;
        }

        .print-btn{
            margin-top:15px;
            padding:10px;
            background:#2563eb;
            color:white;
            border:none;
            border-radius:5px;
            cursor:pointer;
            width:100%;
        }

        @media print{
            .print-btn{
                display:none;
            }
        }

    </style>
    <script>
        function printPage() {
            window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Pass">
            <div class="header">
                <h2>Visitor Pass</h2>
                <small>Visitor Management System</small>
            </div>
            <div class="contect">
            
                <div class="detail"><b>Name:</b> <asp:Label ID="lblName" runat="server" /></div>
                <div class="detail"><b>Phone:</b> <asp:Label ID="lblPhone" runat="server" /></div>
                <div class="detail"><b>Purpose:</b> <asp:Label ID="lblPurpose" runat="server" /></div>
                <div class="detail"><b>Meet:</b> <asp:Label ID="lblMeet" runat="server" /></div>
                <div class="detail"><b>Check-In:</b> <asp:Label ID="lblIn" runat="server" /></div>
                <div class="detail"><b>Check-Out:</b> <asp:Label ID="lblOut" runat="server" /></div>
                <div class="status"><asp:Label ID="lblStatus" runat="server"></asp:Label></div>

          </div>

            <button type="button" class="print-btn" onclick="printPage()">Print</button>

        </div>
    </form>
</body>
</html>
