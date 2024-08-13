using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce_ASP
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                // Retrieve and populate username and password from cookies if they exist
                if (Request.Cookies["UNAME"] != null && Request.Cookies["UPWD"] != null)
                {

                    txtUsername.Text = Request.Cookies["UNAME"].Value;
                    txtPass.Text = Request.Cookies["UPWD"].Value;
                    CheckBox1.Checked = true;
                }
              
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPass.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both username and password.";
                lblError.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Database connection and login logic
            string connectionString = ConfigurationManager.ConnectionStrings["EcommerceConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "SELECT * FROM tblUsers WHERE Username = @username AND Password = @pwd";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@pwd", password);

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // Set session variables
                                DataRow row = dt.Rows[0];
                                Session["USERID"] = row["Uid"].ToString();
                                Session["USEREMAIL"] = row["Email"].ToString();

                                // Manage cookies for username and password
                                if (CheckBox1.Checked)
                                {
                                    Response.Cookies["UNAME"].Value = username;
                                    Response.Cookies["UPWD"].Value = password;
                                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(10);
                                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(10);
                                }
                                else
                                {
                                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);
                                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);
                                }

                                // Redirect based on user type
                                string userType = row["Usertype"].ToString().Trim();
                                Session["Username"] = username;
                                if (userType == "User")
                                {
                                    Session["getFullName"] = row["Name"].ToString();
                                    Session["LoginType"] = "User";
                                    Response.Redirect("Dashboard.aspx?UserLogin=YES");
                                    
                                }
                                            
                            }
                            else
                            {
                                lblError.Text = "Invalid Username or Password.";
                                lblError.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = $"An error occurred: {ex.Message}";
                lblError.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                clr();
            }
        }

        private void clr()
        {
            txtPass.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtUsername.Focus();
        }
    }
}