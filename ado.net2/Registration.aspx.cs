using System;
using System.Collections.Generic;
using System.Data;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid(txtSearch.Text.Trim());
        }

        private void BindGrid(string searchTerm = "")
        {
            using (SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=RegisterDB;Trusted_Connection=true"))
            {
                // Use LIKE with wildcards for flexible searching
                string query = "SELECT Username, FullName, Email, Mobile FROM Register1data";

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    query += " WHERE Username LIKE @search OR Email LIKE @search";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }
    }

        
    
}
