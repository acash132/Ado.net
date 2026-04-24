using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ado.net2
{
    public partial class ADO1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void BindGrid()
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            SqlDataAdapter da = new SqlDataAdapter("select * from UsersData order by Username Desc", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            grdData.DataSource = ds;
            grdData.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            SqlCommand cmd = new SqlCommand("insert into UsersData values('" + txtUsername.Text + "','" + txtPassword.Text + "')", con);
            cmd.ExecuteNonQuery();
            txtUsername.Text = "";
            txtPassword.Text = "";
            BindGrid();
            con.Close();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            SqlCommand cmd = new SqlCommand("update UsersData set Password='" + txtPassword.Text + "' where Username='" + txtUsername.Text + "'", con);
            cmd.ExecuteNonQuery();
            txtUsername.Text = "";
            txtPassword.Text = "";
            BindGrid();
            con.Close();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            SqlCommand cmd = new SqlCommand("delete from UsersData  where Username='" + txtUsername.Text + "'", con);
            cmd.ExecuteNonQuery();
            txtUsername.Text = "";
            txtPassword.Text = "";
            BindGrid();
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string connectionString = "Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Using LIKE with wildcard % allows for partial matches
                string query = "SELECT * FROM UsersData WHERE Username LIKE @SearchTerm ORDER BY Username DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Using Parameters prevents SQL Injection
                    cmd.Parameters.AddWithValue("@SearchTerm", "%" + txtSearch.Text.Trim() + "%");

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    grdData.DataSource = ds;
                    grdData.DataBind();
                }
            }
        }


    }
}