using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class OrderPlace : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
          
                if (Session["username"] != null)
                {
                    LabelUsername.Text = Session["username"].ToString();
                }

                if (Session["ListBoxItems"] != null)
                {
                    
                    List<string> items = (List<string>)Session["ListBoxItems"];
                    foreach (string item in items)
                    {
                        ListBoxOrder.Items.Add(item);
                    }
                }

              
                if (Session["total"] != null)
                {
                    LabelTotal.Text = Session["total"].ToString();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}