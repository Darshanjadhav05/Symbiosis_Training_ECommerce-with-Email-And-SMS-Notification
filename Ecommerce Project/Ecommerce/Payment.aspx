<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Ecommerce.Payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
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
                        <li id="LogoutButton">
                            <asp:Button ID="btnlogout" CssClass="btn btn-default navbar-btn" runat="server" Text="Sign Out" OnClick="btnlogout_Click" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!--main container-->

        <asp:HiddenField ID="hdCartAmount" runat="server" />
        <asp:HiddenField ID="hdCartDiscount" runat="server" />
        <asp:HiddenField ID="hdTotalPayed" runat="server" />
        <asp:HiddenField ID="hdPidSizeID" runat="server" />

        <br />
        <br />


        <br />
        <div class="row" style="padding-top: 20px;">



            <div class="col-md-9 ">
                <div class="form-horizontal" style="padding: 50px;">
                    <h3>Delivery Address</h3>
                    <hr />
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" CssClass="control-label" Text="Name"></asp:Label>
                        <asp:TextBox ID="txtName" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorUsername" CssClass="text-danger" runat="server" ErrorMessage="This field is Required !" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" CssClass="control-label" Text="Address"></asp:Label>
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="This field is Required !" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" CssClass="control-label" Text="Pin Code"></asp:Label>
                        <asp:TextBox ID="txtPinCode" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ErrorMessage="This field is Required !" ControlToValidate="txtPinCode"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" CssClass="control-label" Text="Mobile Number"></asp:Label>
                        <asp:TextBox ID="txtMobileNumber" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="text-danger" runat="server" ErrorMessage="This field is Required !" ControlToValidate="txtMobileNumber"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div>
                    <asp:GridView ID="gvProducts" runat="server" CssClass="col-md-12" AutoGenerateColumns="false" Visible="false" CellPadding="6"
                        ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                        <Columns>
                            <asp:BoundField DataField="PID" HeaderText="Product ID" />
                            <asp:BoundField DataField="PName" HeaderText="Product Name" />
                            <asp:BoundField DataField="Qty" HeaderText="Quantity" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="col-md-3" runat="server" id="divPriceDetails">
                <div style="border-bottom: 1px solid #eaeaec;">
                    <h5 class="proNameViewCart">PRICE DETAILS</h5>
                    <div>
                        <label>Cart Total</label>
                        <span class="float-right priceGray" id="spanCartTotal" runat="server"></span>
                    </div>
                    <div>
                        <label>Cart Discount</label>
                        <span class="float-right priceGreen" id="spanDiscount" runat="server"></span>
                    </div>
                </div>

                <div>
                    <div class="proPriceView">
                        <label>Total</label>
                        <span class="float-right" id="spanTotal" runat="server"></span>
                    </div>
                </div>
            </div>

            <div class="col-md-12">

                <div class="tab-content" style="padding: 50px;">
                    <div id="PlaceNPay" class="tab-pane fade in active">
                        <h3>Click checkout to place your order..</h3>
                        <asp:Button ID="BtnPlaceNPay" CssClass=" btn btn-info" Font-Size="Large" ValidationGroup="PaymentPage" runat="server" OnClick="BtnPlaceNPay_Click" Text="Checkout &raquo;" />
                    </div>

                </div>
            </div>


        </div>
    </form>
</body>
</html>

