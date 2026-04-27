<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ado.net2.ADO1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="Style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
    <div class="card">
        <h2>Swaraj User Management</h2>
        <div class="input-group">
            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
<asp:RequiredFieldValidator ID="ReqUname" runat="server" 
        ControlToValidate="txtUsername" 
        ValidationGroup="UserForm" 
        ErrorMessage="Pls enter Username" ForeColor="Red" />        </div>

        <div class="input-group">
            <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqPwd" runat="server" 
                ControlToValidate="txtPassword" 
                ValidationGroup="UserForm" 
                ErrorMessage="Pls enter PassWord" ForeColor="Purple"> </asp:RequiredFieldValidator>

        
        </div>

        <div class="button-grid">
            <asp:Button ID="btnSubmit" runat="server" Text="Create" OnClick="btnSubmit_Click" CssClass="btn btn-primary" ValidationGroup="UserForm" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn btn-secondary" ValidationGroup="UserForm" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="btn btn-danger" OnClientClick="return confirmDelete();" ValidationGroup="UserForm" />
        </div>
    </div>

    <div class="card grid-card">
        <div class="search-box">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search records"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-search" />
        </div>
        
        <div class="grid-wrapper">
            <asp:GridView ID="grdData" runat="server" CssClass="styled-grid" GridLines="None" DataKeyNames="UID"
                AutoGenerateColumns="False"
                PageSize="3" AllowPaging="true" OnPageIndexChanging="grdData_PageIndexChanging" OnRowCancelingEdit="grdData_RowCancelingEdit" OnRowEditing="grdData_RowEditing" OnRowUpdating="grdData_RowUpdating" OnRowDeleting="grdData_RowDeleting">
                <HeaderStyle CssClass="grid-header" />
                <RowStyle CssClass="grid-row" />
                <Columns>
                    <asp:TemplateField HeaderText="Username">
                        <ItemTemplate>
                            <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:TextBox ID="txtUsername" runat="server" Text='<%# Bind("Username") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Password">
                         <ItemTemplate>
                             <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                         </ItemTemplate>

                         <EditItemTemplate>
                             <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                         </EditItemTemplate>
                     </asp:TemplateField>

                     <asp:TemplateField HeaderText="Actions">
                         <ItemTemplate>
                             
                            <asp:Button ID="btnDelete" runat="server" Text='Delete' CommandName="Delete"></asp:Button>
                            <asp:Button ID="btnEdit" runat="server" Text='Edit' CommandName="Edit"></asp:Button>
                         </ItemTemplate>

                         <EditItemTemplate>
                             
                             <asp:Button ID="btnUpdate" runat="server" Text='Update' CommandName="Update"></asp:Button>
                            <asp:Button ID="btnCancel" runat="server" Text='Cancel' CommandName="Cancel"></asp:Button>

                         </EditItemTemplate>

                     </asp:TemplateField>
                    </Columns>

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
