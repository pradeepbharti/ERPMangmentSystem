using Engine;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    string EncryptionKey = ConfigurationManager.AppSettings["EncryptionKey"];
    TestDataAccess da = new TestDataAccess();
    public string CustomerName { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
    public string Phone { get; set; }
    public string Address { get; set; }
    public string FirstName { get; private set; }
    public string UserEmail { get; private set; }

    public string IsAdmin { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //protected void btnLogin_Click(object sender, EventArgs e)
    //{
    //    string email = txtEmail.Text;
    //    string password = txtPass.Text;


    //    SqlParameter[] objectPara = new SqlParameter[3];
    //    objectPara[0] = new SqlParameter("@Email", email);
    //    objectPara[1] = new SqlParameter("@Pass", password);
    //    objectPara[2] = new SqlParameter("@Out", SqlDbType.Int);
    //    objectPara[2].Direction = ParameterDirection.Output;
    //    var LoggingInforResult = da.ReturnDataTableWithParameters("usp_CheckCredentialForCustomers", objectPara);

    //    int.TryParse(objectPara[2].Value.ToString(), out int isValidUser);
    //    switch (isValidUser)
    //    {
    //        case 1:
    //            //var obj = CreateCookiesObject(LoggingInforResult);
    //            //Cookies((UserInfo)obj);
    //            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s',Login Sucessfull',5)", true);

    //            // Access admin cookies
    //            HttpCookie adminInfo = Request.Cookies["userInfo1"];
    //            if (adminInfo != null)
    //            {
    //                FirstName = EncryptionEngine.Decrypt(adminInfo["UserName"], EncryptionKey);
    //                UserEmail = EncryptionEngine.Decrypt(adminInfo["UserEmail"], EncryptionKey);
    //                Password = EncryptionEngine.Decrypt(adminInfo["Password"], EncryptionKey);
    //                Phone = EncryptionEngine.Decrypt(adminInfo["Phone"], EncryptionKey);
    //                Address = EncryptionEngine.Decrypt(adminInfo["Address"], EncryptionKey);
    //                IsAdmin = EncryptionEngine.Decrypt(adminInfo["IsAdmin"], EncryptionKey);
    //                //MasterPage master = this.Master;
    //                // Find the control by ID

    //                //Session["SsFirstName"] = FirstName;
    //                //Session["SsUserEmail"] = UserEmail;
    //                //Session["SsPassword"] = Password;
    //                //Label lblUserName = (Label)Master.FindControl("lblUserName");
    //                //lblUserName.Text = "Welcome " + FirstName;

    //                //Label lblDashBoard = (Label)Master.FindControl("lblDashBoard");
    //                //lblDashBoard.Style.Add("display", "none");
    //                //HtmlGenericControl ul = (HtmlGenericControl)Master.FindControl("menu");
    //                //HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("lblDashBoard");
    //                //li.Visible = false;
    //            }

    //            Response.Redirect("~/Admin/Default.aspx");
    //            break;
    //        case 101:
    //            //ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e', You are not admin',5)", true);
    //            Response.Write("<script>alert('You are not admin');</script>");
    //            break;
    //        default:
    //            Response.Write("<script>alert('You are not admin');</script>");
    //            //ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','User Not Exists',5)", true);
    //            break;
    //    }

    //}


    protected void btnLogin1_Click1(object sender, EventArgs e)
    {
        string email = txtEmail.Text;
        string password = txtPass.Text;


        SqlParameter[] objectPara = new SqlParameter[3];
        objectPara[0] = new SqlParameter("@Email", email);
        objectPara[1] = new SqlParameter("@Pass", password);
        objectPara[2] = new SqlParameter("@Out", SqlDbType.Int);
        objectPara[2].Direction = ParameterDirection.Output;
        var LoggingInforResult = da.ReturnDataTableWithParameters("usp_CheckCredentialForCustomers", objectPara);

       
        //HtmlGenericControl li = (HtmlGenericControl)Master.FindControl("lblOrders");
        //li.Visible = false;


       


        int.TryParse(objectPara[2].Value.ToString(), out int isValidUser);
        switch (isValidUser)
        {
            case 1:
                var obj = CreateCookiesObject1(LoggingInforResult);
                Cookies1((UserInfo1)obj);
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s',Login Sucessfull',5)", true);

                HttpCookie userInfo = Request.Cookies["userInfo1"];
                if (userInfo != null)
                {
                    
                    CustomerName = EncryptionEngine.Decrypt(userInfo["CustomerName"], EncryptionKey);
                    Email = EncryptionEngine.Decrypt(userInfo["Email"], EncryptionKey);
                    Password = EncryptionEngine.Decrypt(userInfo["Password"], EncryptionKey);
                    Phone = EncryptionEngine.Decrypt(userInfo["Phone"], EncryptionKey);
                    Address = EncryptionEngine.Decrypt(userInfo["Address"], EncryptionKey);
                    IsAdmin = EncryptionEngine.Decrypt(userInfo["IsAdmin"], EncryptionKey);

                    ////lblUserName.InnerHtml = "Welcome " + FirstName;
                    //Session["SsFirstName"] = FirstName;
                    //Session["SsUserEmail"] = UserEmail;
                    //Session["SsPassword"] = Password;
                    
                }
                Response.Redirect("~/Admin/Default.aspx");
                break;
            case 101:
                //ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e', You are not admin',5)", true);
                Response.Write("<script>alert('You are not Authorized');</script>");
                break;
            default:
                Response.Write("<script>alert(You are not Authorized');</script>");
                //ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','User Not Exists',5)", true);
                break;
        }
    }
    private void Cookies1(UserInfo1 Info)
    {
        HttpCookie userInfo = new HttpCookie("userInfo1");
        userInfo["CustomerID"] = EncryptionEngine.Encrypt(Info.CustomerID.ToString(), EncryptionKey);
        userInfo["CustomerName"] = EncryptionEngine.Encrypt(Info.CustomerName.ToString(), EncryptionKey);
        userInfo["Email"] = EncryptionEngine.Encrypt(Info.Email.ToString(), EncryptionKey);
        userInfo["Password"] = EncryptionEngine.Encrypt(Info.Password.ToString(), EncryptionKey);
        userInfo["Phone"] = EncryptionEngine.Encrypt(Info.Phone.ToString(), EncryptionKey);
        userInfo["Address"] = EncryptionEngine.Encrypt(Info.Address.ToString(), EncryptionKey);
        userInfo["IsAdmin"] = EncryptionEngine.Encrypt(Info.IsAdmin.ToString(), EncryptionKey);

        userInfo.Expires = DateTime.Now.AddDays(1);
        Response.Cookies.Add(userInfo);
    }
    protected object CreateCookiesObject1(DataTable dt)
    {
        int.TryParse(dt.Rows[0]["CustomerID"].ToString(), out int CustomerID);
        string CustomerName = dt.Rows[0]["CustomerName"].ToString();
        string Email = dt.Rows[0]["Email"].ToString();
        string Password = dt.Rows[0]["Password"].ToString();
        string Phone = dt.Rows[0]["Phone"].ToString();
        string Address = dt.Rows[0]["Address"].ToString();
        string IsAdmin = dt.Rows[0]["IsAdmin"].ToString();



        var obj = new UserInfo1()
        {
            CustomerID = CustomerID,
            CustomerName = CustomerName,
            Email = Email,
            Password = Password,
            Phone = Phone,
            Address = Address,
            IsAdmin = IsAdmin

        };
        return obj;
    }

    public class UserInfo1
    {
        public int CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }

        public string IsAdmin { get; set; }

    }

}