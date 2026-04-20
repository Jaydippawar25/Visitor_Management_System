using System;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace Visitormanagementsystem
{
    public partial class PrintPass : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (string.IsNullOrEmpty(id))
                {
                    Response.Write("Invalid ID");
                    return;
                }

                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    con.Open();

                    string q = @"SELECT vi.FullName, vi.PhoneNumber,
                                 v.Purpose, v.WhomToMeet,
                                 v.CheckInTime, v.CheckOutTime, v.Status
                                 FROM Visits v
                                 INNER JOIN Visitors vi ON v.VisitorID = vi.VisitorID
                                 WHERE v.VisitID=@id";

                    MySqlCommand cmd = new MySqlCommand(q, con);
                    cmd.Parameters.AddWithValue("@id", id);

                    MySqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        lblName.Text = dr["FullName"].ToString();
                        lblPhone.Text = dr["PhoneNumber"].ToString();
                        lblPurpose.Text = dr["Purpose"].ToString();
                        lblMeet.Text = dr["WhomToMeet"].ToString();

                        lblIn.Text = Convert.ToDateTime(dr["CheckInTime"]).ToString("dd-MM-yyyy HH:mm");

                        if (dr["CheckOutTime"] != DBNull.Value)
                            lblOut.Text = Convert.ToDateTime(dr["CheckOutTime"]).ToString("dd-MM-yyyy HH:mm");
                        else
                            lblOut.Text = "Not Yet";

                        lblStatus.Text = dr["Status"].ToString();
                    }
                }
            }
        }
    }
}