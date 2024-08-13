<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Ecommerce_ASP.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com"  />
<link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&family=Finger+Paint&family=Homemade+Apple&family=Lumanosimo&family=Playball&family=Poppins:wght@300;400;600;700;800&family=Silkscreen&family=Tinos&display=swap" rel="stylesheet" />
    <style>
        body {
            padding-top: 70px; 
             font-family: "Tinos", serif;
            font-weight: 400;
            background-color: #f5f5f5;
        }

        .navbar {
          
            background-color: white;
            
        }

        
        .com_name h2{
              font-family: "Cinzel Decorative", serif;
  font-weight: 700;
  font-style: normal;
        }

        .navbar-nav > li > a {
            padding-top: 15px;
            padding-bottom: 15px;
            color: #000;
    font-size: 15px;
    margin-top: 10px;
        }

        .navbar-nav > li > a:hover {
            background-color: #1abc9c;
            color: #fff;
        }

        .center-page {
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
            height: 48px;
        }

        .form-group label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .form-control {
            border-radius: 4px;
            border: 1px solid #ddd;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .form-control:focus {
            border-color: #5bc0de;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.075), 0 0 8px rgba(91, 192, 222, 0.6);
        }

        .btn-success {
    background-color: #000000; 
    border-color: #000000; 
    border-radius: 8px; 
    padding: 10px 20px;
    transition: all 0.3s ease-in-out;
}

.btn-success:hover {
    background-color: #333333;
    border-color: #333333;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}
.navbar-nav > li.active > a {
    background-color: #1abc9c; 
    color: #fff;
    border-radius:50px;
}
        .text-danger {
            color: #e74c3c;
        }

        .text-info {
            color: #3498db;
        }

        .footer-pos {
            background-color: #34495e;
            color: #ecf0f1;
            padding: 20px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            text-align: center;
        }

        .footer-pos p {
            margin: 0;
        }

        .footer-pos a {
            color: #ecf0f1;
            text-decoration: none;
        }

        .footer-pos a:hover {
            text-decoration: underline;
        }

        .pull-right {
            float: right;
        }

        @media (max-width: 767px) {
            .navbar-nav {
                float: none;
                margin-top: 7.5px;
            }

            .navbar-collapse {
                border-top: 1px solid #ddd;
            }

            .footer-pos {
                text-align: center;
            }
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation Bar -->
        <div class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    
                        <div class="com_name"><h2>EasyMart</h2></div>
                   
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="HomePage.aspx">Home</a></li>
                        <li><a href="About.aspx">About</a></li>
                        <li><a href="#">Contact US</a></li>
                        
                        <li class="active"><a href="SignUp.aspx">SignUp</a></li>
                        <li><a href="SignIn.aspx">SignIn</a></li>
                    </ul>

                </div>
            </div>
        </div>

        <!-- Signup Page -->
        <div class="container center-page">
            <div class="form-group">
                <label class="col-xs-11">Username:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtUname" runat="server" CssClass="form-control" placeholder="Enter Your Username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUname" runat="server" ControlToValidate="txtUname" ErrorMessage="Username is required." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11">Password:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Your Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPass" ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11">Confirm Password:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtCPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Your Confirm Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCPass" runat="server" ControlToValidate="txtCPass" ErrorMessage="Confirm Password is required." CssClass="text-danger" Display="Dynamic" />
                    <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtCPass" ControlToCompare="txtPass" ErrorMessage="Passwords do not match." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11">Your Full Name:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Your Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11">Email:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Your Email Address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid email format." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11">Phone:</label>
                <div class="col-xs-11">
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter Your Phone Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number is required." CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-11">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" Text="Submit" />
                    <asp:Label ID="lblMsg" runat="server" CssClass="text-info"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer-pos">
            <p>&copy; 2024 EasyMart. All Rights Reserved.</p>
        </div>
    </form>
</body>
</html>
