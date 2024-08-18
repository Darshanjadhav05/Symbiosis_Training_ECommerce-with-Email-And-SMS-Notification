using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

using Twilio.Types;
using Twilio;

using Twilio.Rest.Api.V2010.Account;
using System.Net.Mail;
using System.Net;
using System.Xml.Linq;

namespace Ecommerce
{
    public partial class Payment : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString; // Connection string to the database
        public static Int32 OrderNumber = 1; // Static variable to hold the order number
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USERNAME"] != null) // Check if the user is logged in
            {
                if (!IsPostBack) // Ensure this block only runs on the first load
                {
                    BindPriceData2(); // Method to bind price data
                    genAutoNum(); // Method to generate an order number

                    BindOrderProducts(); // Method to bind ordered products
                }
            }
            else
            {
                Response.Redirect("SignIn.aspx"); // Redirect to sign-in page if user is not logged in
            }
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Clear the session data
            Response.Redirect("SignIn.aspx"); // Redirect to sign-in page
        }

        protected void btnCart2_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx"); // Redirect to cart page
        }

        protected void btnPaytm_Click(object sender, EventArgs e)
        {
            if (Session["USERNAME"] != null) // Check if the user is logged in
            {
                string USERID = Session["USERID"].ToString(); // Get user ID from session
                string PaymentType = "Paytm"; // Payment type
                string PaymentStatus = "NotPaid"; // Initial payment status
                string EMAILID = Session["USEREMAIL"].ToString(); // Get user email from session
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("insert into tblPurchase values('" + USERID + "','"
                        + hdPidSizeID.Value + "','" + hdCartAmount.Value + "','" + hdCartDiscount.Value + "','"
                        + hdTotalPayed.Value + "','" + PaymentType + "','" + PaymentStatus + "',getdate(),'"
                        + txtName.Text + "','" + txtAddress.Text + "','" + txtPinCode.Text + "','" + txtMobileNumber.Text + "') select SCOPE_IDENTITY()", con); // Insert order details into tblPurchase
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open(); // Open the database connection if it's closed
                    }
                    Int64 PurchaseID = Convert.ToInt64(cmd.ExecuteScalar()); // Execute the insert command and get the purchase ID
                }
            }
            else
            {
                Response.Redirect("SignIn.aspx"); // Redirect to sign-in page if user is not logged in
            }
        }


        protected void BtnPlaceNPay_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null) // Check if the user is logged in
            {
                // Set session variables with order details
                Session["Address"] = txtAddress.Text;
                Session["Mobile"] = txtMobileNumber.Text;
                Session["OrderNumber"] = OrderNumber.ToString();
                Session["PayMethod"] = "Place n Pay";
                Session["Date"] = DateTime.Now;

                string USERID = Session["USERID"].ToString(); // Get user ID from session
                string PaymentType = "PnP"; // Payment type
                string PaymentStatus = "NotPaid"; // Initial payment status
                string EMAILID = Session["USEREMAIL"].ToString(); // Get user email from session
                string OrderStatus = "Pending"; // Initial order status
                string FullName = Session["getFullName"].ToString(); // Get user's full name from session
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_InsertOrder", con); // Stored procedure to insert order details
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", USERID);
                    cmd.Parameters.AddWithValue("@Email", EMAILID);
                    cmd.Parameters.AddWithValue("@CartAmount", hdCartAmount.Value);
                    cmd.Parameters.AddWithValue("@CartDiscount", hdCartDiscount.Value);
                    Session["totalAmt"] = hdTotalPayed.Value; // Store total amount in session
                    cmd.Parameters.AddWithValue("@TotalPaid", hdTotalPayed.Value);
                    cmd.Parameters.AddWithValue("@PaymentType", PaymentType);
                    cmd.Parameters.AddWithValue("@PaymentStatus", PaymentStatus);
                    cmd.Parameters.AddWithValue("@DateOfPurchase", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Name", FullName);
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@MobileNumber", txtMobileNumber.Text);
                    cmd.Parameters.AddWithValue("@OrderStatus", OrderStatus);
                    cmd.Parameters.AddWithValue("@OrderNumber", OrderNumber.ToString());
                    if (con.State == ConnectionState.Closed) { con.Open(); } // Open the database connection if it's closed
                    Int64 OrderID = Convert.ToInt64(cmd.ExecuteScalar()); // Execute the stored procedure and get the order ID
                    InsertOrderProducts(); // Insert ordered products into the database
                }
            }
            else
            {
                Response.Redirect("SignIn.aspx?RtPP=yes"); // Redirect to sign-in page with a query parameter
            }
        }

        private void InsertOrderProducts()
        {
            string USERID = Session["USERID"].ToString(); // Get user ID from session
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                foreach (GridViewRow gvr in gvProducts.Rows) // Loop through each product in the GridView
                {
                    SqlCommand myCmd = new SqlCommand("SP_InsertOrderProducts", con) // Stored procedure to insert order products
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    myCmd.Parameters.AddWithValue("@OrderID", OrderNumber.ToString());
                    myCmd.Parameters.AddWithValue("@UserID", USERID);
                    myCmd.Parameters.AddWithValue("@PID", gvr.Cells[0].Text);
                    myCmd.Parameters.AddWithValue("@Products", gvr.Cells[1].Text);
                    myCmd.Parameters.AddWithValue("@Quantity", gvr.Cells[2].Text);
                    myCmd.Parameters.AddWithValue("@OrderDate", DateTime.Now.ToString("yyyy-MM-dd"));
                    myCmd.Parameters.AddWithValue("@Status", "Pending");
                    if (con.State == ConnectionState.Closed) { con.Open(); } // Open the database connection if it's closed
                    Int64 OrderProID = Convert.ToInt64(myCmd.ExecuteScalar()); // Execute the stored procedure and get the order product ID
                    con.Close(); // Close the database connection
                    EmptyCart(); // Empty the user's cart

                    string phoneNumber = Session["Mobile"].ToString(); // Get the user's mobile number from session

                    // Your Twilio Account SID and Auth Token
                    const string accountSid = "AC8905b372fb440e567631bedf36d7ee4d";
                    const string authToken = "8e35cb725821d294fd3d10c9865b3b32";

                    // Initialize the Twilio client
                    TwilioClient.Init(accountSid, authToken);

                    try
                    {
                        var oid = Session["OrderNumber"]; // Get the order number from session
                        var message = MessageResource.Create(
                            body: $"\nThank You for purchasing from EasyShop,\nYour Order : {oid}\nis Confirmed & will be delivered soon.\nHave a nice day !!!",
                            from: new PhoneNumber("+19787231611"),
                            to: new PhoneNumber("+91" + phoneNumber) // Indian phone number with country code
                        );

                        string toEmail = Session["USEREMAIL"].ToString(); // Get the user's email from session
                        var uname = Session["getFullName"]; // Get the user's full name from session
                        var date = Session["Date"]; // Get the date from session
                        var totalamt = Session["totalAmt"]; // Get the total amount from session

                        string messageBody = $"Dear {uname},\r\n\r\nThank you for shopping with us at EasyShop! We're excited to inform you that your order has been successfully placed.\r\n\r\nOrder Details:\r\n\r\nOrder Number: {oid}\r\nOrder Date: {date}\r\nTotal Amount: {totalamt}\r\n\r\nYou can track your order status anytime by visiting your account on our website.\r\n\r\nIf you have any questions or need further assistance, feel free to contact our customer support at darshanjadhav5@gmail.com.\r\n\r\nThank you once again for choosing EasyShop. We hope you enjoy your purchase!\r\n\r\nBest Regards,\r\nThe EasyShop Team\r\nEasyShop.in\r\nEasyShop@gmail.com";
                        // Configure the email client
                        SmtpClient client = new SmtpClient("smtp.gmail.com"); // Replace with your SMTP server
                        client.Port = 587; // Typically, 587 for TLS or 465 for SSL
                        client.UseDefaultCredentials = false;
                        client.Credentials = new NetworkCredential("easyshop791@gmail.com", "xpuy qcyp zutu hjjd"); // Set email credentials
                        client.EnableSsl = true; // Enable SSL for secure email sending

                        // Create the email message
                        MailMessage mailMessage = new MailMessage();
                        mailMessage.From = new MailAddress("easyshop791@gmail.com"); // Sender's email address
                        mailMessage.To.Add(toEmail); // Recipient's email address
                        mailMessage.Subject = "Order Placed Successfully !!!"; // Email subject
                        mailMessage.Body = messageBody; // Email body

                        // Send the email
                        client.Send(mailMessage); // Send the email
                        EmptyCart(); // Empty the user's cart
                        Response.Write($"<script type='text/javascript'>alert('Order SMS sent successfully!!')</script>"); // Show success message
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script type='text/javascript'>alert(Error: '{ex.Message}')</script>"); // Show error message if email sending fails
                    }

                    Response.Redirect("Success.aspx"); // Redirect to success page after order is placed
                }
            }
        }

        private void EmptyCart()
        {
            Int32 CartUIDD = Convert.ToInt32(Session["USERID"].ToString()); // Get user ID from session
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmdU = new SqlCommand("SP_EmptyCart", con) // Stored procedure to empty the cart
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmdU.Parameters.AddWithValue("@UserID", CartUIDD); // Pass user ID as parameter
                if (con.State == ConnectionState.Closed) { con.Open(); } // Open the database connection if it's closed
                cmdU.ExecuteNonQuery(); // Execute the stored procedure
                con.Close(); // Close the database connection
            }
        }

        private void BindOrderProducts()
        {
            string UserIDD = Session["USERID"].ToString(); // Get user ID from session
            DataTable dt = new DataTable(); // Create a DataTable to hold products
            using (SqlConnection con0 = new SqlConnection(connectionString))
            {
                SqlCommand cmd0 = new SqlCommand("SP_BindCartProducts", con0) // Stored procedure to bind cart products
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd0.Parameters.AddWithValue("@UID", UserIDD); // Pass user ID as parameter
                using (SqlDataAdapter sda0 = new SqlDataAdapter(cmd0))
                {
                    sda0.Fill(dt); // Fill DataTable with cart products
                    if (dt.Rows.Count > 0) // Check if there are any rows in the DataTable
                    {
                        foreach (DataColumn PID in dt.Columns) // Loop through each column
                        {
                            using (SqlConnection con = new SqlConnection(connectionString))
                            {
                                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tblCart C WHERE C.PID=" + PID + " AND UID ='" + UserIDD + "'", con)) // Query to get cart products
                                {
                                    cmd.CommandType = CommandType.Text;
                                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                                    {
                                        DataTable dtProducts = new DataTable(); // Create a DataTable to hold products
                                        sda.Fill(dtProducts); // Fill DataTable with product data
                                        gvProducts.DataSource = dtProducts; // Bind DataTable to GridView
                                        gvProducts.DataBind(); // DataBind the GridView
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        private void BindPriceData2()
        {
            string UserIDD = Session["USERID"].ToString(); // Get user ID from session
            DataTable dt = new DataTable(); // Create a DataTable to hold price data
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_BindPriceData", con) // Stored procedure to bind price data
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("UserID", UserIDD); // Pass user ID as parameter
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    sda.Fill(dt); // Fill DataTable with price data
                    if (dt.Rows.Count > 0) // Check if there are any rows in the DataTable
                    {
                        string Total = dt.Compute("Sum(SubSAmount)", "").ToString(); // Compute total amount
                        string CartTotal = dt.Compute("Sum(SubPAmount)", "").ToString(); // Compute cart total
                        string CartQuantity = dt.Compute("Sum(Qty)", "").ToString(); // Compute cart quantity
                        int Total1 = Convert.ToInt32(dt.Compute("Sum(SubSAmount)", ""));
                        int CartTotal1 = Convert.ToInt32(dt.Compute("Sum(SubPAmount)", ""));
                        spanTotal.InnerText = "Rs. " + string.Format("{0:#,###.##}", double.Parse(Total)) + ".00"; // Display total amount
                        Session["myCartAmount"] = string.Format("{0:####}", double.Parse(Total)); // Store cart amount in session
                        spanCartTotal.InnerText = "Rs. " + string.Format("{0:#,###.##}", double.Parse(CartTotal)) + ".00"; // Display cart total
                        spanDiscount.InnerText = "- Rs. " + (CartTotal1 - Total1).ToString(); // Display discount
                        Session["TotalAmount"] = spanTotal.InnerText; // Store total amount in session
                        hdCartAmount.Value = CartTotal.ToString(); // Set hidden field value for cart amount
                        hdCartDiscount.Value = (CartTotal1 - Total1).ToString() + ".00"; // Set hidden field value for cart discount
                        hdTotalPayed.Value = Total.ToString(); // Set hidden field value for total paid
                    }
                    else
                    {
                        Response.Redirect("Products.aspx"); // Redirect to products page if no data is found
                    }
                }
            }
        }

        private void genAutoNum()
        {
            Random r = new Random();
            int num = r.Next(Convert.ToInt32("231965"), // Generate a random number between 231965 and 987654
           Convert.ToInt32("987654"));
            string ChkOrderNum = num.ToString();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_FindOrderNumber", con) // Stored procedure to check order number uniqueness
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@FindOrderNumber", ChkOrderNum); // Pass generated order number as parameter
                if (con.State == ConnectionState.Closed) { con.Open(); } // Open the database connection if it's closed
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable(); // Create a DataTable to hold result
                    sda.Fill(dt); // Fill DataTable with result
                    con.Close(); // Close the database connection
                    if (dt.Rows.Count > 0) // Check if order number already exists
                    {
                        genAutoNum(); // Recursively call the method to generate a new number
                    }
                    else
                    {
                        OrderNumber = Convert.ToInt32(num.ToString()); // Set the order number if unique
                    }
                }
            }
        }
    }
}
