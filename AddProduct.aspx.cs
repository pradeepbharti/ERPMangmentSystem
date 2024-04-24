
using System;
using System.Data;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Linq;
using static GoldMimeType;

public partial class Admin_AddProduct : Essential
{
    int CustomerID = 0;

    private Dictionary<bool, string> retStr = null;
    private GoldFileUploadServices _fileupload = null;

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
        gv.DataSource = da.ReturnDataTable("usp_ProductMasterList");

    }
    protected void btnAdd_Click1(object sender, EventArgs e)
    {

        int Result = InsertUpdate();
       
        switch (Result)
        {
            case 1:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Inserted Successfully',3);", true);

                Clean();
                break;
            case 11:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Updated Successfully',3)", true);
                Clean();
                break;
            case 403:
                ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('w','Product Already Exists',4)", true);
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

        int ProductId = lbid.Text == string.Empty ? 0 : Convert.ToInt32(lbid.Text);
        SqlParameter[] objsqlpara = new SqlParameter[9];
        objsqlpara[0] = new SqlParameter("@ProductID", ProductId);
        objsqlpara[1] = new SqlParameter("@ProductNAme", txtProductName.Text);
        objsqlpara[2] = new SqlParameter("@Category", txtCategory.Text);
        objsqlpara[3] = new SqlParameter("@Price",Convert.ToDecimal(txtPrice.Text));
        objsqlpara[4] = new SqlParameter("@StockInInvetory", Convert.ToInt32(txtStock.Text));
       
        objsqlpara[5] = new SqlParameter("@ItemCode", txtItemCode.Text); 
         objsqlpara[6] = new SqlParameter("@IsInActive", SqlDbType.Bit);
        objsqlpara[6].Value = Convert.ToInt32(chkStatus.Checked);
        objsqlpara[7] = new SqlParameter("@CreateUID", CustomerID);
        objsqlpara[8] = new SqlParameter("@Out", SqlDbType.Int);
        objsqlpara[8].Direction = ParameterDirection.Output;

        da.ExecuteNonQueryWithOutputParameters("usp_ProductsAddUpdate", objsqlpara);
        int Result = Convert.ToInt32(objsqlpara[8].Value.ToString());

      
        return Result;

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        var selectedIds = gvList.GetSelectedFieldValues("ProductID");

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
        objpara[0] = new SqlParameter("@ProductID", id);
        DataTable DT = da.ReturnDataTableWithParameters("usp_ProductSingleRecords", objpara);

        if (DT.Rows.Count <= 0) { return; }
        txtProductName.Text = DT.Rows[0]["ProductName"].ToString();
        txtCategory.Text = DT.Rows[0]["Category"].ToString();
        txtPrice.Text = DT.Rows[0]["Price"].ToString();
        txtStock.Text = DT.Rows[0]["StockInInventory"].ToString();
        txtItemCode.Text = DT.Rows[0]["ItemCode"].ToString();
        chkStatus.Checked = (bool)DT.Rows[0]["IsInactive"];

    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        int PrdouctId = Cookies("CustomerID");

        int SLNO = Convert.ToInt32(e.CommandArgument.ToString());

        var Result = Delete(SLNO, PrdouctId);

        if (Result == 0)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','!! Oops SomeThing Went Wrong',4);", true); return;
        }

        ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Deleted Successfully',4);", true);

        gvList.DataBind();
    }

    protected int Delete(int id, int PrdouctId)
    {
        SqlParameter[] objpara = new SqlParameter[3];
        objpara[0] = new SqlParameter("@ProductID", id);
        objpara[1] = new SqlParameter("@CreateUID", PrdouctId);
        objpara[2] = new SqlParameter("@Out", SqlDbType.Int);
        objpara[2].Direction = ParameterDirection.Output;
        da.ExecuteNonQueryWithOutputParameters("usp_ProductDelete ", objpara);
        int Result = Convert.ToInt32(objpara[2].Value.ToString());
        return Result;
    }

    protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
    {
        Thread.Sleep(200);
    }
    public void Clean()
    {
        txtProductName.Text = string.Empty;
        txtCategory.Text = string.Empty;
        txtPrice.Text = string.Empty;
        txtStock.Text = string.Empty;
        txtItemCode.Text = string.Empty;
        
    }

    protected void Upload_Click(object sender, EventArgs e)
    {
        //int total = 0, suc = 0, failure = 0;
        //if (lbid.Text == "0")
        //{

        //    if (txtpricetablenm.Text != "" && txtwefdate.Text != "" && cboproductcategory.Text != "" && cboproductcategory.Text != "Select" && cbodivition.Text != "" && cbodivition.Text != "Select")
        //    {

        //        DataTable dt1 = new DataTable();
        //        DataTable dt10 = new DataTable();

        //        //g1.ExecDB("exec PriceListMastadd '" + Convert.ToString(txtpricetablenm.Text) + "','" + Convert.ToDateTime(txtwefdate.Text).ToShortDateString()  + "'," + Request.Cookies["uid"].Value + "," + Request.Cookies["logno"].Value + ",0,'Insert'");

        //        //string plistid1 = g1.reterive_val("exec getitempricelistid '" + txtpricetablenm.Text + "','" + Convert.ToDateTime(txtwefdate.Text).ToShortDateString()+"'");


        //        string PriceTabaleFor = string.Empty;

        //        for (int i = 0; i < cbopricetablefor.Items.Count; i++)
        //        {
        //            if (cbopricetablefor.Items[i].Selected == true)
        //            {
        //                PriceTabaleFor += cbopricetablefor.Items[i].Value.ToString() + ",";
        //            }


        //        }
        //        PriceTabaleFor = PriceTabaleFor.TrimEnd(',');

        //        if (txtextradiscount.Text == "")
        //        {
        //            txtextradiscount.Text = "0";
        //        }

        //        string effetdate = "";
        //        if (txtwefdate.Text != "")
        //        {
        //            string[] st1 = txtwefdate.Text.Split('/');

        //            if (st1.Count() > 2)
        //            {
        //                effetdate = st1[1] + "/" + st1[0] + "/" + st1[2];
        //            }

        //        }


        //        g1.ExecDB("exec PriceListMastadd " + Convert.ToByte(ChkOldPriceList.Checked) + "," + Convert.ToByte(ChkNewPriceList.Checked) + "," + Convert.ToByte(ChkViewBranch.Checked) + ",'" + Convert.ToString(txtpricetablenm.Text) + "','" + PriceTabaleFor + "'," + cbodivition.Value + "," + Convert.ToString(cboproductcategory.Value) + ",'" + effetdate + "',0,'" + Convert.ToSingle(txtextradiscount.Text) + "','" + txtpricelistno.Text + "'," + Request.Cookies["uid"].Value + "," + Request.Cookies["logno"].Value + ",0,'Insert'");

        //        string plistid1 = g1.reterive_val("exec getitempricelistid '" + txtpricetablenm.Text + "'");
        //        if ((fileuploadExcel.PostedFile != null) && (fileuploadExcel.PostedFile.ContentLength > 0))
        //        {

        //            fileName = System.IO.Path.GetFileName(fileuploadExcel.PostedFile.FileName);
        //            string strFileType = Path.GetExtension(fileuploadExcel.FileName).ToLower();
        //            UploadThisFile(fileuploadExcel);
        //            Thread.Sleep(3000);

        //            try
        //            {

        //                DataTable dtExcel = new DataTable();
        //                string SourceConstr = string.Empty;
        //                if (strFileType.Trim() == ".xls")
        //                {
        //                    SourceConstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("~/data/excel/" + fileName) + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
        //                }
        //                else if (strFileType.Trim() == ".xlsx")
        //                {
        //                    SourceConstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("~/data/excel/" + fileName) + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
        //                }
        //                OleDbConnection con = new OleDbConnection(SourceConstr);
        //                //string query = "Select * from [Sheet1$] where ([ProductCode] is not null or [ProductCode]<>'') and ([ProductName] is not null or [ProductName]<>'') and ([MRP] is not null or [MRP]<>'') and ([OfferRate] is not null or [OfferRate]<>'')  ";

        //                string query = "Select * from [Sheet1$]";

        //                OleDbDataAdapter data = new OleDbDataAdapter(query, con);
        //                data.Fill(dtExcel);
        //                con.Close();

        //                if (dtExcel.Rows.Count > 0)
        //                {
        //                    total = dtExcel.Rows.Count;

        //                    float offerprice3 = 0;
        //                    var LowTaxPrice = decimal.Zero;
        //                    for (int i = 0; i < dtExcel.Rows.Count; i++)
        //                    {
        //                        try
        //                        {
        //                            if (Convert.ToString(dtExcel.Rows[i][0]) != null && Convert.ToString(dtExcel.Rows[i][1]) != null && Convert.ToString(dtExcel.Rows[i][4]) != null && Convert.ToString(dtExcel.Rows[i][3]) != null)
        //                            {
        //                                offerprice3 = Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][5])) - Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][6]));
        //                                LowTaxPrice = Convert.ToDecimal(Convert.ToDecimal(dtExcel.Rows[i][5])) - Convert.ToDecimal(Convert.ToDecimal(dtExcel.Rows[i][6]));
        //                                if (lbid.Text == "0")
        //                                {
        //                                    rows = g1.ExecDB("exec ItemPriceexcel '" + Convert.ToString(dtExcel.Rows[i][0]) + "','" + Convert.ToString(dtExcel.Rows[i][1]) + "','','" + Convert.ToString(dtExcel.Rows[i][4]) + "'," + Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][5])) + "," + Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][6])) + "," + LowTaxPrice + "," + offerprice3 + "," + plistid1 + "," + Request.Cookies["uid"].Value + "," + Request.Cookies["logno"].Value + ",0,'Insert'," + cboproductcategory.Value);
        //                                }
        //                                else
        //                                {
        //                                    rows = g1.ExecDB("exec ItemPriceexcel '" + Convert.ToString(dtExcel.Rows[i][0]) + "','" + Convert.ToString(dtExcel.Rows[i][1]) + "','','" + Convert.ToString(dtExcel.Rows[i][4]) + "'," + Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][5])) + "," + Convert.ToSingle(Convert.ToString(dtExcel.Rows[i][6])) + "," + LowTaxPrice + "," + offerprice3 + "," + plistid1 + "," + Request.Cookies["uid"].Value + "," + Request.Cookies["logno"].Value + ",0,'Edit'," + cboproductcategory.Value);
        //                                }

        //                                if (rows > 0)
        //                                {
        //                                    suc += 1;

        //                                }

        //                            }

        //                        }
        //                        catch (Exception ex)
        //                        {
        //                            Response.Write(ex.ToString());
        //                        }
        //                    }



        //                    failure = total - suc;
        //                    divreport.Visible = true;
        //                    total1.Text = total.ToString();
        //                    success1.Text = suc.ToString();
        //                    failure1.Text = failure.ToString();

        //                }


        //                if (File.Exists(Server.MapPath(Request.ApplicationPath) + "data/excel/" + fileName))
        //                {


        //                    System.IO.File.Delete(Server.MapPath(Request.ApplicationPath) + "data/excel/" + fileName);


        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                // throw ex;
        //                // string message = string.Format("{0}:{1}", ex.InnerException.ToString(), ex.Message);

        //                Response.Write(ex.ToString());
        //            }

        //        }
        //        else
        //        {


        //            ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('please chose excel file.!');", true);
        //        }





        //    }

        //    else
        //    {
        //        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('please select price table name and enter effect date.!');", true);
        //    }






        //}
        //else
        //{

        //    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Edit is not permit through bulk import!');", true);
        //}







    }
    protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        e.CallbackData = SavePostedFile(e.UploadedFile);
    }
    private string SavePostedFile(UploadedFile uploadedFile)
    {

        long size = 0;
        string result = string.Empty, contentType = string.Empty, oldFileName = string.Empty, oldFileExtension = string.Empty;
        var file = uploadedFile;

        //#region Validation
        //if (!file.IsValid)
        //    return string.Empty;

        //if (!FileUploadValidation.IsMimeTypeAllowed(new IsMimeTypeAllowedArgs(Path.GetExtension(file.FileName), ".xlsx")))
        //{
        //    result = "Oops!! This type of file upload not allowed.";
        //    return result;
        //}
        //if (!FileUploadValidation.IsFileSizeAllowed(new IsFileSizeAllowedArgs(file.ContentLength, 1024 * 1024 * 1), out size))
        //{
        //    result = string.Format("Oops!! Max File Size allowed : {0}", size);
        //    return result;
        //}
        //#endregion
        oldFileName = Path.GetFileNameWithoutExtension(file.FileName);
        oldFileExtension = Path.GetExtension(file.FileName);
        var mineTypeAllowed = new MimeType[]
        {
            MimeType.Xlsx
        };

        #region Validation
        if (!file.IsValid)
            return string.Empty;

        if (!GoldMimeType.IsMimeTypeAllowed(oldFileExtension, mineTypeAllowed, out contentType))
        {
            result = string.Format("{0} : Oops!! This type of file upload not allowed.", oldFileName);
            return result;
        }
        if (!GoldMimeType.IsFileSizeAllowed(file.ContentLength, out size, 1024 * 1024 * 10))
        {
            result = string.Format("{0} : Oops!! Max File Size allowed : {1} MB", oldFileName, size / (1024.0 * 1024.0));
            return result;
        }
        #endregion

        retStr = new Dictionary<bool, string>();
        _fileupload = new GoldFileUploadServices();

        retStr = _fileupload.GoldFileUpload(new GoldFileUploadArgs(Path.GetFileNameWithoutExtension(file.FileName), "GoldPriceList", Path.GetExtension(file.FileName), false, true, file.FileContent));
        result = retStr.Values.FirstOrDefault();
        return result;
    }
    protected void btnPriceListBulkUpload_Click(object sender, EventArgs e)
    {
        ExcelBulkUpload();
        Clean();
    }
    private void ExcelBulkUpload()
    {
    //    int success = 0, catID = 0;
    //    string failure = string.Empty, PriceTabaleFor = string.Empty, effetdate = "";

    //    for (int i = 0; i < cbopricetablefor.Items.Count; i++)
    //    {
    //        if (cbopricetablefor.Items[i].Selected == true)
    //        {
    //            PriceTabaleFor += cbopricetablefor.Items[i].Value + ",";
    //        }
    //    }
    //    if (!string.IsNullOrWhiteSpace(PriceTabaleFor))
    //    {
    //        PriceTabaleFor = PriceTabaleFor.TrimEnd(',');
    //    }

    //    if (Convert.ToInt32(cboproductcategory.Value) > 0)
    //    {
    //        catID = Convert.ToInt32(cboproductcategory.Value);
    //    }


    //    if (PriceTabaleFor != "" && hfilepath.Value != "" && txtpricetablenm.Text != "" && txtwefdate.Text != "" && cbodivition.Text != "" && cbodivition.Text != "Select")
    //    {

    //        if (txtextradiscount.Text == "")
    //        {
    //            txtextradiscount.Text = "0";
    //        }
    //        if (txtwefdate.Text != "")
    //        {
    //            string[] st1 = txtwefdate.Text.Split('/');
    //            if (st1.Count() > 2)
    //            {
    //                effetdate = string.Format("{0}/{1}/{2}", st1[1], st1[0], st1[2]);
    //            }
    //        }

    //        string plistid = g1.reterive_val(string.Format("exec PriceListMastaddNew {0},{1},{2},'{3}','{4}',{5},{6},'{7}',0,'{8}','{9}',{10},{11}",
    //                                                                                                                                        Convert.ToByte(ChkOldPriceList.Checked),
    //                                                                                                                                        Convert.ToByte(ChkNewPriceList.Checked),
    //                                                                                                                                        Convert.ToByte(ChkViewBranch.Checked),
    //                                                                                                                                        Convert.ToString(txtpricetablenm.Text),
    //                                                                                                                                        PriceTabaleFor,
    //                                                                                                                                        cbodivition.Value,
    //                                                                                                                                        Convert.ToString(catID),
    //                                                                                                                                        effetdate,
    //                                                                                                                                        Convert.ToSingle(txtextradiscount.Text),
    //                                                                                                                                        txtpricelistno.Text,
    //                                                                                                                                        Request.Cookies["uid"].Value,
    //                                                                                                                                        Request.Cookies["logno"].Value));

    //        if (!string.IsNullOrWhiteSpace(plistid))
    //        {
    //            if (plistid == "0")
    //            {
    //                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Oops! Already Exists Same Price Table Name.');", true);
    //            }
    //            else
    //            {
    //                _importManager = new ImportManager();
    //                try
    //                {
    //                    var t = System.Threading.Tasks.Task.Factory.StartNew(() => _importManager.ImportSalesPriceListFromXlsx(
    //                                                            new FileInfo(hfilepath.Value),
    //                                                            plistid,
    //                                                            Convert.ToInt32(Request.Cookies["uid"].Value),
    //                                                            Convert.ToInt64(Request.Cookies["logno"].Value),
    //                                                            Convert.ToInt32(catID),
    //                                                            out success,
    //                                                            out failure));
    //                    t.Wait();

    //                }
    //                catch (Exception ex)
    //                {
    //                    success = 0;
    //                    failure = "Somthing wrong in Reading file!.";
    //                }
    //                divreport.Visible = true;
    //                failure1.Text = failure;
    //                success1.Text = success.ToString();
    //                if (success == 0)
    //                {
    //                    g1.ExecDB(string.Format("exec PriceListMastDelNew {0},{1},{2}",
    //                                                                                    plistid,
    //                                                                                    Request.Cookies["uid"].Value,
    //                                                                                    Request.Cookies["logno"].Value));

    //                    if (!string.IsNullOrWhiteSpace(hfilepath.Value) && File.Exists(hfilepath.Value))
    //                    {
    //                        using (var xlPackage = new ExcelPackage(new FileInfo(hfilepath.Value)))
    //                        {
    //                            string fileName = (new FileInfo(hfilepath.Value)).Name;
    //                            using (var memoryStream = new MemoryStream())
    //                            {
    //                                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    //                                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
    //                                xlPackage.SaveAs(memoryStream);
    //                                memoryStream.WriteTo(Response.OutputStream);
    //                                File.Delete(hfilepath.Value);
    //                                Response.Flush();
    //                                Response.End();
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Oops! Something wrong in Price Table name Saving!.');", true);
    //        }
    //    }
    //    else
    //    {
    //        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('please select price table name and enter effect date.!');", true);
    //    }
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
}