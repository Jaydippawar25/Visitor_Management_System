<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReceptionVisitorEntry.aspx.cs" Inherits="Visitormanagementsystem.ReceptionVisitorEntry" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Add Visitor</title>
        <style>
            body{
            margin:0;
             font-family:'Segoe UI';
            background: linear-gradient(120deg, #e0eafc, #cfdef3);
        }

        .sidebar{
            width:220px;
            height:100vh;
            background:#111827;
            position:fixed;
            color:white;
            padding-top:20px;
        }

        .sidebar h2{
            text-align:center;
        }

        .sidebar a{
            display:block;
            padding: 12px 20px;
            color: white;
            text-decoration:none;
        }

        .sidebar a:hover{
            background: #374151;
        }

        .header{
            margin-left: 220px;
            padding:15px 25px;
            background: rgba(255,255,255,0.8);
            border-bottom: 1px solid #ddd;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .logout-btn{
            background:red;
            border:none;
            padding: 8px 15px;
            color:white;
            border-radius: 5px;
            cursor: pointer;

        }

        .main{
            margin-left: 220px;
            padding: 40px;
        }

        .card{
            max-width:800px;
            margin:auto;
            background:white;
            padding: 30px;
            border-radius:15px;
            box-shadow: 0 15px 35px  rgba(0,0,0,0.15);
        }

        .card h2{
            margin-bottom: 20px;
        }

        .form-grid{
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap:30px;
            row-gap:25px;
        }

        .form-group {
            position: relative;
            margin-bottom: 5px;

        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            font-size: 14px;
            background: transparent;

        }

         
         .form-group label {
             position: absolute;
             top: -8px;
             left: 10px;
             color: #777;
             font-size: 14px;
             transition: 0.3s;
             background: white;
             padding: 0 5px;

         }
         .form-group input:focus,
         .form-group select:focus {
             border-color: #2563eb;

         }
            .form-group input:focus + label,
            .form-group input:not(:placeholder-shown) + label,
            .form-group select:focus + label {
                top: -8px;
                font-size: 12px;
                color: #2563eb;
            }

        .full{
            grid-column: span 2;
        }

        .btn {
            grid-column: span 2;
            padding: 12px;
            background: linear-gradient(45deg, #2563eb, #1e40af);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            transition: 0.3s;

        }
        .btn:hover {
            transform: scale(1.03);

        }
        .msg{
            margin-top:10px;
            color:green;
        }
        .error{
            color:red;
            font-size:12px;
        }

        </style>
        <script>
            function confirmSave() {
                return confirm("Are you sure you want to save this visitor?");
            }
            let video, canvas, preview, btnCapture, btnRetake;

            document.addEventListener("DOMContentLoaded", function () {

                video = document.getElementById("video");
                canvas = document.getElementById("canvas");
                preview = document.getElementById("preview");

                btnCapture = document.getElementById("btnCapture");
                btnRetake = document.getElementById("btnRetake");

                startCamera();

                btnCapture.onclick = capturePhoto;
                btnRetake.onclick = retakePhoto;
            });

            function startCamera() {
                navigator.mediaDevices.getUserMedia({ video: true })
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                    })
                    .catch(function () {
                        alert("Camera not working!");
                    });
            }

            function capturePhoto() {
                let ctx = canvas.getContext("2d");
                ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

                let imageData = canvas.toDataURL("image/png");

                preview.src = imageData;
                preview.style.display = "block";
                video.style.display = "none";

                document.getElementById('<%= hiddenImage.ClientID %>').value = imageData;

                btnCapture.style.display = "none";
                btnRetake.style.display = "inline-block";
            }

            function retakePhoto() {
                preview.style.display = "none";
                video.style.display = "block";

                document.getElementById('<%= hiddenImage.ClientID %>').value = "";

        btnCapture.style.display = "inline-block";
        btnRetake.style.display = "none";
    }
        </script>
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
                    Welcome, <asp:Label ID="lblAdmin" runat="server"></asp:Label>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />

                </div>

            </div>
            <div class="main">
                <div class="card">
                    <h2>Add Visitor</h2>
                    <div class="form-grid">
                        <div class="form-group">
                            <asp:TextBox ID="txtName" runat="server" ></asp:TextBox>
                            <label >Full Name</label>
                            <asp:RequiredFieldValidator ControlToValidate="txtName" ErrorMessage="* Name required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtPhone" TextMode="Phone" runat="server"   MaxLength="10"></asp:TextBox>
                            <label>Phone Number</label>
                            <asp:RequiredFieldValidator  ControlToValidate="txtPhone" ErrorMessage="* Phone required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" TextMode="Email" runat="server"  ></asp:TextBox>
                            <label>Email</label> 
                            <asp:RequiredFieldValidator ControlToValidate="txtEmail" ErrorMessage="* Email required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtCompany" runat="server"  ></asp:TextBox>
                            <label>Company Name</label>

                        </div>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlGender" runat="server">
                                <asp:ListItem Text="Select Gender" Value="" />
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>FeMale</asp:ListItem>

                            </asp:DropDownList>
                            <label>Gender</label>
                            <asp:RequiredFieldValidator ControlToValidate="ddlGender" InitialValue="" ErrorMessage="* Select gender" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtVehicle" runat="server" ></asp:TextBox>
                            <label>Vehicle Number</label>

                        </div>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlIDType" runat="server">
                                <asp:ListItem Text="Select ID Type" Value="" />
                                <asp:ListItem>Aadhar</asp:ListItem>
                                <asp:ListItem>PAN</asp:ListItem>
                                <asp:ListItem>Driving Licence</asp:ListItem>

                            </asp:DropDownList>
                            <label>Select ID Type</label>
                            <asp:RequiredFieldValidator  ControlToValidate="ddlIDType" InitialValue="" ErrorMessage="* Select ID type" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtIDNumber" runat="server"  ></asp:TextBox>
                            <label>ID Number</label>
                            <asp:RequiredFieldValidator ControlToValidate="txtIDNumber" ErrorMessage="* ID number required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtPersons" runat="server"  ></asp:TextBox>
                            <label>No. Of Person</label>

                        </div>
                        <div class="form-group full">
                            <asp:TextBox ID="txtPurpose" runat="server"  ></asp:TextBox>
                            <label>Purpose Of Visit</label>
                            <asp:RequiredFieldValidator ControlToValidate="txtPurpose" ErrorMessage="* Purpose required" CssClass="error"  runat="server" />

                        </div>
                        <div class="form-group full">
                            <asp:TextBox ID="txtMeet" runat="server"   ></asp:TextBox>
                            <label>Whom To Meet</label>
                            <asp:RequiredFieldValidator ControlToValidate="txtMeet" ErrorMessage="* Required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group full">
                            <asp:TextBox ID="txtAddress" runat="server"   ></asp:TextBox>
                            <label>Address</label>
                            <asp:RequiredFieldValidator ControlToValidate="txtAddress"  ErrorMessage="* Address required" CssClass="error" runat="server" />

                        </div>
                        <div class="form-group full">
                            <asp:TextBox ID="txtRemarks" runat="server"   ></asp:TextBox>
                            <label>Remarks</label>

                        </div>
                        <div class="form-group full">
                            <video id="video" width="260" height="200" autoplay muted playsinline
                                style="border-radius:10px; border:1px solid #ccc;"></video>
                            <canvas id="canvas" width="260" height="200" style="display:none;"></canvas>
                            <img id="preview" width="260" height="200"
                                style="display:none; border-radius:10px; border:1px solid #ccc;" />
                            <br /><br />
                            <button type="button" id="btnCapture">📸 Capture</button>    <button type="button" id="btnRetake" style="display:none;">🔄 Retake</button>
                            <asp:HiddenField ID="hiddenImage" runat="server" />
                            <label>Visitor Photo</label>

                        </div>
                        <asp:Button ID="btnSave" runat="server" Text="Save Visitor" CssClass="btn" OnClick="btnSave_Click" OnClientClick="return confirmSave();" CausesValidation="true" />

                    </div>
                    <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
                    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

                </div>
           

            </div>

        </form>

    </body>

</html>