using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ado.net2
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=RegisterDB;Trusted_Connection=true");
            con.Open();
            string query = "INSERT INTO Register1data (FullName, Email, Username, Password,Mobile) " +
                                   "VALUES (@FullName, @Email, @Username, @Password,@Mobile)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@FullName", txtfn.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
            cmd.ExecuteNonQuery();
            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Registration successful!";
            ClearForm();
            con.Close();

        }
        private void ClearForm()
        {
            txtfn.Text = txtEmail.Text = txtUsername.Text = txtPassword.Text = txtMobile.Text = "";
        }
   }

        
    
}
