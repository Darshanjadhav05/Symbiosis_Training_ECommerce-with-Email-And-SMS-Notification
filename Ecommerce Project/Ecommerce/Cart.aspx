<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Ecommerce.Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>E-Cart</title>
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

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container">
                    <br />
                    <br />

                    <div style="padding-top: 50px">
                        <div class="col-md-9">
                            <h4 class="proNameViewCart" runat="server" id="h4NoItems"></h4>
                            <div id="divQtyError" runat="server" class="alert alert-success alert-dismissible fade in h4">
                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                <strong>Oops! </strong>Quantity cannot be less than 1.
                            </div>
                            <asp:Repeater ID="RptrCartProducts" OnItemCommand="RptrCartProducts_ItemCommand" runat="server">
                                <ItemTemplate>
                                    <%--Show cart details start--%>
                                    <div class="media" style="border: 1px solid black;">
                                        <div class="media-left">
                                            <a href="ProductView.aspx?PID=<%# Eval("PID") %>" target="_blank">
                                                <img class="media-object" width="100px" src="Images/ProductImages/<%# Eval("PID") %>/<%# Eval("Name") %><%# Eval("Extention") %>" alt="<%# Eval("Name") %>" onerror="this.src='Images/NoImg.png'" />
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading proNameViewCart"><%# Eval("PName") %></h4>
                                            <span class="ProPriceViewCart">Rs.&nbsp <%# Eval("PSelPrice","{0:0.00}") %></span>
                                            <span class="proOgPriceView">Rs.&nbsp <%# Eval("PPrice","{0:0.00}") %></span>

                                            <span class="proPriceDiscountView">Off Rs.<%# string.Format("{0}",Convert.ToInt64(Eval("PPrice"))-Convert.ToInt64(Eval("PSelPrice"))) %></span>
                                            <div class="pull-right form-inline">
                                                <asp:Label ID="lblQty" runat="server" Text="Qty:" Font-Size="Large"></asp:Label>
                                                <asp:Button ID="BtnMinus" CommandArgument='<%# Eval("PID") %>' CommandName="DoMinus" Font-Size="Large" runat="server" Text="-" />&nbsp
                                    <asp:TextBox ID="txtQty" runat="server" Width="40" Font-Size="Large" TextMode="SingleLine" Style="text-align: center" Text='<%# Eval("Qty") %>'></asp:TextBox>&nbsp
                                     <asp:Button ID="BtnPlus" CommandArgument='<%# Eval("PID") %>' CommandName="DoPlus" runat="server" Text="+" Font-Size="Large" />&nbsp&nbsp&nbsp                                          
                                            </div>
                                            <br />
                                            <p>
                                                <asp:Button CommandArgument='<%#Eval("CartID") %>' CommandName="RemoveThisCart" ID="btnRemoveCart" CssClass="RemoveButton1" runat="server" Text="Remove" />
                                                <br />
                                                <span class="proNameViewCart pull-right">SubTotal: Rs.&nbsp <%# Eval("SubSAmount","{0:0.00}") %></span>
                                            </p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <%--Show cart details Ending--%>
                        </div>

                        <div class="col-md-3" runat="server" id="divAmountSect">
                            <div>
                                <h5 class=" proNameViewCart">Price Details</h5>
                                <div>
                                    <label class=" ">Total</label>
                                    <span class="pull-right priceGray" runat="server" id="spanCartTotal"></span>
                                </div>
                                <div>
                                    <label class=" ">Cart Discount</label>
                                    <span class="pull-right priceGreen" runat="server" id="spanDiscount"></span>
                                </div>
                            </div>
                            <div>
                                <div class="cartTotal">
                                    <label>Cart Total</label>
                                    <span class="pull-right " runat="server" id="spanTotal"></span>
                                    <div>
                                        <asp:Button ID="btnBuyNow" CssClass="buyNowbtn" runat="server" OnClick="btnBuyNow_Click" Text="BUY NOW" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
