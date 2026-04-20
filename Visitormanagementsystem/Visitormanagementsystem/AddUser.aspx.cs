using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;


namespace Visitormanagementsystem
{
    public partial class AddUser : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["role"] == null || Session["role"].ToString() != "Admin")
            {
                Response.Redirect("LoginRegi.aspx");
            }

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                string q = "INSERT INTO Users(FullName, Email, PasswordHash, Role) VALUES(@n,@e,@p,@r)";
                MySqlCommand cmd = new MySqlCommand(q, con);

                cmd.Parameters.AddWithValue("@n", txtName.Text);
                cmd.Parameters.AddWithValue("@e", txtEmail.Text);
                cmd.Parameters.AddWithValue("@p", txtPass.Text);
                cmd.Parameters.AddWithValue("@r", ddlRole.Text);

                cmd.ExecuteNonQuery();

                lblMsg.Text="User Added Successfully!";
                lblTest.Text = Session["role"]?.ToString();
            }

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashborad.aspx");
        }
    }
}