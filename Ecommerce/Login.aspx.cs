using MySql.Data.MySqlClient;
using Org.BouncyCastle.Pqc.Crypto.Cmce;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (MySqlConnection conn = new MySqlConnection("Data Source=localhost;Database=EcommerceDB;User ID=root;Password=DJ@3522003"))
            {
                
                string query = "SELECT Password FROM Users WHERE Username = @Username";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);


                try
                {
                    conn.Open();
                    MySqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        string storedPassword = dr["Password"].ToString();
                        if (storedPassword.Equals(txtPassword.Text)) {
                            Session["username"] = txtUsername.Text;
                                Response.Redirect("HomePage.aspx");

                        }
                        else
                        {
                            Label1.Text = "Invalid Credincial";
                        }

                    }

                    conn.Close();
                }
                catch (Exception ex)
                {
                    Label1.Text = ex.Message;
                }


            }
           

           
        }
    }
}