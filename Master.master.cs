using Engine;
using System;
using System.IO;

using System.Collections.Generic;
using System.Configuration;

using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Master : System.Web.UI.MasterPage
{
    string EncryptionKey = ConfigurationManager.AppSettings["EncryptionKey"];

    public string FirstName { get; private set; }
    public string CustomerName { get; private set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        GetFirstLastName();
       
    }
    protected void Logout_Click(object sender, EventArgs e)
    {
       
        HttpCookie myCookie1 = new HttpCookie("userInfo1");
       
        myCookie1.Expires = DateTime.Now.AddDays(-1d);
       
        Response.Cookies.Add(myCookie1);
        //Page.Response.Redirect(Page.Request.Url.ToString(), true);

       

        Response.Redirect("~/Login.aspx");
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
            FirstName = EncryptionEngine.Decrypt(userInfo["UserName"], EncryptionKey);
            //LastName = EncryptionEngine.Decrypt(userInfo["LastName"], EncryptionKey);

        }
        HttpCookie userInfo1 = Request.Cookies["userInfo1"];
        if (userInfo1 != null)
        {
            CustomerName = EncryptionEngine.Decrypt(userInfo1["CustomerName"], EncryptionKey);
            //FirstName = EncryptionEngine.Decrypt(userInfo1["FirstName"], EncryptionKey);
            //LastName = EncryptionEngine.Decrypt(userInfo1["LastName"], EncryptionKey);

        }
    }

}
