<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Ecommerce.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Form</title>
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

        .form-container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 300px;
        }

        .form-container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .form-group .radio-group {
            display: flex;
            justify-content: space-around;
        }

        .form-group .radio-group input {
            margin-right: 5px;
        }

        .form-group .error-message {
            color: red;
            font-size: 0.9em;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-group button:hover {
            background-color: #218838;
        }

        .form-group .message {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h1>Registration Form</h1>
            <div class="form-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblMail" runat="server" Text="Email:"></asp:Label>
                <asp:TextBox ID="txtMail" runat="server" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMail" ErrorMessage="Email is required" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtMail" ErrorMessage="Email format incorrect" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
                <div class="radio-group">
                    <asp:RadioButton ID="rbMale" runat="server" GroupName="Gender" Text="Male" />
                    <asp:RadioButton ID="rbFemale" runat="server" GroupName="Gender" Text="Female" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblDOB" runat="server" Text="Date of Birth"></asp:Label>
                <asp:TextBox ID="txtDOB" runat="server" TextMode="Date"></asp:TextBox>
    
</div>

            <div class="form-group">
                <asp:Label ID="lblCity" runat="server" Text="City:"></asp:Label>
                <asp:DropDownList ID="ddlCity" runat="server">
                    <asp:ListItem Text="Select City" Value=""></asp:ListItem>
                    <asp:ListItem Text="Nashik" Value="Nashik"></asp:ListItem>
                    <asp:ListItem Text="Mumbai" Value="Mumbai"></asp:ListItem>
                    <asp:ListItem Text="Delhi" Value="Delhi"></asp:ListItem>
                    <asp:ListItem Text="Pune" Value="Pune"></asp:ListItem>
                    <asp:ListItem Text="Bengaluru" Value="Bengaluru"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlCity" InitialValue="" ErrorMessage="Select a city" ForeColor="Red" CssClass="error-message"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Register" OnClick="btnSubmit_Click1" />
            </div>

            <div class="form-group message">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
