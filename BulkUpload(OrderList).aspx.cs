using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

using static GoldMimeType;
using OfficeOpenXml;
using System.Data;

public partial class Admin_BulkUpload_OrderList_ : Essential
{
    private Dictionary<bool, string> retStr = null;
    private GoldFileUploadServices _fileupload = null;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
    {
        Thread.Sleep(200);
    }
    protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        e.CallbackData = SavePostedFile(e.UploadedFile);
        string filePath = e.CallbackData;

        using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
        {
            if (package.Workbook.Worksheets.Count > 0)
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[0];

                int rowcount = worksheet.Dimension.Rows;
                int colCount = worksheet.Dimension.Columns;

                for (int row = 2; row <= rowcount; row++)
                {
                    string customerID = worksheet.Cells[row, 1].Value?.ToString();
                    string customerName = worksheet.Cells[row, 2].Value?.ToString();
                    decimal price = Convert.ToDecimal(worksheet.Cells[row, 3].Value);
                    int stockInInventory = Convert.ToInt32(worksheet.Cells[row, 4].Value);
                    string itemCode = worksheet.Cells[row, 5].Value?.ToString();


                }
            }
            else
            {
            }
        }

        if (e.CallbackData != null)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Inserted Successfully',8);", true);
        }


    }
    private string SavePostedFile(UploadedFile uploadedFile)
    {

        long size = 0;
        string result = string.Empty, contentType = string.Empty, oldFileName = string.Empty, oldFileExtension = string.Empty;
        var file = uploadedFile;


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



        string filePath = @"D:\GoldFile\GoldPriceList\gvList.xlsx";
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

        ExcelBulkUpload(filePath);
        //clean();
    }
   

    protected void ExcelBulkUpload(string filePath)
    {

        using (ExcelPackage package = new ExcelPackage(new FileInfo(filePath)))
        {
            if (package.Workbook.Worksheets.Count > 0)
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets[0];

                int rowCount = worksheet.Dimension.Rows;


                for (int row = 2; row <= rowCount; row++)
                {
                    string customerID = worksheet.Cells[row, 1].Value?.ToString();
                    string customerName = worksheet.Cells[row, 2].Value?.ToString();
                    decimal price = Convert.ToDecimal(worksheet.Cells[row, 3].Value);
                    int stockInInventory = Convert.ToInt32(worksheet.Cells[row, 4].Value);
                    string itemCode = worksheet.Cells[row, 5].Value?.ToString();

                    // Call the stored procedure to insert data into temp table
                    SqlParameter[] objsqlpara = new SqlParameter[6];
                    objsqlpara[0] = new SqlParameter("@CustomerID", customerID);
                    objsqlpara[1] = new SqlParameter("@CustomerName", customerName);
                    objsqlpara[2] = new SqlParameter("@Price", price);
                    objsqlpara[3] = new SqlParameter("@StockInInventory", stockInInventory);
                    objsqlpara[4] = new SqlParameter("@ItemCode", itemCode);
                    objsqlpara[5] = new SqlParameter("@Out", SqlDbType.Int);
                    objsqlpara[5].Direction = ParameterDirection.Output;

                    da.ExecuteNonQueryWithOutputParameters("InsertDataIntoTempTable", objsqlpara); // Execute the stored procedure
                    int Result = Convert.ToInt32(objsqlpara[5].Value.ToString());

                    switch (Result)
                    {
                        case 1:
                            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Inserted Successfully',3);", true);

                            //Clean();
                            break;
                        case 11:
                            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('s','Record Updated Successfully',3)", true);
                            //Clean();
                            break;
                        case 403:
                            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('w','Product Already Exists',4)", true);
                            //Clean();
                            break;
                        default:
                            ScriptManager.RegisterStartupScript(this, GetType(), "Toast", "toast('e','Opps!! Something Went Wrong',4)", true);
                            //Clean();
                            break;
                    }
                }
            }

        }
    }

}
