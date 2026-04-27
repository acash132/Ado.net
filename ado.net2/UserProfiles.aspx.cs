using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ado.net2
{
    public partial class UserProfiles : System.Web.UI.Page
    {
        string connStr = "Server=DESKTOP-B1PDELG;Initial Catalog=UserProfileDB;Trusted_Connection=true";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Populate the Day DropDown (1-31)
                for (int i = 1; i <= 31; i++)
                {
                    ddlDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                // 2. Populate the Year DropDown (e.g., 1950 to 2026)
                int currentYear = DateTime.Now.Year;
                for (int i = currentYear; i >= 1950; i--)
                {
                    ddlYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                // 3. Set to Current Date
                DateTime today = DateTime.Now;

                // Ensure the items exist before selecting
                if (ddlDay.Items.FindByValue(today.Day.ToString()) != null)
                    ddlDay.SelectedValue = today.Day.ToString();

                if (ddlMonth.Items.FindByValue(today.Month.ToString()) != null)
                    ddlMonth.SelectedValue = today.Month.ToString();

                if (ddlYear.Items.FindByValue(today.Year.ToString()) != null)
                    ddlYear.SelectedValue = today.Year.ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO UserProfiles 
                        (FirstName, LastName, Mobile, [Password], Gender, Email, Hobbies, DOB) 
                        VALUES (@FN, @LN, @Mob, @Pwd, @Gen, @Email, @Hobbies, @DOB)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // 1. Get Gender
                        string gender = rbMale.Checked ? "Male" : "Female";

                        // 2. Get Hobbies (Comma separated)
                        List<string> hobbiesList = new List<string>();
                        if (chkCricket.Checked) hobbiesList.Add("Cricket");
                        if (chkMusic.Checked) hobbiesList.Add("Music");
                        if (chkReading.Checked) hobbiesList.Add("Reading");
                        string hobbies = string.Join(", ", hobbiesList);

                        // 3. Format Date of Birth (YYYY-MM-DD)
                        string dob = $"{ddlYear.SelectedValue}-{ddlMonth.SelectedValue}-{ddlDay.SelectedValue}";

                        // 4. Add Parameters (Security best practice)
                        cmd.Parameters.AddWithValue("@FN", txtFirstName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LN", txtLastName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mob", txtMobile.Text.Trim());
                        cmd.Parameters.AddWithValue("@Pwd", txtPassword.Text); // In real apps, hash this!
                        cmd.Parameters.AddWithValue("@Gen", gender);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Hobbies", hobbies);
                        cmd.Parameters.AddWithValue("@DOB", dob);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            lblDisplay.Text = "Registration Successful!";
                            lblDisplay.ForeColor = System.Drawing.Color.Green;
                            ClearForm();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblDisplay.Text = "Error: " + ex.Message;
                lblDisplay.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblDisplay.Text = "Form cleared.";
            lblDisplay.ForeColor = System.Drawing.Color.Black;
        }

        private void ClearForm()
        {
            // Clear TextBoxes
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";

            // Reset CheckBoxes
            chkCricket.Checked = false;
            chkMusic.Checked = false;
            chkReading.Checked = false;

            // Reset RadioButtons
            rbMale.Checked = true;
            rbFemale.Checked = false;

            // Reset DropDowns to the first item ("Day", "Month", "Year")
            ddlDay.SelectedIndex = 0;
            ddlMonth.SelectedIndex = 0;
            ddlYear.SelectedIndex = 0;

            // IMPORTANT: Clear the GridView
            gvUserInfo.DataSource = null;
            gvUserInfo.DataBind();

            // Clear any password attributes set during Fetch
            txtPassword.Attributes.Remove("value");
            txtConfirmPassword.Attributes.Remove("value");
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Simple SELECT query without a WHERE clause to get everything
                    string query = "SELECT UserID, FirstName, LastName, Mobile, Email, Gender, Hobbies, DOB FROM UserProfiles ORDER BY UserID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gvUserInfo.DataSource = dt;
                            gvUserInfo.DataBind();
                            lblDisplay.Text = $"Showing {dt.Rows.Count} record(s).";
                            lblDisplay.ForeColor = System.Drawing.Color.Blue;
                        }
                        else
                        {
                            gvUserInfo.DataSource = null;
                            gvUserInfo.DataBind();
                            lblDisplay.Text = "No records found in the database.";
                            lblDisplay.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblDisplay.Text = "Error fetching records: " + ex.Message;
                lblDisplay.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnFetch_Click(object sender, EventArgs e)
        {
            string mobile = txtMobile.Text.Trim();
            if (string.IsNullOrEmpty(mobile)) return;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Query for the specific user
                string query = "SELECT * FROM UserProfiles WHERE Mobile = @Mob";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Mob", mobile);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    // 1. Show only this user in the GridView
                    gvUserInfo.DataSource = dt;
                    gvUserInfo.DataBind();

                    // 2. Populate form fields
                    DataRow row = dt.Rows[0];
                    txtFirstName.Text = row["FirstName"].ToString();
                    txtLastName.Text = row["LastName"].ToString();
                    txtEmail.Text = row["Email"].ToString();

                    // 3. Populate individual Radio Buttons
                    string gender = row["Gender"].ToString();
                    rbMale.Checked = (gender == "Male");
                    rbFemale.Checked = (gender == "Female");

                    lblDisplay.Text = "User found!";
                    lblDisplay.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    gvUserInfo.DataSource = null;
                    gvUserInfo.DataBind();
                    lblDisplay.Text = "No user found with that mobile number.";
                    lblDisplay.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        private string GetSelectedHobbies()
        {
            List<string> hobbiesList = new List<string>();
            if (chkCricket.Checked) hobbiesList.Add("Cricket");
            if (chkMusic.Checked) hobbiesList.Add("Music");
            if (chkReading.Checked) hobbiesList.Add("Reading");

            return string.Join(", ", hobbiesList);
        }

        // UPDATE
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"UPDATE UserProfiles SET 
                        FirstName=@FN, LastName=@LN, [Password]=@Pwd, 
                        Gender=@Gen, Email=@Email, Hobbies=@Hobbies, DOB=@DOB 
                        WHERE Mobile=@Mob";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Mob", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@FN", txtFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@LN", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@Pwd", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Gen", rbMale.Checked ? "Male" : "Female");
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Hobbies", GetSelectedHobbies());
                cmd.Parameters.AddWithValue("@DOB", $"{ddlYear.SelectedValue}-{ddlMonth.SelectedValue}-{ddlDay.SelectedValue}");

                con.Open();
                int rows = cmd.ExecuteNonQuery();
                lblDisplay.Text = (rows > 0) ? "Update Successful!" : "Update Failed.";
                lblDisplay.ForeColor = (rows > 0) ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            }
        }
        protected void cvGender_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if either radio button is checked
            args.IsValid = rbMale.Checked || rbFemale.Checked;
        }
        protected void cvEmailUnique_ServerValidate(object source, ServerValidateEventArgs args)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Check if email exists (excluding the current user if updating)
                string query = "SELECT COUNT(*) FROM UserProfiles WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", args.Value);

                con.Open();
                int count = (int)cmd.ExecuteScalar();

                // If count > 0, email is not unique, so validation fails
                args.IsValid = (count == 0);
            }
        }
        // DELETE
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM UserProfiles WHERE Mobile = @Mob";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Mob", txtMobile.Text.Trim());

                con.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblDisplay.Text = "User deleted.";
                    ClearForm();
                }
                else
                {
                    lblDisplay.Text = "Mobile number not found.";
                }
            }
        }

    }
}
