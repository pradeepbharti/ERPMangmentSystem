<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Master.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="Admin_Orders" %>

<%@ Register Assembly="DevExpress.Data.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">



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
        function validateQuantity(input) {
            debugger

            var quantity = parseInt(input.value);
            var stock = parseInt(document.getElementById("hfStock").value);
            var price = parseInt(document.getElementById("hfPrice").value);
            var avaialableStock = parseInt(quantity);
            var stock = parseInt(document.getElementById("hfStock").value);
            var totalAmount = quantity * price;


            if (avaialableStock > stock) {
                toast('w', 'Quantity exceeds the stock limit', 4);


            }
            else if (avaialableStock >= stock - 5) {
                toast('e', 'You cannot place order because Inventory is running out of stock', 4);
                Email.send({
                    Host: "smtp.gmail.com",
                    Username: "pradeepbharti8692073644@gmail.com",
                    Password: "Daya8118",
                    To: 'pradeepbharti.com@gmail.com',
                    From: "pradeepbharti8692073644@gmail.com",
                    Subject: "Sending Email using javascript",
                    Body: "Well that was easy!!",
                })
                    .then(function (message) {
                        alert("mail sent successfully")
                    });


            }
            else if (avaialableStock > stock - 5) {
                toast('e', 'You can not place all order', 4);
            }

            else {
                var textbox = document.getElementById("txtTtlAmount");

                textbox.value = totalAmount;
            }

            var quantityInput = document.getElementById("txtQuantity");
            if (quantityInput && quantityInput.value !== null && quantityInput.value !== undefined) {
                quantityInput.value = "";
            }
        }




    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scrpt1" runat="server"></asp:ScriptManager>
    <asp:Label runat="server" ID="lbid" Visible="false"></asp:Label>
    <div>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>


    <div id="content">

        <dx:ASPxPopupControl ID="ASPxPopupControl7" runat="server" ClientInstanceName="popup11ShowItemPoandInvoicewiseaspxStatus" PopupAction="MouseOver" CloseAction="CloseButton"
            PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" AllowDragging="true" AllowResize="true" EnableTheming="true" Theme="Office2003Blue" Width="1450px" Height="650px"
            ShowMaximizeButton="true" ShowCollapseButton="true" HeaderText="" Modal="false">
        </dx:ASPxPopupControl>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <dx:ASPxPageControl EnableHierarchyRecreation="false" ID="ASPxPageControl1" runat="server" CssClass="tabs tab-pane" align="left" ActiveTabIndex="0" Width="100%" Theme="Aqua">
                        <TabPages>
                            <dx:TabPage Text="Add">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                        <div class="row p-md-2">
                                            <div class="col-3 ">
                                                <label for="txtProductName">Product Name</label>
                                                <%-- <asp:TextBox ID="txtProductName" runat="server" placeholder="Product Name" CssClass="form-control" ClientIDMode="Static" required onblur="validateinput(this)" Style="border-bottom: 1px solid #D2042D;"> </asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlProducts" DataTextField="ProductNAme" DataValueField="ProductID" runat="server" CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged" required>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-3 ">
                                                <label for="txtPrice">Price(Per Piece)</label>
                                                <asp:TextBox ID="txtPrice" runat="server" Enabled="false" CssClass="form-control" Placeholder="price" Style="border-bottom: 1px solid #D2042D; width: 200px" required> </asp:TextBox>
                                                <asp:HiddenField ID="hfPrice" ClientIDMode="Static" runat="server" />
                                            </div>
                                            <div class="col-3 ">
                                                <label for="txtQuantity">Quantity</label>
                                                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" CssClass="form-control" Placeholder="Order Quantity" Style="border-bottom: 1px solid #D2042D; width: 200px" required onblur="validateQuantity(this)"> </asp:TextBox>

                                            </div>
                                            <div class="col-3">
                                                <label for="txtStock">Available Stock</label>
                                                <asp:TextBox ID="txtStock" runat="server" Enabled="false" CssClass="form-control" Placeholder="Stocks" Style="border-bottom: 1px solid #D2042D;" required> </asp:TextBox>
                                                <asp:HiddenField ID="hfStock" ClientIDMode="Static" runat="server" />
                                            </div>

                                        </div>

                                        <div class="row p-md-2">
                                            <div class="col-3">
                                                <label for="txtTtlAmount">TotalAmount</label>
                                                <asp:TextBox ID="txtTtlAmount" runat="server" ClientIDMode="Static" CssClass="form-control" Placeholder="TotalAmount" Style="border-bottom: 1px solid #D2042D;"> </asp:TextBox>

                                            </div>



                                        </div>
                                        <div class="row p-md-2">
                                            <div class="row mb-3 mr-lg-5 ml-lg-5">
                                                <div class="col-md-3 col-md-offset-2 mb-3">
                                                    <asp:Button ID="btnOrder" runat="server" OnClick="btnOrder_Click1" CssClass="btn btn-danger" Text="Order" />
                                                    <asp:Button ID="btnUpdate" runat="server" OnClick="btnOrder_Click1" CssClass="btn btn-danger" Text="Update" />

                                                </div>
                                            </div>
                                        </div>
                                       
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Text="List">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl2" runat="server">
                                        <div class="col-md-12">
                                            <div class="panel panel-info">

                                                <div class="panel-body">
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
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
                                                                SettingsBehavior-AllowSort="true" ID="gvList" runat="server" OnDataBinding="gvList_DataBinding" KeyFieldName="OrderID"
                                                                align="left" EnablePagingCallbackAnimation="True" Theme="Office2003Blue" AutoGenerateColumns="False" Width="100%">
                                                                <Columns>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="250px" FieldName="OrderName" Caption="Order Name" VisibleIndex="1">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataDateColumn Settings-AllowDragDrop="True" Width="50px"  FieldName="OrderDate" Caption="Order Date"   VisibleIndex="2">
                                                                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy">
                                                                           
                                                                        </PropertiesDateEdit>
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True"  ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        
                                                                    </dx:GridViewDataDateColumn>
                                                                    <%--<dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="potime" Caption="Time" VisibleIndex="1">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />

                                                                    </dx:GridViewDataTextColumn>--%>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="QuantityPlaced" Caption="Quantity Placed" VisibleIndex="3">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="90px" FieldName="TotalAmount" Caption="Total Amount" VisibleIndex="4">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="ShippingCharges" Caption="ShippingCharges" VisibleIndex="5">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="Status" Caption="Status" VisibleIndex="6">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                       <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="50px" FieldName="OrderApprovalStatus" Caption="OrderApproval Status" VisibleIndex="6">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="CreatedBy" Caption="CreatedBy<br/> By" VisibleIndex="7">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                     <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Width="70px" FieldName="DelUID" Caption="DelUID" Visible="false" VisibleIndex="8">
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains" />
                                                                        <Settings ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" ShowInFilterControl="True" AutoFilterCondition="Contains"></Settings>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Caption="Edit" ReadOnly="True" Visible="true" VisibleIndex="8" Width="40px">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="LinkButton1" EnableViewState="false" runat="server"
                                                                                OnClientClick="lp.Show()"
                                                                                OnCommand="btnEdit_Command" CommandArgument='<%# Eval("OrderID") %>' CausesValidation="False" CommandName="Select"> <Image src="../Content/Icons/Edit.png" Width="25" Height="25" /></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:GridViewDataTextColumn>

                                                                    <dx:GridViewDataTextColumn Settings-AllowDragDrop="True" Caption="Delete" ReadOnly="True" VisibleIndex="9" Width="40px">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" Text="Cancel Order" OnCommand="btnCancel_Command" ForeColor="Red" CommandArgument='<%# Eval("OrderID") %>' Visible='<%# Eval("OrderApprovalStatus").ToString() == "0"%>' > </asp:LinkButton>
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

