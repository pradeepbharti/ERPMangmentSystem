<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Master.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<%@ Register Assembly="DevExpress.Data.v18.1, Version=18.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
          // Function to get cookie value by name
         function onUploadControlFileUploadComplete(s, e) {
             if (e.isValid) {
                 var rtn = e.callbackData;
                 if (rtn.indexOf('~') > -1) {
                     var data = rtn.split('~');
                     $('#hfilepath').val(data[1]);
                     lbfilename.SetText(data[0]);
                 }
                 else {
                     $('#hfilepath').val('');
                     lbfilename.SetText(rtn);
                 }
             }
             else {
                 $('#hfilepath').val('');
                 lbfilename.SetText('Unable to upload the file');
             }
         }

         function onUploadControlFilesUploadStart(s, e) {
             $('#hfilepath').val('');
             lbfilename.SetText('');
         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div>
        <asp:Label ID="lblGreeting" runat="server" />
        <asp:Label ID="lblDate" runat="server" />
         
           
    </div>
    <div align="center">
<%--        <img src="https://readme-typing-svg.herokuapp.com?/font-family=Architects+Daughter&color=%236FDA44&size=32&center=true&vCenter=true&width=600&height=50&lines=Hi+I'm+<%= FirstName %>+<%= LastName %>%F0%9F%91%8B;" alt="Headline" />--%>
        <img src="https://readme-typing-svg.herokuapp.com?/font-family=Architects+Daughter&color=%236FDA44&size=32&center=true&vCenter=true&width=600&height=50&lines=Hi+I'm+<%= CustomerName %>%F0%9F%91%8B;" alt="Headline" />

    </div>

    <div>
        <dx:ASPxUploadControl  runat="server">

                </dx:ASPxUploadControl>
                <asp:FileUpload runat="server"></asp:FileUpload>
    </div>
</asp:Content>
