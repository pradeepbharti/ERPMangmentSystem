<%@ Page Title="" Language="C#" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Assest/Css/bootstrap.min.css">
    <link rel="stylesheet" href="Assest/Css/stylesheet.css">
    <link rel="stylesheet" href="Assest/Css/style.css">
    <link rel="shortcut icon" href="Assest/Img/25231.png" type="image/x-icon">

    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <link href="Content/JqueryToastCss.css" rel="stylesheet" />

    <link href="Content/ConfirmBoxCss.css" rel="stylesheet" />
    <link rel="shortcut icon" href="Content/Images/GRW.svg" type="image/x-icon" />
    <link href="Content/MasterCSS.css?v=1" rel="stylesheet" />

    <script src="Scripts/J-Query-Min.js"></script>
    <script type="text/javascript" src="Scripts/JqueryToast.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.bundle.js"></script>
    <script type="text/javascript" src="Scripts/Custom_Validation_Scripts.js?v=1"></script>
    <script type="text/javascript" src="Scripts/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="Scripts/CustomToast.js?v=1"></script>
    <script type="text/javascript" src="Assest/js/script.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
   
</head>

<body>
    <div class="p-of-page"></div>

    <div class="p-login-sec">
        <div class="container">
            <div class="login-sec">
                <div class="cont-media">
                    <div class="p-logo">
                        <img class="logo" src="Assest/Img/25231.png" alt="SEO">
                    </div>
                    <div class="p-form">
                        <form class="form" runat="server">
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" class="e-mail-inpt" type="text" placeholder="Enter E-mail" required> </asp:TextBox>

                            <br>
                            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" class="pass-inpt" Placeholder="Enter Password" required> </asp:TextBox>

                            <br>
                            <div class="l-parent">
                                <label class="shpass">Show password</label>
                                <input class="chk-box" type="checkbox" onkeyup="tglclass(this)" id="show-pass">
                            </div>
                            <br>
                           <%-- <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" class="submit" Text="Login for Admin" />--%>
                            <asp:Button ID="btnLogin1" runat="server" OnClick="btnLogin1_Click1" class="submit" Text="Login" />
                        </form>
                        <div class="p-border">
                            <div class="border"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--    <script src="Assest/js/jquery-3.2.1.slim.min.js"></script>
    <script src="Assest/js/popper.min.js"></script>
    <script src="Assest/js/bootstrap.min.js"></script>
    <script src="Assest/js/script.js"></script>--%>
</body>
</html>

