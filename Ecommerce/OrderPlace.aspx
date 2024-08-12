<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderPlace.aspx.cs" Inherits="Ecommerce.OrderPlace" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        #form1 {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        #orderDetails {
            margin-top: 20px;
        }
        
        #LabelTotal {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
       
        #ListBoxOrder{
            border:none;

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Order Details</h1>
            Name: <asp:Label ID="LabelUsername" runat="server" Text=""></asp:Label>
            <div id="orderDetails">
                <asp:ListBox ID="ListBoxOrder" runat="server" CssClass="orderList" Height="200px" Width="100%"></asp:ListBox>
            </div>
          
            <div id="LabelTotalContainer">
                Total: <asp:Label ID="LabelTotal" runat="server" Text=""></asp:Label>
            </div>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Log Out" />
    </form>
</body>
</html>
