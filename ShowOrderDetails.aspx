<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="ShowOrderDetails.aspx.cs" Inherits="Admin_ShowOrderDetails" %>

<%@ Register Assembly="DevExpress.Data.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


  
    <link href="../Assest/Css/devexpresscontrol.css" rel="stylesheet" />

    <div id="content">

       
                <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" GridViewID="gvList">
                </dx:ASPxGridViewExporter>
                <dx:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="ASPxCallback1" OnCallback="ASPxCallback1_Callback">
                    <ClientSideEvents CallbackComplete="function(s, e) { lp.Hide(); }" />
                </dx:ASPxCallback>
                <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" runat="server" ClientInstanceName="lp" Modal="true">
                </dx:ASPxLoadingPanel>

           <form runat="server">

        
        <div class="col-md-12">
          
                    <dx:ASPxPageControl EnableHierarchyRecreation="false" ID="ASPxPageControl1" runat="server" CssClass="tabs tab-pane" align="left" ActiveTabIndex="1" Width="100%" Theme="Office2003Blue">
                        <TabPages>
                            <dx:TabPage Text="Add">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="List">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl2" runat="server">
                                        <div class="col-md-12">
                                            <div class="panel panel-info">
                                                
                                                <div class="panel-body">
                                                   
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                        <dx:ASPxButton ID="btnPdfExport" runat="server" Text="Export to PDF" UseSubmitBehavior="False" CssClass="listin" Theme="Office2003Blue"
                                                                            OnClick="btnPdfExport_Click" />
                                                                        <dx:ASPxButton ID="btnXlsExport" runat="server" Text="Export to XLS" UseSubmitBehavior="False" CssClass="listin" Theme="Office2003Blue"
                                                                            OnClick="btnXlsExport_Click" />
                                                                        <dx:ASPxButton ID="btnXlsxExport" runat="server" Text="Export to XLSX" UseSubmitBehavior="False" CssClass="listin" Theme="Office2003Blue"
                                                                            OnClick="btnXlsxExport_Click" />
                                                                        <dx:ASPxButton ID="btnRtfExport" runat="server" Text="Export to RTF" UseSubmitBehavior="False" CssClass="listin" Theme="Office2003Blue"
                                                                            OnClick="btnRtfExport_Click" />
                                                                        <dx:ASPxButton ID="btnCsvExport" runat="server" Text="Export to CSV" UseSubmitBehavior="False" CssClass="listin" Theme="Office2003Blue"
                                                                            OnClick="btnCsvExport_Click" />
                                                                    </div>
                                                                    </div>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                <asp:PostBackTrigger ControlID="btnPdfExport" />
                                                                <asp:PostBackTrigger ControlID="btnXlsExport" />
                                                                <asp:PostBackTrigger ControlID="btnRtfExport" />
                                                                <asp:PostBackTrigger ControlID="btnXlsxExport" />
                                                                <asp:PostBackTrigger ControlID="btnCsvExport" />
                                                            </Triggers>
                                                            </asp:UpdatePanel>
                                                            <dx:ASPxGridView Settings-ShowGroupPanel="true" SettingsBehavior-AllowDragDrop="true" SettingsBehavior-AllowGroup="true"
                                                                SettingsBehavior-AllowSort="true" ID="ASPxGridView1" runat="server" OnDataBinding="ASPxGridView1_DataBinding" KeyFieldName="CustomerID"
                                                                align="left" EnablePagingCallbackAnimation="True"  AutoGenerateColumns="False" Width="100%">
                                                                <Columns>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="150px" FieldName="OrderName" Caption="Order Name" VisibleIndex="0">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <%--<dx:GridViewDataDateColumn Settings-AllowDragDrop="True" Width="50px" FieldName="podt" Caption="Po Date" VisibleIndex="1">
                                                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                                                                        </PropertiesDateEdit>
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataDateColumn>--%>
                                                                    <%--  <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="Status" Caption="Status" VisibleIndex="1">
                                                                    <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />

                                                                </dx:GridViewDataTextColumn>--%>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="250px" FieldName="ProductName" Caption="Product Name" VisibleIndex="1">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="Category" Caption="Category" VisibleIndex="2">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="90px" FieldName="Price" Caption="Price" VisibleIndex="3">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="QuantityPlaced" Caption="QuantityPlaced" VisibleIndex="4">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="ShippingCharges" Caption="ShippingCharges" VisibleIndex="5">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                     <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="ItemCode" Caption="ItemCode" VisibleIndex="6">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="TotalAmount" Caption="TotalAmount" VisibleIndex="7">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>


                                                                <%--    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Caption="Approval" ReadOnly="True" Visible="true" VisibleIndex="6" Width="40px">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="LinkButton1" EnableViewState="false" runat="server"
                                                                                Text="Approval" ForeColor="Red" OnCommand="btnApproval_Command" CommandArgument='<%# Eval("OrderID") %>'  Visible='<%# (Convert.ToString(Eval("OrderStatus")) == "Order Is In Progress") %>'></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:GridViewDataTextColumn>--%>



                                                                    <%--<dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="100px" Caption="View" ReadOnly="True"
                                                                    VisibleIndex="16">
                                                                    <Settings AllowDragDrop="True" />
                                                                    <Settings AllowDragDrop="True" />
                                                                    <DataItemTemplate>
                                                                        <dx:ASPxButton ID="ShowItemPoandInvoicewiseaspxStatus" runat="server" AutoPostBack="false" ForeColor="Blue" Text="View" RenderMode="Link" OnInit="ShowItemPoandInvoicewiseaspxStatus_Init"
                                                                            ClientSideEvents-Click="function(s, e) { 
                                                                                popup11ShowItemPoandInvoicewiseaspxStatus.SetContentUrl('ShowOrderDetails.aspx?id=' + s.cpGetCustomerID);
                                                                         
                                                                          popup11ShowItemPoandInvoicewiseaspxStatus.Show();
                                                                    
                                                                      }" />
                                                                    </DataItemTemplate>
                                                                </dx:GridViewDataTextColumn>--%>
                                                                </Columns>
                                                                <Settings ShowFilterRow="True" />
                                                                <Settings ShowFilterRow="True" />
                                                                <SettingsDataSecurity AllowDelete="False" />
                                                                <Settings ShowGroupPanel="True" ShowFooter="True" ShowGroupFooter="VisibleIfExpanded" />
                                                                
                                                                <TotalSummary>
                                                                    <dx:ASPxSummaryItem FieldName="TotalAmount" SummaryType="Sum" />
                                                                </TotalSummary>
                                                                <GroupSummary>
                                                                    <dx:ASPxSummaryItem FieldName="TotalAmount" SummaryType="Sum" />
                                                                </GroupSummary>
                                                                <SettingsBehavior EnableRowHotTrack="True" />
                                                                <SettingsBehavior EnableRowHotTrack="True" />
                                                                <SettingsBehavior EnableRowHotTrack="True" />
                                                                <SettingsPager>
                                                                    <PageSizeItemSettings Visible="True" Items="10, 20, 50, 100, 500" />
                                                                    <PageSizeItemSettings Items="10, 20, 50, 100, 500" Visible="True">
                                                                    </PageSizeItemSettings>
                                                                </SettingsPager>
                                                                <SettingsDataSecurity AllowInsert="false" AllowEdit="false" AllowDelete="false" />
                                                                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False"
                                                                    AllowInsert="False" />
                                                                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False"
                                                                    AllowInsert="False" />
                                                                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False"
                                                                    AllowInsert="False" />
                                                                <Styles>
                                                                    <RowHotTrack BackColor="#E9E9E9">
                                                                    </RowHotTrack>
                                                                </Styles>
                                                            </dx:ASPxGridView>

                                                     
                                                </div>
                                            </div>
                                        </div>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
              
        </div>
                  </form>
    </div>
   


