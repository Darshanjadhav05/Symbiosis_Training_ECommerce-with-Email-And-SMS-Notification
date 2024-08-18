using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ecommerce
{
    public partial class SignUp : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page Load event - no specific logic required here
        }

        protected void txtsignup_Click(object sender, EventArgs e)
        {
            // Retrieve and trim user input
            string username = txtUname.Text.Trim();
            string password = txtPass.Text.Trim();
            string email = txtEmail.Text.Trim();
            string name = txtName.Text.Trim();

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open(); // Open database connection
                    // SQL query to insert new user into tblUsers table
                    string query = "INSERT INTO tblUsers (Username, Password, Email, Name, Usertype) VALUES (@Username, @Password, @Email, @Name, @Usertype)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add parameters to SQL command to prevent SQL injection
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Usertype", "User"); // Set default user type

                        int rowsAffected = cmd.ExecuteNonQuery(); // Execute the query

                        if (rowsAffected > 0) // Check if the insertion was successful
                        {
                            lblMsg.Text = "Registration Successfully done"; // Display success message
                            lblMsg.ForeColor = System.Drawing.Color.Green; // Set success message color
                            clr(); // Clear input fields
                            Response.Redirect("~/SignIn.aspx"); // Redirect to SignIn page
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = $"An error occurred: {ex.Message}"; // Display error message
                lblMsg.ForeColor = System.Drawing.Color.Red; // Set error message color
            }
        }

        private void clr()
        {
            // Clear all input fields
            txtName.Text = string.Empty;
            txtPass.Text = string.Empty;
            txtUname.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtCPass.Text = string.Empty;
        }
    }
}
