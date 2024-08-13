<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Ecommerce_ASP.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            <div >
                <a style="display:flex" class="navbar-brand" href="HomePage.aspx">
                <asp:Image ID="imgLogo" runat="server" ImageUrl="~/icons/safeIcons.png" AlternateText="MyEShopping" Height="30px" />
                DJShop
            </a>
            </div>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="HomePage.aspx">Home</a></li>
                <li><a href="About.aspx">About</a></li>
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
                <li>
                    <asp:Button ID="btnCart" CssClass="btn btn-primary navbar-btn" runat="server" Text="Cart" />
                    <asp:Label ID="lblCartCount" runat="server" CssClass="badge"></asp:Label>
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
                <img src="ImgSlider/1.jpg" alt="Los Angeles" style="width: 100%;">
                <div class="carousel-caption">
                    <h3>
                        Women Shopping</h3>
                    <p>
                        50% off</p>
                    <p>
                        <a class="btn btn-lg btn-primary" href="Products.aspx" role="button">Buy Now</a></p>
                </div>
            </div>
            <div class="item">
                <img src="ImgSlider/2.png" alt="Chicago" style="width: 100%;">
                <div class="carousel-caption">
                    <h3>
                        Acce moble Shopping</h3>
                    <p>
                        20% off</p>
                </div>
            </div>
            <div class="item">
                <img src="ImgSlider/3.png" alt="New york" style="width: 100%;">
                <div class="carousel-caption">
                    <h3>
                        On mobile you can get</h3>
                    <p>
                        25% off</p>
                </div>
            </div>
        </div>
        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left">
        </span><span class="sr-only">Previous</span> </a><a class="right carousel-control"
            href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right">
            </span><span class="sr-only">Next</span> </a>
    </div>
</div>
    </form>
</body>
</html>
