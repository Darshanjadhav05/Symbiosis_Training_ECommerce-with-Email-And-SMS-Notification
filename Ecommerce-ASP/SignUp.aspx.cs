using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Ecommerce_ASP
{
    public partial class SignUp : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void txtsignup_Click(object sender, EventArgs e)
        {
            string username = txtUname.Text.Trim();
            string password = txtPass.Text.Trim();
            string email = txtEmail.Text.Trim();
            string name = txtName.Text.Trim();


            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "INSERT INTO tblUsers (Username, Password, Email, Name, Usertype) VALUES (@Username, @Password, @Email, @Name, @Usertype)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Usertype", "User");

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Registration Successfully done";
                            lblMsg.ForeColor = System.Drawing.Color.Green;
                            clr();
                            Response.Redirect("~/SignIn.aspx");
                        }

                    }
                }
            }
            


            catch (Exception ex)
            {
                lblMsg.Text = $"An error occurred: {ex.Message}";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            }
        private void clr()
        {
            txtName.Text = string.Empty;
            txtPass.Text = string.Empty;
            txtUname.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtCPass.Text = string.Empty;
        }
        }

       

    }

