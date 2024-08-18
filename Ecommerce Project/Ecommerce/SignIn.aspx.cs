using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Check if the page is not being posted back
            {
                // Retrieve and populate username and password from cookies if they exist
                if (Request.Cookies["UNAME"] != null && Request.Cookies["UPWD"] != null)
                {
                    txtUsername.Text = Request.Cookies["UNAME"].Value; // Set username text box value from cookie
                    txtPass.Text = Request.Cookies["UPWD"].Value; // Set password text box value from cookie
                    CheckBox1.Checked = true; // Check the remember me checkbox
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim(); // Get and trim username input
            string password = txtPass.Text.Trim(); // Get and trim password input

            // Validate input
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both username and password."; // Display error message
                lblError.ForeColor = System.Drawing.Color.Red; // Set error message color
                return; // Exit method if validation fails
            }

            // Database connection and login logic
            string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open(); // Open database connection
                    string query = "SELECT * FROM tblUsers WHERE Username = @username AND Password = @pwd"; // SQL query to select user

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@username", username); // Add parameter for username
                        cmd.Parameters.AddWithValue("@pwd", password); // Add parameter for password

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable(); // DataTable to hold query result
                            sda.Fill(dt); // Fill DataTable with result

                            if (dt.Rows.Count > 0) // Check if user exists
                            {
                                // Set session variables
                                DataRow row = dt.Rows[0];
                                Session["USERID"] = row["Uid"].ToString(); // Store user ID in session
                                Session["USEREMAIL"] = row["Email"].ToString(); // Store user email in session

                                // Manage cookies for username and password
                                if (CheckBox1.Checked) // Check if remember me is checked
                                {
                                    Response.Cookies["UNAME"].Value = username; // Set username cookie value
                                    Response.Cookies["UPWD"].Value = password; // Set password cookie value
                                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(10); // Set expiration for username cookie
                                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(10); // Set expiration for password cookie
                                }
                                else
                                {
                                    // Expire cookies if remember me is not checked
                                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);
                                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);
                                }

                                // Redirect based on user type
                                string userType = row["Usertype"].ToString().Trim(); // Get user type
                                Session["Username"] = username; // Store username in session
                                if (userType == "User") // Check if user type is "User"
                                {
                                    Session["getFullName"] = row["Name"].ToString(); // Store full name in session
                                    Session["LoginType"] = "User"; // Set login type in session
                                    Response.Redirect("Dashboard.aspx?UserLogin=YES"); // Redirect to dashboard
                                }
                            }
                            else
                            {
                                lblError.Text = "Invalid Username or Password."; // Display error message
                                lblError.ForeColor = System.Drawing.Color.Red; // Set error message color
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = $"An error occurred: {ex.Message}"; // Display error message
                lblError.ForeColor = System.Drawing.Color.Red; // Set error message color
            }
            finally
            {
                clr(); // Clear input fields
            }
        }

        private void clr()
        {
            txtPass.Text = string.Empty; // Clear password text box
            txtUsername.Text = string.Empty; // Clear username text box
            txtUsername.Focus(); // Set focus to username text box
        }
    }
}
