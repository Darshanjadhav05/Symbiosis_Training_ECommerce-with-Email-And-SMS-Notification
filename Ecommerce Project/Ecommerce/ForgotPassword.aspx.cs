using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        // Connection string to the database, retrieved from web.config
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

        // Method triggered when the page loads
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Method triggered when the "Reset Password" button is clicked
        protected void btnResetPass_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open(); // Open the database connection
                // SQL command to select the user record based on the provided email
                SqlCommand cmd = new SqlCommand("Select * from tblUsers where Email=@Email", con);
                cmd.Parameters.AddWithValue("@Email", txtEmailID.Text); // Add the email parameter to the command
                SqlDataAdapter sda = new SqlDataAdapter(cmd); // Adapter to execute the command
                DataTable dt = new DataTable(); // DataTable to hold the result
                sda.Fill(dt); // Fill the DataTable with the query result

                if (dt.Rows.Count != 0) // Check if the email exists in the database
                {
                    String myGUID = Guid.NewGuid().ToString(); // Generate a unique GUID for password reset
                    int Uid = Convert.ToInt32(dt.Rows[0][0]); // Get the user ID from the query result

                    // Insert the reset request into the ForgotPass table
                    SqlCommand cmd1 = new SqlCommand("Insert into ForgotPass(Id,Uid,RequestDateTime) values('" + myGUID + "','" + Uid + "',GETDATE())", con);
                    cmd1.ExecuteNonQuery(); // Execute the insert command

                    String ToEmailAddress = dt.Rows[0][3].ToString(); // Get the user's email address
                    String Username = dt.Rows[0][1].ToString(); // Get the user's username
                    // Create the email body with a link to reset the password
                    String EmailBody = "Hi ," + Username + ",<br/><br/>Click the link below to reset your password<br/> <br/> https://localhost:44302/RecoverPassword.aspx?id=" + myGUID;

                    // Create a new email message
                    MailMessage PassRecMail = new MailMessage("darshanmjadhav5@gmail.com", ToEmailAddress);

                    PassRecMail.Body = EmailBody; // Set the email body
                    PassRecMail.IsBodyHtml = true; // Set the body format to HTML
                    PassRecMail.Subject = "Reset Password"; // Set the email subject

                    using (SmtpClient client = new SmtpClient())
                    {
                        client.EnableSsl = true; // Enable SSL
                        client.UseDefaultCredentials = false; // Do not use default credentials
                        // Set the sender's email credentials
                        client.Credentials = new NetworkCredential("darshanmjadhav5@gmail.com", "zqbn lmfs grqy corh");
                        client.Host = "smtp.gmail.com"; // Set the SMTP server
                        client.Port = 587; // Set the SMTP port
                        client.DeliveryMethod = SmtpDeliveryMethod.Network; // Set the delivery method

                        client.Send(PassRecMail); // Send the email
                    }

                    // Display a success message
                    lblResetPassMsg.Text = "Reset Link sent! Check your email for reset password";
                    lblResetPassMsg.ForeColor = System.Drawing.Color.Green;
                    txtEmailID.Text = string.Empty; // Clear the email input field
                }
                else
                {
                    // Display an error message if the email does not exist in the database
                    lblResetPassMsg.Text = "Oops! This Email Does not Exist...Try again";
                    lblResetPassMsg.ForeColor = System.Drawing.Color.Red;
                    txtEmailID.Text = string.Empty; // Clear the email input field
                    txtEmailID.Focus(); // Set focus back to the email input field
                }
            }
        }
    }
}
