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
    public partial class Dashborad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "Admin")
            {
                Response.Redirect("LoginRegi.aspx");
            }
            else
            {
                lblAdmin.Text = Session["user"].ToString();

                if (!IsPostBack)
                {
                    LoadStats();  
                }
            }
        }
        void LoadStats()
        {
            string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;

            using (MySqlConnection con =new MySqlConnection(cs))
            {
                con.Open();

                MySqlCommand cmd1 = new MySqlCommand("SELECT COUNT(*) FROM Visitors", con);
                lblTotal.Text = cmd1.ExecuteScalar().ToString();

                MySqlCommand cmd2 = new MySqlCommand("SELECT COUNT(*) FROM Visits WHERE DATE(CheckInTime)=CURDATE()", con);
                lblToday.Text = cmd2.ExecuteScalar().ToString();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");
        }
    }
}