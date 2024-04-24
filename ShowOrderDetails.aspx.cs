using DevExpress.Web;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Web.UI.WebControls;

public partial class Admin_ShowOrderDetails : Essential
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable table = GetTable();
            if (table.Rows.Count > 0)
            {
                ASPxGridView1.DataBind();
            }
            
        }
    }

    protected void ASPxGridView1_DataBinding(object sender, EventArgs e)
    {

        DataTable table = GetTable();
        if (table.Rows.Count > 0)
        {
            ASPxGridView1.DataSource = table;
            AddColumns(table);
        }
        else
        {
            ASPxGridView1.DataSource = null;
            ASPxGridView1.Columns.Clear(); // Clear columns if there's no data
        }
    }

    private void AddColumns(DataTable table)
    {
        ASPxGridView1.Columns.Clear();
        foreach (DataColumn c in table.Columns)
        {
            GridViewDataTextColumn column = new GridViewDataTextColumn();
            column.FieldName = c.ColumnName;
            ASPxGridView1.Columns.Add(column);
        }
    }

    private DataTable GetTable()
    {

        SqlParameter[] para = new SqlParameter[1];
        int ChildSLNO = Convert.ToInt16(Request.QueryString["id"]);
        para[0] = new SqlParameter("@CustomerId", ChildSLNO);


        var dt = da.ReturnDataTableWithParameters("usp_GetCustomerInvoice", para);

        
       

        return dt;
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
