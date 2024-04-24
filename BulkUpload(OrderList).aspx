<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Master.master" AutoEventWireup="true" CodeFile="BulkUpload(OrderList).aspx.cs" Inherits="Admin_BulkUpload_OrderList_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scrpt1" runat="server"></asp:ScriptManager>
    <asp:Label runat="server" ID="lbid" Visible="false"></asp:Label>
    <div>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>
    <div id="content">

        <asp:UpdatePanel ID="UpdatePanel24" runat="server">
            <ContentTemplate>
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="gvList">
                </dx:ASPxGridViewExporter>
                <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="ASPxCallback1" OnCallback="ASPxCallback1_Callback">
                    <ClientSideEvents CallbackComplete="function(s, e) { lp.Hide(); }" />
                </dx:ASPxCallback>
                <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" runat="server" ClientInstanceName="lp" Modal="true">
                </dx:ASPxLoadingPanel>

            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <dx:ASPxPageControl EnableHierarchyRecreation="false" ID="ASPxPageControl1" runat="server" CssClass="tabs tab-pane" align="left" ActiveTabIndex="0" Width="100%" Theme="Aqua">
                        <TabPages>
                            <dx:TabPage Text="Add">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <asp:UpdatePanel ID="sas" runat="server">
                                                        <ContentTemplate>
                                                            <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" UploadMode="Auto" AutoStartUpload="True" ShowProgressPanel="True" Theme="Office2003Blue" OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" ClientInstanceName="ASPxUploadControl1">
                                                                <AdvancedModeSettings EnableDragAndDrop="False" EnableFileList="False" EnableMultiSelect="False" />
                                                                <ValidationSettings MaxFileSize="1048576" AllowedFileExtensions=".xlsx" ErrorStyle-CssClass="validationMessage" MaxFileCount="1" />
                                                                <BrowseButton Text="Select an Excel for upload..." />
                                                                <ProgressBarStyle CssClass="uploadControlProgressBar" />
                                                            </dx:ASPxUploadControl>
                                                            <dx:ASPxLabel ID="lbfilename" runat="server" ForeColor="OrangeRed" Text="" ClientInstanceName="lbfilename"></dx:ASPxLabel>
                                                            <asp:HiddenField ID="hfilepath" runat="server" Value="" ClientIDMode="Static" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <br />
                                                    <br />
                                                    <asp:UpdatePanel ID="UpdatePanel19" runat="server">
                                                        <ContentTemplate>
                                                            <dx:ASPxButton ID="btnPriceListBulkUpload" runat="server" Text="Bulk Upload" OnClick="btnPriceListBulkUpload_Click" Theme="Office2003Blue" CssClass="btn btn-danger">
                                                                <%--<ClientSideEvents Click="function(s, e) { lp.Show(); ASPxCallback1.PerformCallback(); }" />--%>
                                                            </dx:ASPxButton>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnPriceListBulkUpload" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                    <br />
                                                    <div id="divreport" runat="server" visible="false">
                                                        Total:&nbsp;<asp:Label ID="total1" runat="server"></asp:Label>
                                                        Successfull:&nbsp;<asp:Label ID="success1" runat="server"></asp:Label>
                                                        Failure:&nbsp;<asp:Label ID="failure1" runat="server"></asp:Label>
                                                    </div>
                                                    <br />
                                                    <br />
                                                    <div>
                                                        <div>
                                                            <tr>
                                                                <td align="left" style="padding-left: 20px">
                                                                    <a href="http://localhost:52472/App_Code/BLL/data/samplexl/gvList.xlsx" download>
                                                                        <samp style="font-weight: bold; color: black; font-size: 13px;" class="link">General Guide</samp>
                                                                    </a>
                                                                </td>
                                                                <td align="left" style="padding-left: 20px"><a href="/App_Code/BLL/data/samplexl/gvList.xlsx">
                                                                <samp style="font-weight: bold; color: black; font-size: 13px;" class="link">General Guide</samp></a></td>
                                                            </tr>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="List">
                                <ContentCollection>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </div>
</asp:Content>

