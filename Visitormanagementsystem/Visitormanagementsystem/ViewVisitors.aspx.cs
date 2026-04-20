using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Data;



namespace Visitormanagementsystem
{
    public partial class ViewVisitors : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null)
            {
                Response.Redirect("LoginRegi.aspx");
            }
            else
            {
                lblAdmin.Text = Session["user"].ToString();

                if (!IsPostBack)
                {
                    LoadData();
                }
            }

        }
        void LoadData()
        {
            using(MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT v.VisitID, vi.FullName, vi.PhoneNumber,
                               v.Purpose, v.WhomToMeet, v.Status,
                               v.CheckInTime, v.CheckOutTime
                               FROM Visits v
                               INNER JOIN Visitors vi ON v.VisitorID = vi.VisitorID
                               ORDER BY v.VisitID ASC";

                MySqlDataAdapter da = new MySqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();

            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int visitId = Convert.ToInt32(GridView1.DataKeys[index].Value);

            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

                string query = "";
                string message = "";

                if (e.CommandName == "Approve")
                {
                    query = "UPDATE Visits SET Status='Approved' WHERE VisitID=@id";
                    message = "Visitor Approved!";
                }
                else if (e.CommandName == "Reject")
                {
                    query = "UPDATE Visits SET Status='Rejected' WHERE VisitID=@id";
                    message = "Visitor Rejected!";
                }
                else if (e.CommandName == "Checkout")
                {
                    query = "UPDATE Visits SET Status='Checked Out', CheckOutTime = NOW() WHERE VisitID=@id";
                    message = "Visitor Checked Out!";
                }
                else if (e.CommandName == "Print")
                {
                    Response.Redirect("PrintPass.aspx?id=" + visitId);
                    return;
                }

                if (query != "")
                {
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", visitId);
                    cmd.ExecuteNonQuery();

                     
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "msg", "alert('" + message + "');", true);
                }
            }

            LoadData();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();
                object checkoutObj = DataBinder.Eval(e.Row.DataItem, "CheckOutTime");

                
                if (status == "Approved")
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Green;
                else if (status == "Rejected")
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                else if (status == "Checked Out")
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Blue;
                else
                    e.Row.Cells[5].ForeColor = System.Drawing.Color.Orange;

                 
                Button btnCheckout = e.Row.FindControl("btnCheckout") as Button;
                Button btnapprove = e.Row.FindControl("btnapprove") as Button;
                Button btnreject = e.Row.FindControl("btnreject") as Button;
                Button btnPrint = e.Row.FindControl("btnPrint") as Button;

                if (status == "Pending" || status == "Rejected")
                {
                    if (btnCheckout != null)
                    {
                        btnCheckout.Enabled = false;
                        btnCheckout.BackColor = System.Drawing.Color.Gray;
                    }

                    if (btnPrint != null)
                    {
                        btnPrint.Enabled = false;
                        btnPrint.BackColor = System.Drawing.Color.Gray;
                    }
                }
                if (status == "Approved")
                {
                    if (btnCheckout != null)
                        btnCheckout.Enabled = true;

                    if (btnPrint != null)
                        btnPrint.Enabled = true;
                }

                if (checkoutObj != DBNull.Value)
                {
                    if (btnCheckout != null)
                    {
                        btnCheckout.Text = "Done";
                        btnCheckout.Enabled = false;
                        btnCheckout.BackColor = System.Drawing.Color.Gray;
                    }

                    if (btnapprove != null)
                    {
                        btnapprove.Enabled = false;
                        btnapprove.BackColor = System.Drawing.Color.Gray;
                    }

                    if (btnreject != null)
                    {
                        btnreject.Enabled = false;
                        btnreject.BackColor = System.Drawing.Color.Gray;
                    }

                    if (btnPrint != null)
                    {
                        btnPrint.Enabled =true;
                        btnPrint.BackColor = System.Drawing.Color.Gray;
                    }
                }
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(cs))
            {
                con.Open();

               

                string q = @"SELECT v.VisitID, vi.FullName, vi.PhoneNumber,
                           v.Purpose, v.WhomToMeet, v.Status,
                           v.CheckInTime, v.CheckOutTime
                           FROM Visits v
                           INNER JOIN Visitors vi ON v.VisitorID = vi.VisitorID
                           WHERE vi.FullName LIKE @search OR vi.PhoneNumber LIKE @search";


                MySqlCommand cmd = new MySqlCommand(q, con);
                cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadData();
        }
    }
}
