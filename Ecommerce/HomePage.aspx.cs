using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace Ecommerce
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label2.Text = $"Welcome {Session["username"]}";
                if (Session["total"] != null)
                {
                    lbltotal.Text = Session["total"].ToString();
                    LoadItemsFromSession();
                }
            }
        }

      
        protected void AddToCartButton1_Click(object sender, EventArgs e)
        {
            AddItemToCart(ProductName1.Text, Convert.ToInt32(Price1.Text), 1);
        }

        protected void AddToCartButton2_Click(object sender, EventArgs e)
        {
            AddItemToCart(ProductName2.Text, Convert.ToInt32(Price2.Text), 1);
        }

        protected void AddToCartButton3_Click(object sender, EventArgs e)
        {
            AddItemToCart(ProductName3.Text, Convert.ToInt32(Price3.Text), 1);
        }

        protected void AddItemToCart(string productName, int price, int quantity)
        {
            int totalPrice = price * quantity;
            bool itemExists = false;

            for (int i = 0; i < ListBox1.Items.Count; i++)
            {
                string item = ListBox1.Items[i].Text;
                string[] parts = item.Split('=', 'x');

                if (parts.Length == 3)
                {
                    string existingProductName = parts[0].Trim();
                    int existingQuantity = Convert.ToInt32(parts[1].Trim());
                    int existingPrice = Convert.ToInt32(parts[2].Trim());

                    if (existingProductName == productName)
                    {
                        existingQuantity += quantity; 
                        totalPrice = existingPrice * existingQuantity;
                        ListBox1.Items[i].Text = $"{existingProductName} x {existingQuantity} = {totalPrice}"; 
                        itemExists = true;
                        break;
                    }
                }
            }

            if (!itemExists)
            {
                ListBox1.Items.Add($"{productName} x {quantity} = {totalPrice}");
            }

            SaveItemsToSession();
            UpdateTotal();
        }

        private void UpdateTotal()
        {
            int total = 0;
            foreach (ListItem item in ListBox1.Items)
            {
                string[] parts = item.Text.Split('=');
                if (parts.Length > 1)
                {
                    total += Convert.ToInt32(parts[1].Trim());
                }
            }

            Session["total"] = total;
            lbltotal.Text = "Total: Rs. " + total.ToString();
        }

        private void SaveItemsToSession()
        {
            List<string> items = new List<string>();
            foreach (ListItem item in ListBox1.Items)
            {
                items.Add(item.Text);
            }
            Session["ListBoxItems"] = items;
        }

        private void LoadItemsFromSession()
        {
            if (Session["ListBoxItems"] != null)
            {
                List<string> items = (List<string>)Session["ListBoxItems"];
                foreach (string item in items)
                {
                    ListBox1.Items.Add(item);
                }
            }
        }

        protected void Button8_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderPlace.aspx");

        }
    }
}
