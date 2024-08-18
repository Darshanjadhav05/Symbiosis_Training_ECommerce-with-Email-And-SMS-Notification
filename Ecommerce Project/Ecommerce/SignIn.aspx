<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="Ecommerce.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/Custome.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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


        .com_name h2 {
            font-family: "Cinzel Decorative", serif;
            font-weight: 700;
            font-style: normal;
        }

        .navbar-nav > li.active > a {
            background-color: #1abc9c;
            color: #fff;
            border-radius: 50px;
        }

        .navbar-nav > li > a {
            padding-top: 15px;
            padding-bottom: 15px;
            color: #000;
            font-size: 17px;
            margin-top: 10px;
        }

            .navbar-nav > li > a:hover {
                background-color: #1abc9c;
                color: #fff;
            }
        /* General form styling */
        .form-horizontal {
            margin-top: 80px;
        }

        /* Custom input styling */
        .form-control {
            width: max-content;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px 12px;
            font-size: 14px;
            color: #555;
            transition: all 0.3s ease-in-out;
        }

            .form-control:focus {
                background-color: #fff;
                border-color: #5bc0de;
                box-shadow: 0 0 8px rgba(91, 192, 222, 0.6);
                outline: none;
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

        /* Label and validation message styling */
        .control-label {
            color: #333;
            font-weight: bold;
        }

        .text-danger {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }

        /* Checkbox and links */
        .form-group .control-label, .form-group .checkbox {
            font-weight: normal;
        }

        .form-group a {
            color: #5bc0de;
            text-decoration: none;
        }

            .form-group a:hover {
                text-decoration: underline;
            }

        /* Footer styling */
        footer {
            background-color: #f5f5f5;
            padding: 20px;
            margin-top: 30px;
        }

            footer p a {
                color: #5bc0de;
            }

                footer p a:hover {
                    text-decoration: underline;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>

                    <div class="com_name">
                        <h2>EasyShop</h2>
                    </div>

                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="HomePage.aspx">Home</a></li>
                        <li><a href="About.aspx">About</a></li>
                        <li><a href="#">Contact US</a></li>
                        <li><a href="SignUp.aspx">SignUp</a></li>
                        <li class="active"><a href="SignIn.aspx">SignIn</a></li>
                    </ul>

                </div>
            </div>
        </div>

        <!----singin form start--->

        <div class="container mt-5">
            <div class="form-horizontal ">
                <h2>Login Form</h2>
                <hr />
                <div class="form-group">
                    <asp:Label ID="Label1" CssClass="col-md-2 control-label " runat="server" Text="UserName"></asp:Label>
                    <div class="col-md-3 ">

                        <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" CssClass="text-danger " ErrorMessage="*plz Enter Username" ControlToValidate="txtUsername" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>


                <div class="form-group">
                    <asp:Label ID="Label2" CssClass="col-md-2 control-label " runat="server" Text="Password"></asp:Label>
                    <div class="col-md-3 ">

                        <asp:TextBox ID="txtPass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" CssClass="text-danger " runat="server" ErrorMessage="*the password field is required" ControlToValidate="txtPass" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-md-2 "></div>
                    <div class="col-md-6 ">

                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        <asp:Label ID="Label3" CssClass=" control-label " runat="server" Text="Remember me"></asp:Label>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-md-2 "></div>
                    <div class="col-md-6 ">

                        <asp:Button ID="btnLogin" CssClass="btn btn-success " runat="server" Text="Login&raquo;" OnClick="btnLogin_Click" />
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/SignUp.aspx">Sign Up</asp:HyperLink>
                    </div>
                </div>

                <%--  for forgot password--%>
                <div class="form-group">
                    <div class="col-md-2 "></div>
                    <div class="col-md-6 ">
                        <asp:HyperLink ID="HyForgotPass" runat="server" NavigateUrl="~/ForgotPassword.aspx">Forgot Password</asp:HyperLink>

                    </div>
                </div>



                <div class="form-group">
                    <div class="col-md-2 "></div>
                    <div class="col-md-6 ">

                        <asp:Label ID="lblError" CssClass="text-danger " runat="server"></asp:Label>
                    </div>
                </div>


            </div>


        </div>
        <!----singin form End--->

        <!---Footer COntents Start here---->
        <hr />
        <footer>
            <div class="alert alert-danger ">
                <p class="pull-right "><a href="#">&nbsp; &nbsp; Back to top &nbsp; &nbsp;</a></p>
                <p>&copy;2024 EasyShop.in &middot; <a href="HomePage.aspx">Home</a>&middot;<a href="#">About</a>&middot;<a href="#">Contact</a>&middot;<a href="#">Products</a> </p>
            </div>

        </footer>

    </form>
</body>
</html>

