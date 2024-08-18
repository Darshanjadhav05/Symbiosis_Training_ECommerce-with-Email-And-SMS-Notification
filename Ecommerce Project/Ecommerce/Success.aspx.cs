using System;
using System.Web.UI;

namespace Ecommerce
{
    public partial class Success : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Page Load event - no specific logic required here
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Redirect to the Dashboard page when Button1 is clicked
            Response.Redirect("Dashboard.aspx");
        }
    }
}
