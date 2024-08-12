using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
namespace Ecommerce
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void btnSubmit_Click1(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection("Data Source=localhost;Database=EcommerceDB;User ID=root;Password=DJ@3522003"))
            {
                string query = "INSERT INTO Users (Username, Password, Email, Gender, DateOfBirth, City) VALUES (@Username, @Password, @Email, @Gender, @DateOfBirth, @City)";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Email", txtMail.Text);
                cmd.Parameters.AddWithValue("@Gender", rbMale.Checked ? "Male" : (rbFemale.Checked ? "Female" : ""));
                cmd.Parameters.AddWithValue("@DateOfBirth", txtDOB.Text);
                cmd.Parameters.AddWithValue("@City", ddlCity.SelectedValue);

                try
                {
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    Response.Redirect("Login.aspx");
                    conn.Close();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }


            }

            }
    }
}