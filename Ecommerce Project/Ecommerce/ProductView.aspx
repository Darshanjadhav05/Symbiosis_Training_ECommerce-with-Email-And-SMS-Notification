<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductView.aspx.cs" Inherits="Ecommerce.ProductView" %>

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

        #LogoutButton, #cartButton {
            margin: 10px;
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
                        <li id="cartButton">
                            <button id="btnCart2" runat="server" class="btn btn-primary navbar-btn pull-right" onserverclick="btnCart2_ServerClick" type="button">
                                Cart <span id="CartBadge" runat="server" class="badge">0</span>
                            </button>
                        </li>
                        <li id="LogoutButton">
                            <asp:Button ID="btnlogout" CssClass="btn btn-default navbar-btn" runat="server" Text="Sign Out" OnClick="btnlogout_Click" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>


        <!---nav ends --->

        <br />
        <div style="padding-top: 50px">


            <!--- Success Alert --->
            <div id="divSuccess" runat="server" class="alert alert-success alert-dismissible fade in h4">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                <strong>Success! </strong>Item successfully added to cart. <a href="Cart.aspx">View Cart</a>
            </div>

            <div class="col-md-5">
                <div style="max-width: 480px" class="thumbnail">
                    <%--   for proImage slider--%>
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="4"></li>

                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">

                            <asp:Repeater ID="rptrImage" runat="server">
                                <ItemTemplate>
                                    <div class="item <%# GetActiveImgClass(Container.ItemIndex) %>">
                                        <img src="Images/ProductImages/<%# Eval("PID") %>/<%# Eval("Name") %><%# Eval("Extention") %>"
                                            alt="<%# Eval("Name") %>"
                                            onerror="this.src='Images/ImageNotAvailable.jpg'" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>



                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                    <%--  for proimage slider ending--%>
                </div>
            </div>
            <div class="col-md-5">
                <asp:Repeater ID="rptrProductDetails" runat="server">
                    <ItemTemplate>
                        <div class="divDet1">
                            <h1 class="proNameView"><%# Eval("PName") %> </h1>
                            <span class="proOgPriceView">Rs.<%#Eval("PPrice","{0:c}") %></span> <span class="proPriceDiscountView">Off Rs.<%# string.Format("{0}",Convert.ToInt64(Eval("PPrice"))-Convert.ToInt64(Eval("PSelPrice"))) %></span><p class="proPriceView">Rs. <%#Eval("PSelPrice","{0:c}") %></p>
                        </div>
                        <div>
                            <h5 class="h5size">SIZE</h5>
                            <div>
                                <asp:RadioButtonList ID="rblSize" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="S" Text="S"></asp:ListItem>
                                    <asp:ListItem Value="M" Text="M"></asp:ListItem>
                                    <asp:ListItem Value="L" Text="L"></asp:ListItem>
                                    <asp:ListItem Value="XL" Text="XL"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="divDet1">
                            <asp:Button ID="btnAddtoCart" CssClass="mainButton" runat="server" Text="ADD TO CART" OnClick="btnAddtoCart_Click" />
                            <asp:Label ID="lblError" CssClass="text-danger " runat="server"></asp:Label>

                        </div>
                        <div class="divDet1">
                            <h5 class="h5size">Description</h5>
                            <p><%#Eval("PDescription") %>          </p>

                            <h5 class="h5size">Product Details</h5>
                            <p><%#Eval("PProductDetails") %>     </p>

                        </div>

                    </ItemTemplate>
                </asp:Repeater>
            </div>
    </form>
</body>
</html>
