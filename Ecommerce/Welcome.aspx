<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="Ecommerce.Welcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Welcome to DJ Ecom</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .container h1 {
            font-size: 2.5em;
            color: #333;
            margin-bottom: 40px;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        #LinkButton1,#LinkButton2 {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1em;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-group a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
      
             
        <div class="container">
            <h1>Welcome to DJ Ecom</h1>
            <div class="btn-group">
               <asp:LinkButton ID="LinkButton1" runat="server" CssClass="link-button registration-button" PostBackUrl="~/Registration.aspx" >Registration</asp:LinkButton>
<br />
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="link-button login-button" PostBackUrl="~/Login.aspx" >LogIn</asp:LinkButton>
            </div>
        </div>
   
  
    </form>
</body>
</html>
