<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Ecommerce_ASP.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style>
        body {
    padding-top: 70px; /* Space for fixed navbar */
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

.navbar {
    margin-bottom: 0;
    border-radius: 0;
}

.navbar-brand img {
    height: 30px;
}

.navbar-nav > li > a {
    padding-top: 15px;
    padding-bottom: 15px;
}

/* Sign Up Page Styling */
.center-page {
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}

.form-control {
    border-radius: 4px;
    border: 1px solid #ddd;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
}

.form-control:focus {
    border-color: #5bc0de;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.075), 0 0 8px rgba(91, 192, 222, 0.6);
}

.btn-success {
    background-color: #5cb85c;
    border-color: #4cae4c;
    border-radius: 4px;
    padding: 10px 20px;
}

.btn-success:hover {
    background-color: #4cae4c;
    border-color: #398439;
}

.text-danger {
    color: #d9534f;
}

.text-info {
    color: #5bc0de;
}

/* Footer Styling */
.footer-pos {
    background-color: #222;
    color: #fff;
    padding: 20px 0;
    position: relative;
    bottom: 0;
    width: 100%;
}

.footer-pos p {
    margin: 0;
}

.footer-pos a {
    color: #fff;
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
                    <a class="navbar-brand" href="Default.aspx">
                        <img src="icons/safeIcons.png" alt="MyEShopping" height="30" />MyEShopping
                    </a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="Default.aspx">Home</a></li>
                        <li><a href="About.aspx">About</a></li>
                        <li><a href="#">Contact US</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Products<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li class="dropdown-header">Men</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Shirts</a></li>
                                <li><a href="#">Pants</a></li>
                                <li><a href="#">Denims</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">Women</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Top</a></li>
                                <li><a href="#">Leggings</a></li>
                                <li><a href="#">Denims</a></li>
                            </ul>
                        </li>
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
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Your Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email format." ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$" CssClass="text-danger" Display="Dynamic" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-xs-11"></label>
                <div class="col-xs-11">
                    <asp:Button ID="txtsignup" CssClass="btn btn-success" runat="server" Text="Sign Up" OnClick="txtsignup_Click" />
                    <asp:Label ID="lblMsg" runat="server" Text="" CssClass="text-info"></asp:Label>
                </div>
            </div>
        </div>
        <!-- Signup Page End -->

        <!-- Footer Contents Start Here -->
        <hr />
        <footer class="footer-pos">
            <div class="container">
                <p class="pull-right"><a href="#">&nbsp; &nbsp; Back to top &nbsp; &nbsp;</a></p>
                <p class="pull-right"><a href="AdminHome.aspx"> Admin Login  </a></p>
                <p>&copy;2024 djshop.in &middot; <a href="HomePage.aspx">Home</a>&middot;<a href="#">About</a>&middot;<a href="#">Contact</a>&middot;<a href="#">Products</a></p>
            </div>
        </footer>
    </form>
</body>
</html>
