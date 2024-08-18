using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Globalization;
using System.Threading;

namespace Ecommerce
{
    public partial class ProductView : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString; // Connection string from configuration
        readonly Int32 myQty = 1; // Default quantity for adding products to the cart

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["PID"] != null) // Check if the "PID" parameter exists in the query string
            {
                if (!IsPostBack) // Check if the page is not being posted back
                {
                    divSuccess.Visible = false; // Hide success message by default
                    BindProductImage2(); // Bind product images to the Repeater
                    BindProductDetails(); // Bind product details to the Repeater
                    BindCartNumber(); // Bind cart number to the badge
                }
            }
            else
            {
                Response.Redirect("~/Products.aspx"); // Redirect to Products page if "PID" is not present
            }
        }

        private void BindProductDetails()
        {
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]); // Get product ID from query string
            using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
            {
                SqlCommand cmd = new SqlCommand("SP_BindProductDetails", con)
                {
                    CommandType = CommandType.StoredProcedure // Use stored procedure
                };
                cmd.Parameters.AddWithValue("@PID", PID); // Add parameter for product ID
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable(); // Create DataTable to hold product details
                    sda.Fill(dt); // Fill DataTable with product details
                    rptrProductDetails.DataSource = dt; // Bind DataTable to Repeater
                    rptrProductDetails.DataBind(); // DataBind the Repeater
                    Session["CartPID"] = Convert.ToInt32(dt.Rows[0]["PID"].ToString()); // Store product ID in session
                    Session["myPName"] = dt.Rows[0]["PName"].ToString(); // Store product name in session
                    Session["myPPrice"] = dt.Rows[0]["PPrice"].ToString(); // Store product price in session
                    Session["myPSelPrice"] = dt.Rows[0]["PSelPrice"].ToString(); // Store product sale price in session
                }
            }
        }

        private void BindProductImage2()
        {
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]); // Get product ID from query string
            using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
            {
                SqlCommand cmd = new SqlCommand("SP_BindProductImages", con)
                {
                    CommandType = CommandType.StoredProcedure // Use stored procedure
                };
                cmd.Parameters.AddWithValue("@PID", PID); // Add parameter for product ID
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable(); // Create DataTable to hold product images
                    sda.Fill(dt); // Fill DataTable with product images
                    rptrImage.DataSource = dt; // Bind DataTable to Repeater
                    rptrImage.DataBind(); // DataBind the Repeater
                }
            }
        }

        protected string GetActiveImgClass(int ItemIndex)
        {
            // Return "active" class for the first item to make it visible by default
            if (ItemIndex == 0)
            {
                return "active";
            }
            else
            {
                return ""; // Return empty string for other items
            }
        }

        protected void btnAddtoCart_Click(object sender, EventArgs e)
        {
            string SelectedSize = string.Empty; // Initialize selected size
            foreach (RepeaterItem item in rptrProductDetails.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var rbList = item.FindControl("rblSize") as RadioButtonList; // Find size selection control
                    SelectedSize = rbList.SelectedValue; // Get selected size
                    var lblError = item.FindControl("lblError") as Label; // Find error label
                    lblError.Text = ""; // Clear error message
                }
            }

            if (SelectedSize != "") // Check if a size is selected
            {
                Int64 PID = Convert.ToInt64(Request.QueryString["PID"]); // Get product ID from query string
                AddToCartProduction(); // Add product to cart
                Response.Redirect("ProductView.aspx?PID=" + PID); // Refresh page with the same product ID
            }
            else
            {
                foreach (RepeaterItem item in rptrProductDetails.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        var lblError = item.FindControl("lblError") as Label; // Find error label
                        lblError.Text = "Please select a size"; // Show error message
                    }
                }
            }
        }

        private void AddToCartProduction()
        {
            if (Session["Username"] != null) // Check if user is logged in
            {
                Int32 UserID = Convert.ToInt32(Session["USERID"].ToString()); // Get user ID from session
                Int64 PID = Convert.ToInt64(Request.QueryString["PID"]); // Get product ID from query string
                using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
                {
                    con.Open(); // Open the connection
                    SqlCommand cmd = new SqlCommand("SP_IsProductExistInCart", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure
                    };
                    cmd.Parameters.AddWithValue("@UserID", UserID); // Add user ID parameter
                    cmd.Parameters.AddWithValue("@PID", PID); // Add product ID parameter
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable(); // Create DataTable to hold result
                        sda.Fill(dt); // Fill DataTable with result
                        if (dt.Rows.Count > 0) // Check if product already exists in cart
                        {
                            Int32 updateQty = Convert.ToInt32(dt.Rows[0]["Qty"].ToString()); // Get current quantity
                            SqlCommand myCmd = new SqlCommand("SP_UpdateCart", con)
                            {
                                CommandType = CommandType.StoredProcedure // Use stored procedure
                            };
                            myCmd.Parameters.AddWithValue("@Quantity", updateQty + 1); // Increment quantity
                            myCmd.Parameters.AddWithValue("@CartPID", PID); // Add product ID parameter
                            myCmd.Parameters.AddWithValue("@UserID", UserID); // Add user ID parameter
                            Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar()); // Execute stored procedure
                            BindCartNumber(); // Update cart number
                            divSuccess.Visible = true; // Show success message
                        }
                        else
                        {
                            SqlCommand myCmd = new SqlCommand("SP_InsertCart", con)
                            {
                                CommandType = CommandType.StoredProcedure // Use stored procedure
                            };
                            myCmd.Parameters.AddWithValue("@UID", UserID); // Add user ID parameter
                            myCmd.Parameters.AddWithValue("@PID", Session["CartPID"].ToString()); // Add product ID parameter
                            myCmd.Parameters.AddWithValue("@PName", Session["myPName"].ToString()); // Add product name parameter
                            myCmd.Parameters.AddWithValue("@PPrice", Session["myPPrice"].ToString()); // Add product price parameter
                            myCmd.Parameters.AddWithValue("@PSelPrice", Session["myPSelPrice"].ToString()); // Add product sale price parameter
                            myCmd.Parameters.AddWithValue("@Qty", myQty); // Add quantity parameter
                            Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar()); // Execute stored procedure
                            con.Close(); // Close the connection
                            BindCartNumber(); // Update cart number
                            divSuccess.Visible = true; // Show success message
                        }
                    }
                }
            }
            else
            {
                Int64 PID = Convert.ToInt64(Request.QueryString["PID"]); // Get product ID from query string
                Response.Redirect("Signin.aspx?rurl=" + PID); // Redirect to sign-in page
            }
        }

        public void BindCartNumber()
        {
            if (Session["USERID"] != null) // Check if user is logged in
            {
                string UserIDD = Session["USERID"].ToString(); // Get user ID from session
                DataTable dt = new DataTable(); // Create DataTable to hold cart quantity
                using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
                {
                    SqlCommand cmd = new SqlCommand("SP_BindCartNumberz", con)
                    {
                        CommandType = CommandType.StoredProcedure // Use stored procedure
                    };
                    cmd.Parameters.AddWithValue("@UserID", UserIDD); // Add user ID parameter
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt); // Fill DataTable with cart quantity
                        if (dt.Rows.Count > 0) // Check if there are rows in DataTable
                        {
                            string CartQuantity = dt.Compute("Sum(Qty)", "").ToString(); // Compute total quantity
                            CartBadge.InnerText = CartQuantity; // Display cart quantity
                        }
                        else
                        {
                            CartBadge.InnerText = 0.ToString(); // Set cart quantity to 0 if empty
                        }
                    }
                }
            }
        }

        protected void btnCart2_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx"); // Redirect to Cart page
        }

        protected override void InitializeCulture()
        {
            CultureInfo ci = new CultureInfo("en-IN"); // Set culture to Indian
            ci.NumberFormat.CurrencySymbol = "₹"; // Set currency symbol to Indian Rupee
            Thread.CurrentThread.CurrentCulture = ci; // Apply culture to the current thread

            base.InitializeCulture(); // Call base method
        }

        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Clear all session data
            Response.Redirect("SignIn.aspx"); // Redirect to Sign-In page
        }
    }
}
