using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Ecommerce
{
    public partial class Cart : System.Web.UI.Page
    {
        // Connection string to the database, retrieved from web.config
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

        // This method is triggered when the page is loaded
        protected void Page_Load(object sender, EventArgs e)
        {
            divQtyError.Visible = false; // Hide the quantity error message by default
            if (!IsPostBack) // Check if the page is loaded for the first time
            {
                if (Session["Username"] != null) // Check if the user is logged in
                {
                    BindProductCart(); // Bind the products in the cart to the Repeater control
                    BindCartNumber(); // Update the cart item count
                }
                else
                {
                    Response.Redirect("Signin.aspx"); // Redirect to Signin page if the user is not logged in
                }
            }
        }

        // Redirects the user to the Cart page when btnCart2 is clicked
        protected void btnCart2_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        // Handles commands from the Repeater control (e.g., adding, removing items)
        protected void RptrCartProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Int32 UserID = Convert.ToInt32(Session["USERID"].ToString()); // Get the user ID from session
            // This block handles the "DoPlus" command, which increases the item quantity by 1
            if (e.CommandName == "DoPlus")
            {
                string PID = (e.CommandArgument.ToString()); // Get the product ID (PID) from the command argument
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_getUserCartItem", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure to get the cart item
                    };
                    cmd.Parameters.AddWithValue("@PID", PID);
                    cmd.Parameters.AddWithValue("@UserID", UserID);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // Fill the DataTable with the result
                        if (dt.Rows.Count > 0)
                        {
                            Int32 updateQty = Convert.ToInt32(dt.Rows[0]["Qty"].ToString()); // Get the current quantity
                            SqlCommand myCmd = new SqlCommand("SP_UpdateCart", con)
                            {
                                CommandType = CommandType.StoredProcedure // Use stored procedure to update the cart
                            };
                            myCmd.Parameters.AddWithValue("@Quantity", updateQty + 1); // Increase the quantity by 1
                            myCmd.Parameters.AddWithValue("@CartPID", PID);
                            myCmd.Parameters.AddWithValue("@UserID", UserID);
                            con.Open();
                            Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar()); // Execute the query and get the Cart ID
                            con.Close();
                            BindProductCart(); // Refresh the cart display
                            BindCartNumber(); // Refresh the cart item count
                        }
                    }
                }
            }
            // This block handles the "DoMinus" command, which decreases the item quantity by 1
            else if (e.CommandName == "DoMinus")
            {
                string PID = (e.CommandArgument.ToString()); // Get the product ID (PID) from the command argument
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_getUserCartItem", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure to get the cart item
                    };
                    cmd.Parameters.AddWithValue("@PID", PID);
                    cmd.Parameters.AddWithValue("@UserID", UserID);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // Fill the DataTable with the result
                        if (dt.Rows.Count > 0)
                        {
                            Int32 myQty = Convert.ToInt32(dt.Rows[0]["Qty"].ToString()); // Get the current quantity
                            if (myQty <= 1) // If the quantity is 1 or less, show an error message
                            {
                                divQtyError.Visible = true;
                            }
                            else
                            {
                                SqlCommand myCmd = new SqlCommand("SP_UpdateCart", con)
                                {
                                    CommandType = CommandType.StoredProcedure // Use stored procedure to update the cart
                                };
                                myCmd.Parameters.AddWithValue("@Quantity", myQty - 1); // Decrease the quantity by 1
                                myCmd.Parameters.AddWithValue("@CartPID", PID);
                                myCmd.Parameters.AddWithValue("@UserID", UserID);
                                con.Open();
                                Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar()); // Execute the query and get the Cart ID
                                con.Close();
                                BindProductCart(); // Refresh the cart display
                                BindCartNumber(); // Refresh the cart item count
                            }
                        }
                    }
                }
            }
            // This block handles the "RemoveThisCart" command, which removes an item from the cart
            else if (e.CommandName == "RemoveThisCart")
            {
                int CartPID = Convert.ToInt32(e.CommandArgument.ToString().Trim()); // Get the cart product ID
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand myCmd = new SqlCommand("SP_DeleteThisCartItem", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure to delete the cart item
                    };
                    myCmd.Parameters.AddWithValue("@CartID", CartPID);
                    con.Open();
                    myCmd.ExecuteNonQuery(); // Execute the delete command
                    con.Close();
                    BindProductCart(); // Refresh the cart display
                    BindCartNumber(); // Refresh the cart item count
                }
            }
        }

        // Binds the products in the cart to the Repeater control
        private void BindProductCart()
        {
            string UserIDD = Session["USERID"].ToString(); // Get the user ID from session
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SP_BindUserCart", con)
                {
                    CommandType = CommandType.StoredProcedure // Use stored procedure to bind the cart items
                };
                cmd.Parameters.AddWithValue("@UserID", UserIDD);
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    sda.Fill(dt); // Fill the DataTable with the result
                    RptrCartProducts.DataSource = dt; // Set the DataSource of the Repeater to the DataTable
                    RptrCartProducts.DataBind(); // Bind the data to the Repeater control
                    if (dt.Rows.Count > 0)
                    {
                        string Total = dt.Compute("Sum(SubSAmount)", "").ToString(); // Calculate the total amount
                        string CartTotal = dt.Compute("Sum(SubPAmount)", "").ToString(); // Calculate the total cart amount
                        string CartQuantity = dt.Compute("Sum(Qty)", "").ToString(); // Calculate the total quantity
                        h4NoItems.InnerText = "My Cart ( " + CartQuantity + " Item(s) )"; // Display the cart quantity
                        int Total1 = Convert.ToInt32(dt.Compute("Sum(SubSAmount)", ""));
                        int CartTotal1 = Convert.ToInt32(dt.Compute("Sum(SubPAmount)", ""));
                        spanTotal.InnerText = "Rs. " + string.Format("{0:#,###.##}", double.Parse(Total)) + ".00"; // Display the total amount
                        spanCartTotal.InnerText = "Rs. " + string.Format("{0:#,###.##}", double.Parse(CartTotal)) + ".00"; // Display the cart total
                        spanDiscount.InnerText = "- Rs. " + (CartTotal1 - Total1).ToString() + ".00"; // Display the discount
                    }
                    else
                    {
                        h4NoItems.InnerText = "Your Shopping Cart is Empty."; // Display a message if the cart is empty
                        divAmountSect.Visible = false; // Hide the amount section if the cart is empty
                    }
                }
            }
        }

        // Binds the number of items in the cart to the CartBadge control
        public void BindCartNumber()
        {
            if (Session["USERID"] != null) // Check if the user is logged in
            {
                string UserIDD = Session["USERID"].ToString(); // Get the user ID from session
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SP_BindCartNumberz", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure to get the cart number
                    };
                    cmd.Parameters.AddWithValue("@UserID", UserIDD);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt); // Fill the DataTable with the result
                        if (dt.Rows.Count > 0)
                        {
                            string CartQuantity = dt.Compute("Sum(Qty)", "").ToString(); // Calculate the total quantity
                            CartBadge.InnerText = CartQuantity; // Display the quantity in the CartBadge
                        }
                        else
                        {
                            CartBadge.InnerText = "0"; // Display "0" if there are no items in the cart
                        }
                    }
                }
            }
        }

        // Redirects the user to the Payment page when btnBuyNow is clicked
        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx");
        }

        // Logs the user out and redirects to the SignIn page
        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Clear the session
            Response.Redirect("SignIn.aspx");
        }
    }
}
