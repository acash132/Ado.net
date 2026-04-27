<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="ado.net2.Registration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modern Registration</title>
    <link href="Style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Create Account</h2>
            <p class="subtitle">Join C# community today</p>

            <div class="input-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqUname" runat="server" 
                    ControlToValidate="txtUsername" 
                    ValidationGroup="UserForm" 
                    ErrorMessage="Username is required" 
                    CssClass="error-text" 
                    Display="Dynamic" />
            </div>

            <div class="input-group">
                <asp:Label ID="lblfn" runat="server" Text="Full Name"></asp:Label>
                <asp:TextBox ID="txtfn" runat="server" placeholder="John Doe"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtfn" 
                    ValidationGroup="UserForm" 
                    ErrorMessage="Full Name is required" 
                    CssClass="error-text" 
                    Display="Dynamic" />
            </div>

            <div class="input-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqPwd" runat="server" 
                    ControlToValidate="txtPassword" 
                    ValidationGroup="UserForm" 
                    ErrorMessage="Password is required" 
                    CssClass="error-text" 
                    Display="Dynamic" />
            </div>

            <div class="input-group">
                <asp:Label runat="server" Text="Email Address"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="example@mail.com"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ValidationGroup="UserForm" 
                    CssClass="error-text" 
                    ErrorMessage="Email is required" 
                    ControlToValidate="txtEmail" 
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                    ValidationGroup="UserForm" 
                    CssClass="error-text" 
                    ErrorMessage="Invalid email format" 
                    ControlToValidate="txtEmail" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    Display="Dynamic" />
            </div>

            <div class="input-group">
                <asp:Label runat="server" Text="Mobile Number"></asp:Label>
                <asp:TextBox ID="txtMobile" runat="server" placeholder="10-digit number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" 
                    ValidationGroup="UserForm" 
                    CssClass="error-text" 
                    ErrorMessage="Mobile is required" 
                    ControlToValidate="txtMobile" 
                    Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile" runat="server" 
                    ValidationGroup="UserForm" 
                    CssClass="error-text" 
                    ErrorMessage="Enter 10 digits" 
                    ControlToValidate="txtMobile" 
                    ValidationExpression="^[0-9]{10}$" 
                    Display="Dynamic" />
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register" 
                OnClick="btnRegister_Click" 
                ValidationGroup="UserForm" 
                CssClass="btn-submit" />
            
            <asp:Label ID="lblMessage" runat="server" CssClass="status-message"></asp:Label>


            <div class="form-container search-section">
    <h3>Search Members</h3>
    <div class="input-group">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by username or email..."></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn-submit" />
    </div>

    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="search-grid">
        <Columns>
            <asp:BoundField DataField="Username" HeaderText="Username" />
            <asp:BoundField DataField="FullName" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
        </Columns>
    </asp:GridView>
</div>
        </div>
    </form>
</body>
</html>