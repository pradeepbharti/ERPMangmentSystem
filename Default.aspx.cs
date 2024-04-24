using DevExpress.Web;
using Engine;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    string EncryptionKey = ConfigurationManager.AppSettings["EncryptionKey"];

    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string CustomerName { get; set; }
    
    public string IsAdmin { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["IsAdmin"] != null && Session["IsAdmin"].ToString() == "1")
            {
                HtmlGenericControl ul = (HtmlGenericControl)Master.FindControl("menu");
                HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("lblOrders");
                li.Visible = false;
            }
            else
            {
                HtmlGenericControl ul = (HtmlGenericControl)Master.FindControl("menu");
                HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("liAddProducts");
                HtmlGenericControl li1 = (HtmlGenericControl)Master.FindControl("liOrderConfirmation");
                HtmlGenericControl li2 = (HtmlGenericControl)Master.FindControl("liCustomerDashboard");
                li2.Visible = false;
                li.Visible = false;
                li1.Visible = false;
            }
            GetFirstLastName();
        }
    }

    protected void GetFirstLastName()
    {
        //DataTable DT = da.ReturnDataTable("usp_ApiData");
        //if (DT.Rows.Count <= 0) { return; }
        //FirstName = DT.Rows[0]["FirstName"].ToString();
        //LastName = DT.Rows[0]["LastName"].ToString();

        HttpCookie userInfo = Request.Cookies["userInfo"];
        if (userInfo != null)
        {
            CustomerName = EncryptionEngine.Decrypt(userInfo["CustomerName"], EncryptionKey);
            //FirstName = EncryptionEngine.Decrypt(userInfo1["FirstName"], EncryptionKey);
            IsAdmin = EncryptionEngine.Decrypt(userInfo["IsAdmin"], EncryptionKey);
            Session["IsAdmin"] = IsAdmin;

        }
        HttpCookie userInfo1 = Request.Cookies["userInfo1"];
        if (userInfo1 != null)
        {
            CustomerName = EncryptionEngine.Decrypt(userInfo1["CustomerName"], EncryptionKey);
            //FirstName = EncryptionEngine.Decrypt(userInfo1["FirstName"], EncryptionKey);
            IsAdmin = EncryptionEngine.Decrypt(userInfo1["IsAdmin"], EncryptionKey);
            Session["IsAdmin"] = IsAdmin;
        }
       
        if(IsAdmin == "1")
        {
            //Label lblDashBoard = (Label)Master.FindControl("lblOrders");
            //lblDashBoard.Style.Add("display", "none");
            HtmlGenericControl ul = (HtmlGenericControl)Master.FindControl("menu");
            HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("lblOrders");
            li.Visible = false;

        }
        else
        {
            HtmlGenericControl ul = (HtmlGenericControl)Master.FindControl("menu");
            HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("liAddProducts");
            HtmlGenericControl li1 = (HtmlGenericControl)Master.FindControl("liOrderConfirmation");
            HtmlGenericControl li2 = (HtmlGenericControl)Master.FindControl("liCustomerDashboard");
            li2.Visible = false;
            li.Visible = false;
            li1.Visible = false;

        }
    }
    protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        //e.CallbackData = SavePostedFile(e.UploadedFile);
    }
}