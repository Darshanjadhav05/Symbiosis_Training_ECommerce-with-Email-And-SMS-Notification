<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecoverPassword.aspx.cs" Inherits="Ecommerce.RecoverPassword" %>

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
        .navbar {
            background-color: white;
        }


        .com_name h2 {
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

        .navbar-nav > li.active > a {
            background-color: #1abc9c;
            color: #fff;
            border-radius: 50px;
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
                        <li class="active"><a href="HomePage.aspx">Home</a></li>
                        <li><a href="About.aspx">About</a></li>
                        <li runat="server" id="btnSignUP"><a href="SignUp.aspx">SignUp</a></li>
                        <li runat="server" id="btnSignIN"><a href="SignIn.aspx">SignIn</a></li>

                    </ul>
                </div>
            </div>
        </div>


        <div class="container">
            <div class="form-horizontal">
                <br />
                <br />
                <br />

                <h2>Reset Password</h2>
                <hr />
                <h3></h3>
                <div class="form-group">
                    <asp:Label ID="lblmsg" CssClass="col-md-2 control-label" runat="server" Visible="False" Font-Bold="True" Font-Size="X-Large"></asp:Label>

                </div>


                <div class="form-group">
                    <asp:Label ID="lblNewPassword" CssClass="col-md-2 control-label" runat="server" Text=" New Password" Visible="False"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtNewPass" CssClass=" form-control" TextMode="Password" runat="server" Visible="False"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNewPass" CssClass="Text-danger" runat="server" ErrorMessage="Enter Your New Password" ControlToValidate="txtNewPass" ForeColor="Red"></asp:RequiredFieldValidator>

                    </div>

                </div>


                <div class="form-group">
                    <asp:Label ID="lblConfirmPass" CssClass="col-md-2 control-label" runat="server" Text="Confirm New Password" Visible="False"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtConfirmPass" CssClass=" form-control" TextMode="Password" runat="server" Visible="False"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorConfirmPass" CssClass="Text-danger" runat="server" ErrorMessage="Enter Your Confirm New Password" ControlToValidate="txtConfirmPass" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidatorPass" CssClass="Text-danger" runat="server" ErrorMessage="confirm password not match...try again" ControlToCompare="txtConfirmPass" ForeColor="Red" ControlToValidate="txtNewPass"></asp:CompareValidator>
                    </div>

                </div>


                <div class="form-group">
                    <div class="col-md-2"></div>

                    <div class="col-md-6">
                        <asp:Button ID="btnResetPass" CssClass="btn btn-default" runat="server" Text="Reset" Visible="False" OnClick="btnResetPass_Click" />

                    </div>
                </div>

            </div>
        </div>

    </form>

    <!---Footer COntents Start here---->
    <hr />
    <footer>
        <div class="container ">
            <p class="pull-right "><a href="#">Back to top</a></p>
            <p>&copy;2020 DJShop.in &middot; <a href="HomePage.aspx">Home</a>&middot;<a href="#">About</a>&middot;<a href="#">Contact</a>&middot;<a href="#">Products</a> </p>
        </div>

    </footer>

    <!---Footer COntents End---->


</body>
</html>
