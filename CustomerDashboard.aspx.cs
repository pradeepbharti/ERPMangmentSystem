using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class CustomerDashboard : Essential
{
    private object chkSingleExpanded;

    public object GridViewFeaturesHelper { get; private set; }
  

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
            gvList.DataBind();
        }
    }


    protected void gvList_DataBinding(object sender, EventArgs e)
    {
        var gv = (ASPxGridView)sender;
        gv.DataSource = da.ReturnDataTable("usp_GetCustomerDetails");

    }



    //protected void btnView_Command(object sender, CommandEventArgs e)
    //{
    //    int ChildSLNO = Convert.ToInt32(e.CommandArgument);
    //    SqlParameter[] para = new SqlParameter[1];
    //    para[0] = new SqlParameter("@CustomerId", ChildSLNO);
    //    var dt = da.ReturnDatasetWithParameters("usp_GetCustomerInvoice", para);
    //    ASPxGridView1.DataSource = dt;
    //    ASPxGridView1.DataBind();
    //}

    protected void ShowItemPoandInvoicewiseaspxStatus_Init(object sender, EventArgs e)
    {
        ASPxButton control = (ASPxButton)sender;
        GridViewDataItemTemplateContainer container = (GridViewDataItemTemplateContainer)control.NamingContainer;
        control.JSProperties["cpGetCustomerID"] = DataBinder.Eval(container.DataItem, "CustomerID");
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