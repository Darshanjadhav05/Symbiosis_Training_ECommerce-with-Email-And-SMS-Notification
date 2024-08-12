<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Ecommerce_ASP.HomePage" %>

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
    <script type="text/javascript">
        $(document).ready(function() {
            $("#<%= btnCart.ClientID %>").click(function() {
                window.location.href = "Cart.aspx";
            });
        });
    </script>
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

           
        <!-- Footer Start -->
        <footer class="container">
            <p>&copy; Company 2017-2018</p>
        </footer>
    </form>
    
</body>
</html>
