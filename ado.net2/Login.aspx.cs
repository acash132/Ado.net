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
            if (!IsPostBack)
            {
                BindGrid();
            }

        }

        private void BindGrid()
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            SqlDataAdapter da = new SqlDataAdapter("select * from UsersData1 order by Username Desc", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            grdData.DataSource = ds;
            grdData.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            SqlCommand cmd = new SqlCommand("insert into UsersData1 values('" + txtUsername.Text + "','" + txtPassword.Text + "')", con);
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
            SqlCommand cmd = new SqlCommand("update UsersData1 set Password='" + txtPassword.Text + "' where Username='" + txtUsername.Text + "'", con);
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
            SqlCommand cmd = new SqlCommand("delete from UsersData1  where Username='" + txtUsername.Text + "'", con);
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
                string query = "SELECT * FROM UsersData1 WHERE Username LIKE @SearchTerm ORDER BY Username DESC";

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

        protected void grdData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdData.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void grdData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdData.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void grdData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdData.EditIndex = -1;
            BindGrid();

        }

        protected void grdData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            GridViewRow grd = grdData.Rows[e.RowIndex];
            int UID = Convert.ToInt32(grdData.DataKeys[e.RowIndex].Value);
            string Username = ((TextBox)grd.FindControl("txtUsername")).Text;
            string Password = ((TextBox)grd.FindControl("txtPassword")).Text;
            SqlCommand cmd = new SqlCommand("update Usersdata1 set Username=@Username," + "Password=@Password where UID=@UID", con);
            cmd.Parameters.AddWithValue("@Username", Username);
            cmd.Parameters.AddWithValue("@Password", Password);
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.ExecuteNonQuery();
            con.Close();
            BindGrid();



        }

        protected void grdData_RowDeleting(object sender, GridViewDeleteEventArgs e) {

            SqlConnection con = new SqlConnection("Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true");
            con.Open();
            GridViewRow grd = grdData.Rows[e.RowIndex];
            int UID = Convert.ToInt32(grdData.DataKeys[e.RowIndex].Value);
            
            SqlCommand cmd = new SqlCommand("DELETE FROM UsersData1 WHERE UID = @UID", con);
            
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.ExecuteNonQuery();
            con.Close();
            BindGrid();


        }




        
        
        //protected void grdData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    // 1. Get the UID from the DataKeys collection using the row index
        //    // Note: This requires DataKeyNames="UID" in your ASPX GridView definition

        //    //int uid = Convert.ToInt32(grdData.DataKeys[e.RowIndex].Value);

        //    // 2. Define your connection string
        //    string connectionString = "Server=DESKTOP-B1PDELG;Initial Catalog=UsersDB;Trusted_Connection=true";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        // 3. Create the DELETE command with a parameter to prevent SQL Injection
        //        string query = "DELETE FROM UsersData1 WHERE UID = @UID";

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddWithValue("@UID", uid);

        //            // 4. Open connection, execute, and close
        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //            con.Close();
        //        }
        //    }

        //    // 5. Refresh the GridView to reflect the changes
        //    BindGrid();
        //}
    }
}