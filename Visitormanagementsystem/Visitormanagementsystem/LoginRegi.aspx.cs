using System;
using MySql.Data.MySqlClient;
using System.Configuration;
 

namespace Visitormanagementsystem
{
    public partial class LoginRegi : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                string query = "SELECT * FROM Users WHERE Email=@email AND PasswordHash=@pass";
                MySqlCommand cmd = new MySqlCommand(query, con);

                cmd.Parameters.AddWithValue("@email", txtLoginEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@pass", txtLoginPass.Text.Trim());

                MySqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    string role = dr["Role"].ToString().Trim();

                    Session["user"] = dr["FullName"].ToString();
                    Session["role"] = role;

                    
                    lblLoginMsg.Text = "Role: " + role;

                    if (role == "Admin")
                    {
                        Response.Redirect("Dashborad.aspx");
                    }
                    else if (role == "Receptionist")
                    {
                        Response.Redirect("ReceptionDashboard.aspx");
                    }
                    else
                    {
                        lblLoginMsg.Text = "Role not recognized!";
                    }
                }
                else
                {
                    lblLoginMsg.Text = "Invalid Email or Password!";
                }
            }

        }

        
    }
}