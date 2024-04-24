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

public partial class OrderConfirmation : Essential
{
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
        gv.DataSource = da.ReturnDataTable("usp_GetOrdersDetail");

    }
    //protected void btnApproval_Command(object sender, CommandEventArgs e)
    //{
    //    int id = Convert.ToInt32(e.CommandArgument.ToString());
    //    SqlParameter[] newpara = new SqlParameter[1];
    //    newpara[0] = new SqlParameter("@OrderID", id);
    //    DataTable dt = da.ReturnDataTableWithParameters("usp_GetOrderConfirmationDetails", newpara);

    //    if (dt.Rows.Count > 0)
    //    {
    //        string status = dt.Rows[0]["OrderStatus"].ToString();

    //        if (status == "Order Is In Progress")
    //        {
    //            SqlParameter[] parameter = new SqlParameter[1];
    //            parameter[0] = new SqlParameter("@OrderID", id);
    //            da.ExecuteNonQueryWithParameters("usp_UpdateOrderStatus", parameter);

    //            ASPxGridView row = (ASPxGridView)(((LinkButton)sender).NamingContainer);
    //            LinkButton btnApproved = (LinkButton)row.FindControl("btnApproved");

    //            btnApproved.Text = "Approved";
    //            btnApproved.ForeColor = System.Drawing.Color.Green;
    //            ViewState["UpdatedButtonText"] = "Approved";
    //            ViewState["UpdatedButtonColor"] = System.Drawing.ColorTranslator.ToHtml(btnApproved.ForeColor);
    //        }
    //    }
    //    gvList.DataBind();
       

       
    //}

    protected void btnApproval_Command(object sender, CommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument.ToString());

        // Retrieve order details
        SqlParameter[] newpara = new SqlParameter[1];
        newpara[0] = new SqlParameter("@OrderID", id);
        DataTable dt = da.ReturnDataTableWithParameters("usp_GetOrderConfirmationDetails", newpara);

        if (dt.Rows.Count > 0)
        {
            string status = dt.Rows[0]["OrderStatus"].ToString();

            if (status == "Order Is In Progress")
            {
                // Update order status
                SqlParameter[] parameter = new SqlParameter[1];
                parameter[0] = new SqlParameter("@OrderID", id);
                da.ExecuteNonQueryWithParameters("usp_UpdateOrderStatus", parameter);

               
            }
        }

        // Rebind the grid view
        gvList.DataBind();
    }




    //protected int Delete(int id, int RoleId)
    //{
    //    SqlParameter[] objpara = new SqlParameter[3];
    //    objpara[0] = new SqlParameter("@Slno", id);
    //    objpara[1] = new SqlParameter("@CreateUID", RoleId);
    //    objpara[2] = new SqlParameter("@Out", SqlDbType.Int);
    //    objpara[2].Direction = ParameterDirection.Output;
    //    da.ExecuteNonQueryWithOutputParameters("usp_InternDetailsDelete", objpara);
    //    int Result = Convert.ToInt32(objpara[2].Value.ToString());
    //    return Result;
    //}

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