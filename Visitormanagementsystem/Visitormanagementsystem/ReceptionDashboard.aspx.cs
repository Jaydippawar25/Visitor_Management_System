using System;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace Visitormanagementsystem
{
    public partial class ReceptionDashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "Receptionist")
            {
                Response.Redirect("LoginRegi.aspx");
                return;
            }

            lblUser.Text = Session["user"].ToString();

            if (!IsPostBack)
            {
                LoadCounts();
            }
        }

        void LoadCounts()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

               
                string totalQuery = "SELECT COUNT(*) FROM Visits";
                MySqlCommand cmd1 = new MySqlCommand(totalQuery, con);
                lblTotal.Text = cmd1.ExecuteScalar().ToString();

                 
                string todayQuery = "SELECT COUNT(*) FROM Visits WHERE DATE(CheckInTime)=CURDATE()";
                MySqlCommand cmd2 = new MySqlCommand(todayQuery, con);
                lblToday.Text = cmd2.ExecuteScalar().ToString();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");
        }
    }
}