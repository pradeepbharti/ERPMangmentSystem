<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Master.master" AutoEventWireup="true" CodeFile="OrderConfirmation.aspx.cs" Inherits="OrderConfirmation" %>

<%@ Register Assembly="DevExpress.Data.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        td {
            padding-bottom: 15px;
        }

            td > div {
                margin-bottom: 15px;
                margin-left: 13px;
            }

        .ChkBoxClass input {
            width: 87px;
            height: 30px;
            margin-top: -2px;
            background-color: orangered;
        }



        .Row {
            text-align: center;
            font-display: block;
            font-style: oblique;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            column-fill: auto;
        }

        .CheckBox {
            color: #D2042D;
        }

        .SvCss {
            margin-top: 30px;
            background-color: #00ffff;
            margin-left: 13px;
            width: 100px;
            border: 2px solid #00ffff;
        }

        .intern-Container {
            background-color: #FFE5B4;
            max-width: 1556px;
        }

        .borderrr {
            border: 1px solid black;
            width: auto;
        }

            .borderrr input[type="checkbox"] {
                display: none;
            }

                .borderrr input[type="checkbox"] + label {
                    position: relative;
                    padding-left: 35px;
                    cursor: pointer;
                }

                    .borderrr input[type="checkbox"] + label:before {
                        content: "";
                        position: absolute;
                        width: 25px;
                        height: 25px;
                        left: 0;
                        border: 2px solid black;
                        background: #D2042D;
                    }

                .borderrr input[type="checkbox"]:checked + label:before {
                    content: "✔";
                    line-height: 25px;
                    text-align: center;
                    color: black;
                }

        .nav-link, .nav-link:hover {
            color: #D2042D;
        }
    </style>

    <script>


        //function validateMonth(input) {


        //    var month = input.value;
        //    if (isNaN(month) || month < 1 || month > 12) {
        //        toast('w', 'Please enter a valid month(1-12)', 4);
        //        input.value = "";
        //    }
        //    document.getElementById('cld1').value = "";
        //    document.getElementById('cld2').value = "";
        //}
        function validateinput(input) {


            var value = input.value;
            var hasNumber = /\d/;
            if (hasNumber.test(value)) {
                toast('w', 'Numeric characters are not allowed', 4);
                input.value = "";
            }
        }
        //function myFunction(input) {


        //    var numMonths = parseInt(document.getElementById('txtInternshipPeriod').value);
        //    var startDate = new Date(document.getElementById('cld1').value);
        //    startDate.setMonth(startDate.getMonth() + numMonths)
        //    var dateString = startDate.toISOString().slice(0, 10);
        //    document.getElementById('cld2').value = dateString;
        //}


    </script>
    <style>
        .checkbox-wrapper-55 input[type="checkbox"] {
            visibility: hidden;
            display: none;
        }

        .checkbox-wrapper-55 *,
        .checkbox-wrapper-55 ::after,
        .checkbox-wrapper-55 ::before {
            box-sizing: border-box;
        }

        .checkbox-wrapper-55 .rocker {
            display: inline-block;
            position: relative;
            /*
    SIZE OF SWITCH
    ==============
    All sizes are in em - therefore
    changing the font-size here
    will change the size of the switch.
    See .rocker-small below as example.
    */
            font-size: 2em;
            font-weight: bold;
            text-align: center;
            text-transform: uppercase;
            color: #888;
            width: 7em;
            height: 4em;
            overflow: hidden;
            border-bottom: 0.5em solid #eee;
        }

        .checkbox-wrapper-55 .rocker-small {
            font-size: 0.75em;
        }

        .checkbox-wrapper-55 .rocker::before {
            content: "";
            position: absolute;
            top: 0.5em;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #999;
            border: 0.5em solid #eee;
            border-bottom: 0;
        }

        .checkbox-wrapper-55 .switch-left,
        .checkbox-wrapper-55 .switch-right {
            cursor: pointer;
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 2.5em;
            width: 3em;
            transition: 0.2s;
            user-select: none;
        }

        .checkbox-wrapper-55 .switch-left {
            height: 2.4em;
            width: 2.75em;
            left: 0.85em;
            bottom: 0.4em;
            background-color: #ddd;
            transform: rotate(15deg) skewX(15deg);
        }

        .checkbox-wrapper-55 .switch-right {
            right: 0.5em;
            bottom: 0;
            background-color: #bd5757;
            color: #fff;
        }

            .checkbox-wrapper-55 .switch-left::before,
            .checkbox-wrapper-55 .switch-right::before {
                content: "";
                position: absolute;
                width: 0.4em;
                height: 2.45em;
                bottom: -0.45em;
                background-color: #ccc;
                transform: skewY(-65deg);
            }

        .checkbox-wrapper-55 .switch-left::before {
            left: -0.4em;
        }

        .checkbox-wrapper-55 .switch-right::before {
            right: -0.375em;
            background-color: transparent;
            transform: skewY(65deg);
        }

        .checkbox-wrapper-55 input:checked + .switch-left {
            background-color: #0084d0;
            color: #fff;
            bottom: 0px;
            left: 0.5em;
            height: 2.5em;
            width: 3em;
            transform: rotate(0deg) skewX(0deg);
        }

            .checkbox-wrapper-55 input:checked + .switch-left::before {
                background-color: transparent;
                width: 3.0833em;
            }

            .checkbox-wrapper-55 input:checked + .switch-left + .switch-right {
                background-color: #ddd;
                color: #888;
                bottom: 0.4em;
                right: 0.8em;
                height: 2.4em;
                width: 2.75em;
                transform: rotate(-15deg) skewX(-15deg);
            }

                .checkbox-wrapper-55 input:checked + .switch-left + .switch-right::before {
                    background-color: #ccc;
                }

        /* Keyboard Users */
        .checkbox-wrapper-55 input:focus + .switch-left {
            color: #333;
        }

        .checkbox-wrapper-55 input:checked:focus + .switch-left {
            color: #fff;
        }

        .checkbox-wrapper-55 input:focus + .switch-left + .switch-right {
            color: #fff;
        }

        .checkbox-wrapper-55 input:checked:focus + .switch-left + .switch-right {
            color: #333;
        }

        .ddl {
            display: block;
            width: 100%;
            height: calc(1.5em + 0.75rem + 2px);
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: black;
            background-color: #fff;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
        }

            .ddl:hover {
                background-color: #D2042D;
            }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scrpt1" runat="server"></asp:ScriptManager>
    <asp:Label runat="server" ID="lbid" Visible="false"></asp:Label>
    <div>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

    <div id="content">

         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
            <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                <ContentTemplate>
                    <dx:ASPxPageControl EnableHierarchyRecreation="false" ID="ASPxPageControl1" runat="server" CssClass="tabs tab-pane" align="left" ActiveTabIndex="1" Width="100%" Theme="Aqua">
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
                                                    <asp:UpdatePanel ID="UpdatePanel26" runat="server">
                                                        <ContentTemplate>
                                                            <asp:UpdatePanel ID="UpdatePanel27" runat="server">
                                                                <ContentTemplate>
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                        <dx:ASPxButton ID="btnPdfExport" runat="server" Text="Export to PDF" UseSubmitBehavior="False" CssClass="listin" Theme="Aqua"
                                                                            OnClick="btnPdfExport_Click" />
                                                                        <dx:ASPxButton ID="btnXlsExport" runat="server" Text="Export to XLS" UseSubmitBehavior="False" CssClass="listin" Theme="Aqua"
                                                                            OnClick="btnXlsExport_Click" />
                                                                        <dx:ASPxButton ID="btnXlsxExport" runat="server" Text="Export to XLSX" UseSubmitBehavior="False" CssClass="listin" Theme="Aqua"
                                                                            OnClick="btnXlsxExport_Click" />
                                                                        <dx:ASPxButton ID="btnRtfExport" runat="server" Text="Export to RTF" UseSubmitBehavior="False" CssClass="listin" Theme="Aqua"
                                                                            OnClick="btnRtfExport_Click" />
                                                                        <dx:ASPxButton ID="btnCsvExport" runat="server" Text="Export to CSV" UseSubmitBehavior="False" CssClass="listin" Theme="Aqua"
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
                                                                SettingsBehavior-AllowSort="true" ID="gvList" runat="server" OnDataBinding="gvList_DataBinding" KeyFieldName="CustomerID"
                                                                align="left" EnablePagingCallbackAnimation="True" Theme="Office2003Blue" AutoGenerateColumns="False" Width="100%">
                                                                <Columns>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="150px" FieldName="OrderID" Caption="Order ID" VisibleIndex="0">
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
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="Quantity" Caption="Quantity" VisibleIndex="2">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="90px" FieldName="ProductPrice" Caption="Product Price" VisibleIndex="3">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="OrderStatus" Caption="Order Status" VisibleIndex="4">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="Amount" Caption="Amount" VisibleIndex="5">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Caption="Approval" ReadOnly="True" Visible="true" VisibleIndex="6" Width="40px">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="LinkButton1" EnableViewState="false" runat="server"
                                                                                Text="Approval" ForeColor="Red" OnCommand="btnApproval_Command" CommandArgument='<%# Eval("OrderID") %>'  Visible='<%# (Convert.ToString(Eval("OrderStatus")) == "Order Is In Progress") %>'></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:GridViewDataTextColumn>



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
                                                                    <dx:ASPxSummaryItem FieldName="finaltotal" SummaryType="Sum" />
                                                                </TotalSummary>
                                                                <GroupSummary>
                                                                    <dx:ASPxSummaryItem FieldName="finaltotal" SummaryType="Sum" />
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

                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

