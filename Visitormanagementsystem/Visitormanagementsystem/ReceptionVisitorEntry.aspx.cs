using System;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

namespace Visitormanagementsystem
{
    public partial class ReceptionVisitorEntry : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Myconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || Session["role"].ToString() != "Receptionist")
            {
                Response.Redirect("LoginRegi.aspx");
                return;
            }

            lblAdmin.Text = Session["user"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!ValidateForm())
                return;

            lblError.Text = "";

            string imagePath = "";
            string base64Image = hiddenImage.Value;

             
            if (!string.IsNullOrEmpty(base64Image))
            {
                try
                {
                    string folderPath = Server.MapPath("~/VisitorPhotos/");

                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string base64Data = base64Image.Split(',')[1];
                    byte[] imageBytes = Convert.FromBase64String(base64Data);

                    string fileName = Guid.NewGuid().ToString() + ".png";
                    string fullPath = Path.Combine(folderPath, fileName);

                    File.WriteAllBytes(fullPath, imageBytes);

                    imagePath = "VisitorPhotos/" + fileName;
                }
                catch
                {
                    lblError.Text = "Error saving photo!";
                    return;
                }
            }
            else
            {
                lblError.Text = "Please capture photo!";
                return;
            }

            try
            {
                using (MySqlConnection con = new MySqlConnection(cs))
                {
                    con.Open();

                    string q1 = @"INSERT INTO Visitors
            (FullName, PhoneNumber, Email, IDProofType, IDProofNumber, Company, Gender, VehicleNumber, Persons, Remarks, Photo)
            VALUES (@n,@p,@e,@type,@id,@comp,@gen,@veh,@per,@rem,@photo)";

                    MySqlCommand cmd1 = new MySqlCommand(q1, con);

                    cmd1.Parameters.AddWithValue("@n", txtName.Text.Trim());
                    cmd1.Parameters.AddWithValue("@p", txtPhone.Text.Trim());
                    cmd1.Parameters.AddWithValue("@e", txtEmail.Text.Trim());
                    cmd1.Parameters.AddWithValue("@type", ddlIDType.Text);
                    cmd1.Parameters.AddWithValue("@id", txtIDNumber.Text.Trim());
                    cmd1.Parameters.AddWithValue("@comp", txtCompany.Text.Trim());
                    cmd1.Parameters.AddWithValue("@gen", ddlGender.Text);
                    cmd1.Parameters.AddWithValue("@veh", txtVehicle.Text.Trim());
                    cmd1.Parameters.AddWithValue("@per", txtPersons.Text.Trim());
                    cmd1.Parameters.AddWithValue("@rem", txtRemarks.Text.Trim());
                    cmd1.Parameters.AddWithValue("@photo", imagePath);

                    cmd1.ExecuteNonQuery();

                    long visitorId = cmd1.LastInsertedId;

                    string q2 = @"INSERT INTO Visits 
            (VisitorID, Purpose, WhomToMeet, CheckInTime, Status) 
            VALUES (@id,@pur,@meet,NOW(),'Checked In')";

                    MySqlCommand cmd2 = new MySqlCommand(q2, con);

                    cmd2.Parameters.AddWithValue("@id", visitorId);
                    cmd2.Parameters.AddWithValue("@pur", txtPurpose.Text.Trim());
                    cmd2.Parameters.AddWithValue("@meet", txtMeet.Text.Trim());

                    cmd2.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "msg", "alert('Visitor Saved Successfully!');", true);

                    ClearForm();
                }
            }
            catch
            {
                lblError.Text = "Database Error!";
            }
        }


        private bool ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtPhone.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtIDNumber.Text) ||
                string.IsNullOrWhiteSpace(txtPurpose.Text) ||
                string.IsNullOrWhiteSpace(txtMeet.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                lblError.Text = "All fields are required!";
                return false;
            }

            if (txtPhone.Text.Length != 10)
            {
                lblError.Text = "Phone number must be 10 digits!";
                return false;
            }

            if (ddlGender.SelectedIndex == 0)
            {
                lblError.Text = "Select Gender!";
                return false;
            }

            if (ddlIDType.SelectedIndex == 0)
            {
                lblError.Text = "Select ID Type!";
                return false;
            }

            return true;
        }


        private void ClearForm()
        {
            txtName.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtCompany.Text = "";
            txtVehicle.Text = "";
            txtIDNumber.Text = "";
            txtPersons.Text = "";
            txtPurpose.Text = "";
            txtMeet.Text = "";
            txtAddress.Text = "";
            txtRemarks.Text = "";

            ddlGender.SelectedIndex = 0;
            ddlIDType.SelectedIndex = 0;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("LoginRegi.aspx");
        }
    }
}