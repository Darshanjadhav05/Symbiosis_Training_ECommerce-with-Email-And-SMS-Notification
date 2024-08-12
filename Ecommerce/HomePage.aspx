<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Ecommerce.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DJ Ecom - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .nav {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .categories {
            display: flex;
            gap: 15px;
        }

        #HyperLink1, #HyperLink2, #HyperLink3, #HyperLink4 {
            text-decoration: none;
            color: #fff;
            font-weight: bold;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        #HyperLink1:hover, #HyperLink2:hover, #HyperLink3:hover, #HyperLink4:hover {
            background-color: #575757;
        }

        .card_container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .cards {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            margin: 10px;
            width: 250px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 343px;
        }

        .cards:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .cards img {
            height: auto;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .cards .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .price {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .add-to-cart-button {
            padding: 10px 15px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-to-cart-button:hover {
            background-color: #218838;
        }

        .Container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #fbf6f6;
            min-height: 100vh;
        }

        .cart {
            display: flex;
            flex-direction: column;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .cart label {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .cart .ListBox1 {
            margin-bottom: 10px;
            border: none;
            overflow-y: hidden;
        }

        .cart .lbltotal {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        option {
            font-weight: 800;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="nav">
                <asp:Label ID="Label1" runat="server" Text="DJ Ecom"></asp:Label>
                <div class="categories">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Fashion.aspx" Text="Fashion"></asp:HyperLink>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Electronics.aspx" Text="Electronics"></asp:HyperLink>
                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Books.aspx" Text="Books"></asp:HyperLink>
                    <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Toys.aspx" Text="Toys"></asp:HyperLink>
                </div>
                
            </div>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </div>
        <div class="Container">
            <div class="card_container">
                <div class="cards">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/public/camera.jpg" />
                    <div class="product-name"><asp:Label ID="ProductName1" runat="server" Text="Camera"></asp:Label></div>
                    <div class="price">Rs.<asp:Label ID="Price1" runat="server" Text="40000"></asp:Label></div>
                    <asp:Button ID="AddToCartButton1" runat="server" CssClass="add-to-cart-button" Text="Add to Cart" OnClick="AddToCartButton1_Click" />
                </div>
                <div class="cards">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/public/images.jpg" />
                    <div class="product-name"><asp:Label ID="ProductName2" runat="server" Text="Headphones"></asp:Label></div>
                    <div class="price">Rs.<asp:Label ID="Price2" runat="server" Text="3000"></asp:Label></div>
                    <asp:Button ID="AddToCartButton2" runat="server" CssClass="add-to-cart-button" Text="Add to Cart" OnClick="AddToCartButton2_Click" />
                </div>
                <div class="cards">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/public/shampoo.jpg" />
                    <div class="product-name"><asp:Label ID="ProductName3" runat="server" Text="Shampoo"></asp:Label></div>
                    <div class="price">Rs.<asp:Label ID="Price3" runat="server" Text="2000"></asp:Label></div>
                    <asp:Button ID="AddToCartButton3" runat="server" CssClass="add-to-cart-button" Text="Add to Cart" OnClick="AddToCartButton3_Click" />
                </div>
            </div>
            <div class="cart">
                <asp:Label ID="Label4" runat="server" Text="Cart"></asp:Label>
                <asp:ListBox ID="ListBox1" runat="server" Height="188px" Width="191px" CssClass="ListBox1"></asp:ListBox>
                <asp:Label ID="lbltotal" runat="server" CssClass="lbltotal"></asp:Label>
                <asp:Button ID="Button8" runat="server" Text="Place Your Order" OnClick="Button8_Click" />
            </div>
        </div>
    </form>
</body>
</html>
