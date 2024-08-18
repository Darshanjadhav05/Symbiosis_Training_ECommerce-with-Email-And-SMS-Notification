using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class HomePage : System.Web.UI.Page
    {
        // Method triggered when the page loads
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is redirected after login
            if (Request.QueryString["UserLogin"] == "YES")
            {
                // Redirect to the user home page if logged in
                Response.Redirect("UserHome.aspx?UserLogin=YES");
            }

            // Check if a user session exists
            if (Session["Username"] != null)
            {
                // Check if the page is not a postback (first-time load)
                if (!this.IsPostBack)
                {
                    // Hide the Sign Up and Sign In buttons
                    btnSignUP.Visible = false;
                    btnSignIN.Visible = false;
                    // Show the Logout button
                    btnlogout.Visible = true;
                }
            }
            else
            {
                // If no session exists, show Sign Up and Sign In buttons
                btnSignUP.Visible = true;
                btnSignIN.Visible = true;
                // Hide the Logout button
                btnlogout.Visible = false;
            }
        }

        // Method triggered when the logout button is clicked
        protected void btnlogout_Click(object sender, EventArgs e)
        {
            Session["Username"] = null; // Clear the username session
            Session.RemoveAll(); // Remove all session data
            Response.Redirect("HomePage.aspx"); // Redirect to the homepage
        }
    }
}
