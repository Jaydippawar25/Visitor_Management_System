using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Data;

namespace Visitormanagementsystem
{
    public partial class ReceptionViewVisitors : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        
            if (Session["role"] == null || Session["role"].ToString() != "Receptionist")
            {
                Response.Redirect("LoginRegi.aspx");
                return;
            }

            lblAdmin.Text = Session["user"].ToString();

            if (!IsPostBack)
                LoadData();
        }
 
        void LoadData()
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                string q = @"SELECT v.VisitID, vi.FullName, vi.PhoneNumber,
                             v.Purpose, v.Status, v.WhomToMeet,
                             v.CheckInTime, v.CheckOutTime
                             FROM Visits v
                             JOIN Visitors vi ON v.VisitorID = vi.VisitorID
                             ORDER BY v.VisitID ASC";

                MySqlDataAdapter da = new MySqlDataAdapter(q, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

      
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(GridView1.DataKeys[index].Value);

            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                
                string statusQuery = "SELECT Status FROM Visits WHERE VisitID=@id";
                MySqlCommand checkCmd = new MySqlCommand(statusQuery, con);
                checkCmd.Parameters.AddWithValue("@id", id);
                string status = checkCmd.ExecuteScalar().ToString();

                
                if (status == "Pending" || status == "Rejected")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "msg", "alert('Action not allowed for Pending or Rejected visitor!');", true);
                    return;
                }

                if (e.CommandName == "Checkout")
                {
                    string q = @"UPDATE Visits 
                                 SET Status='Checked Out', CheckOutTime = NOW() 
                                 WHERE VisitID=@id";

                    MySqlCommand cmd = new MySqlCommand(q, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "msg", "alert('Visitor Checked Out!');", true);

                    LoadData();
                }
                else if (e.CommandName == "Print")
                {
                    Response.Redirect("PrintPass.aspx?id=" + id);
                }
            }
        }

        
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();
                object checkoutTime = DataBinder.Eval(e.Row.DataItem, "CheckOutTime");

                Button btnCheckout = (Button)e.Row.FindControl("btnCheckout");
                Button btnPrint = (Button)e.Row.FindControl("btnPrint");


                if (status == "Approved")
                {
                    e.Row.Cells[7].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[7].Font.Bold = true;
                }
                else if (status == "Rejected")
                {
                    e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;
                    e.Row.Cells[7].Font.Bold = true;
                }
                else if (status == "Pending")
                {
                    e.Row.Cells[7].ForeColor = System.Drawing.Color.Orange;
                    e.Row.Cells[7].Font.Bold = true;
                }
                else if (status == "Checked Out")
                {
                    e.Row.Cells[7].ForeColor = System.Drawing.Color.Blue;
                    e.Row.Cells[7].Font.Bold = true;
                }

                 
                if (status == "Pending" || status == "Rejected")
                {
                    if (btnCheckout != null)
                    {
                        btnCheckout.Enabled = false;
                        btnCheckout.BackColor = System.Drawing.Color.Gray;
                        btnCheckout.ForeColor = System.Drawing.Color.White;
                    }

                    if (btnPrint != null)
                    {
                        btnPrint.Enabled = false;
                        btnPrint.BackColor = System.Drawing.Color.Gray;
                        btnPrint.ForeColor = System.Drawing.Color.White;
                    }
                }

                
                if (checkoutTime != DBNull.Value)
                {
                    if (btnCheckout != null)
                    {
                        btnCheckout.Text = "Done";
                        btnCheckout.Enabled = false;
                        btnCheckout.BackColor = System.Drawing.Color.Gray;
                        btnCheckout.ForeColor = System.Drawing.Color.White;
                    }

                    if (btnPrint != null)
                    {
                        btnPrint.Enabled = true;
                    }
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");
        }
    }
}