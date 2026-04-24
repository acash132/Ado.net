<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="ado.net2.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="Style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="input-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqUname" runat="server" 
                    ControlToValidate="txtUsername" 
                    ValidationGroup="UserForm" 
                    ErrorMessage="Pls enter Username" ForeColor="Red" />        </div>

            <div class="input-group">
    <asp:Label ID="lblfn" runat="server" Text="Full Name"></asp:Label>
    <asp:TextBox ID="txtfn" runat="server" placeholder="Enter full name"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ControlToValidate="txtfn" 
        ValidationGroup="UserForm" 
        ErrorMessage="Pls enter Full Name" ForeColor="Red" />        </div>









            <div class="input-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqPwd" runat="server" 
                    ControlToValidate="txtPassword" 
                    ValidationGroup="UserForm" 
                    ErrorMessage="Pls enter PassWord" ForeColor="Purple"> </asp:RequiredFieldValidator>

        
            </div>


            <div class="input-group">
    <label>Email Address</label>
    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@mail.com"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ValidationGroup="UserForm" CssClass="error" ErrorMessage="Email is required" ControlToValidate="txtEmail" Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revEmail" runat="server" ValidationGroup="UserForm" CssClass="error" ErrorMessage="Invalid email format" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
</div>

<div class="input-group">
    <label>Mobile Number</label>
    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="10-digit number"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvMobile" runat="server"  ValidationGroup="UserForm" CssClass="error" ErrorMessage="Mobile is required" ControlToValidate="txtMobile" Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revMobile" runat="server" ValidationGroup="UserForm" CssClass="error" ErrorMessage="Enter 10 digits" ControlToValidate="txtMobile" ValidationExpression="^[0-9]{10}$" Display="Dynamic"></asp:RegularExpressionValidator>
</div>
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" ValidationGroup="UserForm" />
                <br />
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>




        </div>
    </form>
</body>
</html>
