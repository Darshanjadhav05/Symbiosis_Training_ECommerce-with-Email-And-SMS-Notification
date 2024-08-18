using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Configuration;
using System.Reflection.Emit;

namespace Ecommerce
{
    public partial class Dashboard : System.Web.UI.Page
    {
        // Connection string to the database, retrieved from web.config
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

        // This method is triggered when the page is loaded
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null) // Check if the user is logged in
            {
                if (!IsPostBack) // Check if the page is loaded for the first time
                {
                    if (Request.QueryString["BuyNow"] == "YES")
                    {
                        // Placeholder for any functionality when BuyNow query string is "YES"
                    }
                    BindProductRepeater(); // Bind products to the Repeater control
                    BindCartNumber(); // Update the cart item count
                }
            }
            else
            {
                if (Request.QueryString["BuyNow"] == "YES")
                {
                    Response.Redirect("SignIn.aspx"); // Redirect to SignIn page if the user is not logged in and trying to buy now
                }
                else
                {
                    Response.Redirect("~/HomePage.aspx"); // Redirect to HomePage if the user is not logged in
                }
            }

            // Commented out: this code would re-bind the product repeater on every page load
            //if (!IsPostBack)
            //{
            //    BindProductRepeater();
            //}
        }

        // This method sets the culture and currency format for the page
        protected override void InitializeCulture()
        {
            CultureInfo ci = new CultureInfo("en-IN"); // Set culture to Indian English
            ci.NumberFormat.CurrencySymbol = "₹"; // Set currency symbol to Indian Rupee
            Thread.CurrentThread.CurrentCulture = ci; // Apply the culture to the current thread

            base.InitializeCulture(); // Call the base class's InitializeCulture method
        }

        // This method binds all products to the Repeater control
        private void BindProductRepeater()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_BindAllProducts", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure; // Use stored procedure to fetch all products
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // Fill the DataTable with the result
                        rptrProducts.DataSource = dt; // Set the DataSource of the Repeater to the DataTable
                        rptrProducts.DataBind(); // Bind the data to the Repeater control
                        if (dt.Rows.Count <= 0) // Check if there are any products
                        {
                            Label1.Text = "Sorry! Currently no products in this category."; // Show message if no products found
                        }
                        else
                        {
                            Label1.Text = "Showing All Products"; // Show message indicating all products are displayed
                        }
                    }
                }
            }
        }

        // Redirects the user to the Cart page when btnCart2 is clicked
        protected void btnCart2_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
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
                            // Display "0" if there are no items in the cart
                            CartBadge.InnerText = "0";
                        }
                    }
                }
            }
        }

        // Logs the user out and redirects to the SignIn page
        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Clear the session
            Response.Redirect("SignIn.aspx"); // Redirect to SignIn page
        }
    }
}
