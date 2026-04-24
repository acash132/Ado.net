<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ADO1.aspx.cs" Inherits="ado.net2.ADO1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
    <div class="card">
        <h2>Swaraj User Management</h2>
        <div class="input-group">
            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqUname" runat="server" ErrorMessage="Pls enter Username" ControlToValidate="txtUsername"  ForeColor="Red"> </asp:RequiredFieldValidator>
        </div>

        <div class="input-group">
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqPwd" runat="server" ErrorMessage="Pls enter PassWord" ControlToValidate="txtPassword" ForeColor="Purple"> </asp:RequiredFieldValidator>

        
        </div>

        <div class="button-grid">
            <asp:Button ID="btnSubmit" runat="server" Text="Create" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn btn-secondary" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="btn btn-danger" OnClientClick="return confirmDelete();" />
        </div>
    </div>

    <div class="card grid-card">
        <div class="search-box">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search records..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-search" />
        </div>
        
        <div class="grid-wrapper">
            <asp:GridView ID="grdData" runat="server" CssClass="styled-grid" GridLines="None" AutoGenerateColumns="true">
                <HeaderStyle CssClass="grid-header" />
                <RowStyle CssClass="grid-row" />
            </asp:GridView>
        </div>
    </div>
</div>

<script>
    // Client-side confirmation for deletion
    function confirmDelete() {
        return confirm("Are you sure you want to delete this record? This action cannot be undone.");
    }
</script>
    </form>
</body>
</html>
