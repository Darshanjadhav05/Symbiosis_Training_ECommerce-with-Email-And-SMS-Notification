<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Ecommerce.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My E-Shopping Website</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
    <form id="form1" runat="server" style="margin-top: 81px">
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
                        <li><a href="#">Contact US</a></li>

                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Products <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="Products.aspx">All Products</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">Men</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="ManShirt.aspx">Shirts</a></li>
                                <li><a href="ManPants.aspx">Pants</a></li>
                                <li><a href="ManDenims.aspx">Denims</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">Women</li>
                                <li role="separator" class="divider"></li>
                                <li><a href="WomanTop.aspx">Top</a></li>
                                <li><a href="WomanLegging.aspx">Leggings</a></li>
                                <li><a href="WomanSarees.aspx">Saree</a></li>
                            </ul>
                        </li>

                        <li runat="server" id="btnSignUP"><a href="SignUp.aspx">SignUp</a></li>
                        <li runat="server" id="btnSignIN"><a href="SignIn.aspx">SignIn</a></li>
                        <li>
                            <asp:Button ID="btnlogout" CssClass="btn btn-default navbar-btn" runat="server" Text="Sign Out" OnClick="btnlogout_Click" />
                        </li>
                    </ul>


                </div>
            </div>
        </div>


        <!-- Image Slider -->
        <div class="container">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="ImgSlider/1.jpg" alt="Los Angeles" style="width: 100%;" />

                    </div>
                    <div class="item">
                        <img src="ImgSlider/2.jpg" alt="Chicago" style="width: 100%;" />

                    </div>
                    <div class="item">
                        <img src="ImgSlider/3.jpg" alt="New york" style="width: 100%;" />

                    </div>
                    <div class="item">
                        <img src="ImgSlider/4.jpg" alt="New york" style="width: 100%;" />

                    </div>
                    <div class="item">
                        <img src="ImgSlider/5.jpg" alt="New york" style="width: 100%;" />

                    </div>
                    <div class="item">
                        <img src="ImgSlider/6.jpg" alt="New york" style="width: 100%;" />

                    </div>
                </div>
                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span><span class="sr-only">Previous</span> </a><a class="right carousel-control"
                    href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span><span class="sr-only">Next</span> </a>
            </div>
        </div>

        <!-- Middle Contents Start -->
        <hr />
        <div class="container center">
            <div class="row">
                <div class="col-lg-4">
                    <asp:Image ID="imgMobile" runat="server" ImageUrl="~/Mobile/iphone11.jpeg" CssClass="img-circle" Width="140px" Height="140px" AlternateText="Mobiles" />
                    <h2>Mobiles</h2>
                    <p>Featuring a 15.49-cm (6.1) all-screen Liquid Retina LCD and a glass and aluminum design...</p>
                    <p>
                        <asp:LinkButton ID="lnkMobiles" runat="server" CssClass="btn btn-default" Text="View More »" />
                    </p>
                </div>
                <div class="col-lg-4">
                    <asp:Image ID="imgFootwear" runat="server" ImageUrl="~/Images/Shoes.jpeg" CssClass="img-circle" Width="140px" Height="140px" AlternateText="Footwear" />
                    <h2>Footwear</h2>
                    <p>Featuring a 15.49-cm (6.1) all-screen Liquid Retina LCD and a glass and aluminum design...</p>
                    <p>
                        <asp:LinkButton ID="lnkFootwear" runat="server" CssClass="btn btn-default" Text="View More »" />
                    </p>
                </div>
                <div class="col-lg-4">
                    <asp:Image ID="imgClothing" runat="server" ImageUrl="~/Images/tshirt.jpeg" CssClass="img-circle" Width="140px" Height="140px" AlternateText="Clothing" />
                    <h2>Clothings</h2>
                    <p>Featuring a 15.49-cm (6.1) all-screen Liquid Retina LCD and a glass and aluminum design...</p>
                    <p>
                        <asp:LinkButton ID="lnkClothing" runat="server" CssClass="btn btn-default" Text="View More »" />
                    </p>
                </div>
            </div>
        </div>

        <!-- Footer Start -->
        <footer class="container">
            <p>&copy; Company 2024</p>
        </footer>
    </form>

</body>
</html>

