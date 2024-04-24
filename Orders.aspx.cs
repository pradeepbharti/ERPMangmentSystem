using DevExpress.Web;
using Engine;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


public partial class Admin_Orders : Essential
{
    int CustomerID = 0;
    int OrderID = 0;
    string EncryptionKey = ConfigurationManager.AppSettings["EncryptionKey"];
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

            ProductDropDownList();
            gvList.DataBind();
        }
        hfStock.Value = txtStock.Text;
        hfPrice.Value = txtPrice.Text;
        btnUpdate.Visible = false;


    }
    protected void gvList_DataBinding(object sender, EventArgs e)
    {
        var gv = (ASPxGridView)sender;
        gv.DataSource = da.ReturnDataTable("usp_OrderMasterList");

    }
    private void ProductDropDownList()
    {
        DataTable dt = da.ReturnDataTable("usp_GetProductsList");
        ddlProducts.DataSource = dt;
        ddlProducts.DataBind();

        ListItem liProduct = new ListItem("Select Product", "-1");
        ddlProducts.Items.Insert(0, liProduct);
    }
    protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
    {


        int id = Convert.ToInt32(ddlProducts.SelectedValue);
        SqlParameter[] parameter = new SqlParameter[1];
        parameter[0] = new SqlParameter("@ProductID", id);

        DataTable dt = da.ReturnDataTableWithParameters("usp_GetQuantityList", parameter);

        txtStock.Text = dt.Rows[0]["StockInInVentory"].ToString();
        txtPrice.Text = dt.Rows[0]["Price"].ToString();
        hfStock.Value = txtStock.Text;
        hfPrice.Value = txtPrice.Text;
        //ListItem liCity = new ListItem("Select City", "-1");
        //ddlCities.Items.Insert(0, liCity);

    }
    protected void btnOrder_Click1(object sender, EventArgs e)
    {

        int Result = InsertUpdate();
        switch (Result)
        {
            case 1:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Order Placed Successfully',3);", true);
                Clean();


                break;
            case 11:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Order Updated Successfully',3)", true);
                Clean();
                break;
            case 403:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('w','Order Already Exists',4)", true);
                Clean();
                break;
            default:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','Opps!! Something Went Wrong',4)", true);
                Clean();
                break;
        }
        gvList.DataBind();
    }

    protected int InsertUpdate()
    {

        var cookies = CookiesData.GetUserDataFromCookies();
        int.TryParse(cookies["CustomerID"].ToString(), out CustomerID);

        int OrderID = lbid.Text == string.Empty ? 0 : Convert.ToInt32(lbid.Text);
        SqlParameter[] objsqlpara = new SqlParameter[10];
        objsqlpara[0] = new SqlParameter("@OrderID", OrderID);
        objsqlpara[1] = new SqlParameter("@CustomerID", CustomerID);
        objsqlpara[2] = new SqlParameter("@ProductID", ddlProducts.SelectedValue);
        objsqlpara[3] = new SqlParameter("@ProductName", ddlProducts.SelectedItem.Text.ToString());
        objsqlpara[4] = new SqlParameter("@Quantity", Convert.ToInt32(txtQuantity.Text));
        objsqlpara[5] = new SqlParameter("@TotalAmount", Convert.ToDecimal(txtTtlAmount.Text));
        objsqlpara[6] = new SqlParameter("@ShippingCharges", 50);
        objsqlpara[7] = new SqlParameter("@Status", "Order Placed");
        objsqlpara[8] = new SqlParameter("@CreateUID", CustomerID);
        objsqlpara[9] = new SqlParameter("@Out", SqlDbType.Int);
        objsqlpara[9].Direction = ParameterDirection.Output;

        da.ExecuteNonQueryWithOutputParameters("usp_OrderMasterAddUpdate", objsqlpara);
        int Result = Convert.ToInt32(objsqlpara[9].Value.ToString());

       
        return Result;

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        var selectedIds = gvList.GetSelectedFieldValues("OrderID");

    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument.ToString());
        lbid.Text = id.ToString();
        
        Show(id);
        ASPxPageControl1.ActiveTabIndex = 0;
    }
    protected void Show(int id)
    {
        SqlParameter[] objpara = new SqlParameter[1];
        objpara[0] = new SqlParameter("@OrderID", id);
        DataTable DT = da.ReturnDataTableWithParameters("usp_OrdersSingleRecords", objpara);

        if (DT.Rows.Count <= 0) { return; }
        Session["OrderID"] = id;
       
        ddlProducts.SelectedValue = DT.Rows[0]["ProductID"].ToString();
      
        txtQuantity.Text = DT.Rows[0]["QuantityPlaced"].ToString();
       
        txtTtlAmount.Text = DT.Rows[0]["TotalAmount"].ToString();
        txtStock.Text = DT.Rows[0]["StockInInventory"].ToString();
        hfStock.Value = txtStock.Text;
        txtPrice.Text = DT.Rows[0]["Price"].ToString();
        hfPrice.Value = txtPrice.Text;
        btnOrder.Visible = false;
        btnUpdate.Visible = true;

    }
    protected void btnCancel_Command(object sender, CommandEventArgs e)
    {
       

        int SLNO = Convert.ToInt32(e.CommandArgument.ToString());
        SqlParameter[] objpara = new SqlParameter[1];
        objpara[0] = new SqlParameter("@OrderID", SLNO);
        DataTable DT = da.ReturnDataTableWithParameters("usp_OrdersSingleRecords", objpara);

        if (DT.Rows.Count <= 0) {  }

        txtQuantity.Text = DT.Rows[0]["QuantityPlaced"].ToString();
        ddlProducts.SelectedValue = DT.Rows[0]["ProductID"].ToString();
        var Result = Delete(SLNO, CustomerID);
        //OrderID = Cookies("OrderID");

        
        Clean();
        gvList.DataBind();
    }

    protected int Delete(int id, int CustomerID)
    {

        //SqlParameter[] objpara = new SqlParameter[1];
        //objpara[0] = new SqlParameter("@OrderID", id);
        //DataTable DT = da.ReturnDataTableWithParameters("usp_OrdersSingleRecords", objpara);

        //if (DT.Rows.Count <= 0) { return 0; }

        //txtQuantity.Text = DT.Rows[0]["QuantityPlaced"].ToString();
        //hfStock.Value = txtStock.Text;
        //ddlProducts.SelectedValue = DT.Rows[0]["ProductID"].ToString();


        SqlParameter[] objpara1 = new SqlParameter[5];
        objpara1[0] = new SqlParameter("@OrderID", id);
        objpara1[1] = new SqlParameter("@QuantityPlaced", txtQuantity.Text);
        objpara1[2] = new SqlParameter("@ProductID", ddlProducts.SelectedValue);
        objpara1[3] = new SqlParameter("@CreateUID", CustomerID);
        
        objpara1[4] = new SqlParameter("@Out", SqlDbType.Int);
        objpara1[4].Direction = ParameterDirection.Output;
        da.ExecuteNonQueryWithOutputParameters("usp_OrdersDelete", objpara1);

        
        int Result = Convert.ToInt32(objpara1[4].Value.ToString());
       
        if (Result == 0)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','!! Oops SomeThing Went Wrong',4);", true);
            Clean();

        }
        ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s',Order Cancelled Successfully',4);", true);
        return Result;
    }

    protected void Clean()
    {
        ResetControls(UpdatePanel1);
    }
    private void CookiesForOrder(OrderInfo OInfo)
    {
        HttpCookie OrderInfo = new HttpCookie("OrderInfo");
        OrderInfo["OrderID"] = EncryptionEngine.Encrypt(OInfo.OrderID.ToString(), EncryptionKey);
        OrderInfo.Expires = DateTime.Now.AddDays(1);
        Response.Cookies.Add(OrderInfo);
    }
    protected object CreateCookiesForOrder(int orderid)
    {
        this.OrderID = orderid;
        

        var obj = new OrderInfo()
        {
            OrderID = OrderID,
            
        };
        return obj;
    }
    public class OrderInfo
    {
        public int OrderID { get; set; }
        
    }

    protected void columnhide()
    {

    }
    /// <summary>
    /// Show column in export
    /// </summary>
    protected void columnshow()
    {

    }
    /// <summary>
    /// Party Bind
    /// </summary>
    #region export


    protected void btnPdfExport_Click(object sender, EventArgs e)
    {
        //gvList.WritePdfToResponse();
        columnhide();
        ASPxGridViewExporter1.WritePdfToResponse();
        columnshow();
    }
    protected void btnXlsExport_Click(object sender, EventArgs e)
    {
        //gvList.WriteXlsToResponse(new XlsExportOptionsEx { ExportType = ExportType.WYSIWYG });
        columnhide();
        ASPxGridViewExporter1.WriteXlsToResponse();
        columnshow();
    }
    protected void btnXlsxExport_Click(object sender, EventArgs e)
    {
        // ASPxGridView1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        columnhide();
        ASPxGridViewExporter1.WriteXlsxToResponse();
        columnshow();
    }
    protected void btnRtfExport_Click(object sender, EventArgs e)
    {
        //  ASPxGridView1.WriteRtfToResponse();
        columnhide();
        ASPxGridViewExporter1.WriteRtfToResponse();
        columnshow();
    }
    protected void btnCsvExport_Click(object sender, EventArgs e)
    {
        // ASPxGridView1.WriteCsvToResponse(new CsvExportOptionsEx() { ExportType = ExportType.WYSIWYG });
        columnhide();
        ASPxGridViewExporter1.WriteCsvToResponse();
        columnshow();
    }
    #endregion

    protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
    {
        Thread.Sleep(200);
    }
}
