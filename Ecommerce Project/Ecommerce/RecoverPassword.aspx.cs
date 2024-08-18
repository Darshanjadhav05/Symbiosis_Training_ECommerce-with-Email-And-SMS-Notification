using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class RecoverPassword : System.Web.UI.Page
    {
        String GUIDvalue; // Variable to hold the GUID value from query string
        int Uid; // Variable to hold user ID
        DataTable dt = new DataTable(); // DataTable to hold result from database
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString; // Connection string from configuration

        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
            {
                GUIDvalue = Request.QueryString["id"]; // Get GUID value from query string

                if (GUIDvalue != null) // Check if GUID value is present
                {
                    SqlCommand cmd = new SqlCommand("Select * from ForgotPass where Id=@Id", con); // Create SQL command to check if GUID exists
                    con.Open(); // Open the connection
                    cmd.Parameters.AddWithValue("@Id", GUIDvalue); // Add parameter for GUID
                    SqlDataAdapter sda = new SqlDataAdapter(cmd); // Create data adapter

                    sda.Fill(dt); // Fill DataTable with result
                    if (dt.Rows.Count != 0) // Check if GUID is valid
                    {
                        Uid = Convert.ToInt32(dt.Rows[0][1]); // Get user ID from result
                    }
                    else
                    {
                        lblmsg.Text = "Your Password Reset Link is Expired or Invalid...try again"; // Display error message
                        lblmsg.ForeColor = System.Drawing.Color.Red; // Set text color to red
                    }
                }
                else
                {
                    Response.Redirect("~/HomePage.aspx"); // Redirect to HomePage if GUID is not present
                }
            }

            if (!IsPostBack) // Check if the page is not being posted back
            {
                if (dt.Rows.Count != 0) // Check if GUID is valid
                {
                    txtConfirmPass.Visible = true; // Show confirm password textbox
                    txtNewPass.Visible = true; // Show new password textbox
                    lblNewPassword.Visible = true; // Show new password label
                    lblConfirmPass.Visible = true; // Show confirm password label
                    btnResetPass.Visible = true; // Show reset password button
                }
                else
                {
                    lblmsg.Text = "Your Password Reset Link is Expired or Invalid...try again"; // Display error message
                    lblmsg.ForeColor = System.Drawing.Color.Red; // Set text color to red
                }
            }
        }

        protected void btnResetPass_Click(object sender, EventArgs e)
        {
            // Check if new password and confirm password are not empty and match
            if (txtNewPass.Text != "" && txtConfirmPass.Text != "" && txtNewPass.Text == txtConfirmPass.Text)
            {
                using (SqlConnection con = new SqlConnection(connectionString)) // Open database connection
                {
                    con.Open(); // Open the connection
                    SqlCommand cmd = new SqlCommand("Update tblUsers set Password=@p where Uid=@Uid", con); // Create SQL command to update user password
                    cmd.Parameters.AddWithValue("@p", txtNewPass.Text); // Add parameter for new password
                    cmd.Parameters.AddWithValue("@Uid", Uid); // Add parameter for user ID
                    cmd.ExecuteNonQuery(); // Execute the command

                    SqlCommand cmd2 = new SqlCommand("delete from ForgotPass where Uid='" + Uid + "'", con); // Create SQL command to delete GUID from ForgotPass table
                    cmd2.ExecuteNonQuery(); // Execute the command
                    Response.Write("<script> alert('Password Reset Successfully done');  </script>"); // Display success message
                    Response.Redirect("~/SignIn.aspx"); // Redirect to Sign-In page
                }
            }
        }
    }
}
