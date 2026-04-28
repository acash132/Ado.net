<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegProfiles.aspx.cs" Inherits="WebApplication2.RegProfiles" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<%--The runat="server" attribute is a directive used in ASP.NET Web Forms to indicate that an element 
    should be processed by the server-side engine rather than being treated as static HTML--%>
<head runat="server">
    <title>User Profile Management</title>
    <link href="RegProfiles_Style.css" rel="stylesheet" type="text/css" />
</head>

<body>

    <form id="form1" runat="server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
         <%--structural element used to group and organize content,
            to apply specific layout rules via CSS--%>
        <div class="container"> 
            
<%--used to create content containers--%>
            <div class="card">

                <h2>👤 User Registration</h2>
<%-- CSS class used as a container to arrange form elements 
    (like labels and inputs) into a structured grid layout--%>
                
                <div class="form-grid">
<%--The .form-group class acts as a container for related form elements, such as a <label> 
                        and its corresponding <input>, <select>, or <textarea>--%>
                    <div class="form-group">

                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        
<%--EnableClientScript  determines if validation occurs on the user's computer (client-side) before the form is sent to the server--%>
<%--SetFocusOnError property improves user experience by automatically moving the cursor to the invalid input field--%>
                        
                        <asp:RequiredFieldValidator ID="rfvFN" runat="server" ControlToValidate="txtFirstName" 
                         ErrorMessage="First name is required" ValidationGroup="vgReg" CssClass="error" Display="Dynamic" EnableClientScript="true" SetFocusOnError="true"/>
                    
                    </div>

                    <div class="form-group">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLN" runat="server" ControlToValidate="txtLastName" 
                          ErrorMessage="Last name is required" ValidationGroup="vgReg" CssClass="error" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label>Mobile (Used for Find/Update/Delete)</label>
                        
<%--             "display:flex;" CSS property enables a one-dimensional layout model that allows you to easily align, distribute, and size items within the container, even when their size is unknown or dynamic--%>

                        <div style="display:flex;">
                        <asp:TextBox ID="txtMobile" runat="server" style="flex:1;"></asp:TextBox>
                        <asp:Button ID="btnFetch" runat="server" Text="Find" OnClick="btnFetch_Click" 
                            CausesValidation="false" CssClass="btn btn-fetch" />
                    </div>
                       
                        <asp:RequiredFieldValidator ID="rfvMob" runat="server" ControlToValidate="txtMobile" 
                           ErrorMessage="Mobile is required" CssClass="error" ValidationGroup="vgReg" Display="Dynamic" />
                        
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" 
                                ControlToValidate="txtMobile"
                                ValidationExpression="^[0-9]{10}$"
                                ErrorMessage="Enter a valid 10-digit mobile number."
                                CssClass="error" ValidationGroup="vgReg" Display="Dynamic" />

                    </div>


                    <div class="form-group">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                         ErrorMessage="Email is required" ValidationGroup="vgReg" CssClass="error" Display="Dynamic" />
                        
                        <asp:CustomValidator ID="cvEmailUnique" runat="server" 
                            ControlToValidate="txtEmail" 
                            OnServerValidate="cvEmailUnique_ServerValidate" 
                            ErrorMessage="Email already exists!" 
                            ForeColor="Red" ValidationGroup="vgReg" Display="Dynamic" />
                    </div>
                    
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" 
                         ErrorMessage="Password required" ValidationGroup="vgReg" CssClass="error" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCPass" runat="server" ControlToValidate="txtConfirmPassword" 
                         ErrorMessage="Please confirm password" CssClass="error" ValidationGroup="vgReg" Display="Dynamic" />
                        <asp:CompareValidator ID="cvPasswordMatch" runat="server" 
                            ControlToCompare="txtPassword" 
                            ControlToValidate="txtConfirmPassword" 
                            ErrorMessage="Passwords do not match!" 
                            CssClass="error" Display="Dynamic" ValidationGroup="vgReg"
                            Operator="Equal" Type="String" />
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        
                        <div class="radio-group">
                            <asp:RadioButton ID="rbMale" runat="server" Text=" Male" GroupName="gender"  />
                            <asp:RadioButton ID="rbFemale" runat="server" Text=" Female" GroupName="gender" />
                            
                            <asp:CustomValidator ID="cvGender" runat="server" 
                             OnServerValidate="cvGender_ServerValidate" 
                                ErrorMessage="Gender is required" 
                                CssClass="error" ValidationGroup="vgReg"
                                Display="Dynamic" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Hobbies</label>
                        
                        <div class="check-group">
                            <asp:CheckBox ID="chkCricket" runat="server" Text=" Cricket" />
                            <asp:CheckBox ID="chkMusic" runat="server" Text=" Music" />
                            <asp:CheckBox ID="chkReading" runat="server" Text=" Reading" />
                        
                        </div>
                    </div>

                   <div class="form-group" style="grid-column: span 2;">
                    
                       <label>Date of Birth</label>
                    
                       <div class="dob-container">
                       
                           <asp:DropDownList ID="ddlDay" runat="server"></asp:DropDownList>
        
                           <asp:DropDownList ID="ddlMonth" runat="server">
                            <asp:ListItem Text="Month" Value="0" />
                            <asp:ListItem Text="Jan" Value="1" />
                            <asp:ListItem Text="Feb" Value="2" />
                            <asp:ListItem Text="Mar" Value="3" />
                            <asp:ListItem Text="Apr" Value="4" />
                            <asp:ListItem Text="May" Value="5" />
                            <asp:ListItem Text="Jun" Value="6" />
                            <asp:ListItem Text="Jul" Value="7" />
                            <asp:ListItem Text="Aug" Value="8" />
                            <asp:ListItem Text="Sep" Value="9" />
                            <asp:ListItem Text="Oct" Value="10" />
                            <asp:ListItem Text="Nov" Value="11" />
                            <asp:ListItem Text="Dec" Value="12" />
                           
                        </asp:DropDownList>
        
                        <asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList>
                        
                           <asp:RequiredFieldValidator ID="rfvMonth" runat="server" ControlToValidate="ddlMonth" 
                         InitialValue="0" ValidationGroup="vgReg" ErrorMessage="Select Month" CssClass="error" Display="Dynamic" />
                    </div>
                </div>
                </div>
                </div>
        

                <div class="button-section">
                    <asp:Button ID="btnSubmit" runat="server" Text="Register" OnClick="btnSubmit_Click" ValidationGroup="vgReg" CssClass="btn btn-submit" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CausesValidation="false" CssClass="btn btn-update" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CausesValidation="false" CssClass="btn btn-delete" OnClientClick="return confirm('Delete?');" />
    
                    <asp:Button ID="btnViewAll" runat="server" Text="View All" OnClick="btnViewAll_Click" CausesValidation="false" CssClass="btn btn-update" style="background-color: #9b59b6;" />
    
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CausesValidation="false" CssClass="btn btn-reset" />
                </div>
                
                <asp:Label ID="lblDisplay" runat="server" Text=""></asp:Label>
            </div>

            <div class="card">
                <h3>System Records</h3>
                <div class="grid-container">
   
    <div class="grid-wrapper">


<%--  The DataKeyNames property in an ASP.NET GridView is used to specify one or more fields
    from the data source that uniquely identify each data row. These values are stored in the 
    control state, allowing you to access them during postback events (like editing or deleting) 
    even if the fields are not displayed to the user.--%>

        <asp:GridView ID="gvUserInfo" runat="server" AutoGenerateColumns="False" 
            CssClass="modern-grid" GridLines="None" DataKeyNames="UserID"
            AllowPaging="true" PageSize="5"
            OnPageIndexChanging="gvUserInfo_PageIndexChanging"
            OnRowEditing="gvUserInfo_RowEditing" 
            OnRowCancelingEdit="gvUserInfo_RowCancelingEdit" 
            OnRowUpdating="gvUserInfo_RowUpdating" 
            OnRowDeleting="gvUserInfo_RowDeleting"> 
<%--   PagerStyle used to apply a custom CSS class specifically to the pager row (the navigation links) 
    of a GridView control. --%>
    <PagerStyle CssClass="grid-pager" />
    
    <Columns>
        <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />
        
        <asp:TemplateField HeaderText="First Name">
            
            <ItemTemplate>
                <%# Eval("FirstName") %>
            </ItemTemplate>
            
            <EditItemTemplate>
                <asp:TextBox ID="txtGridFN" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
            </EditItemTemplate>
        
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Last Name">
            <ItemTemplate><%# Eval("LastName") %></ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtGridLN" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Mobile">
            <ItemTemplate>
                <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtGridMobile" runat="server" Text='<%# Bind("Mobile") %>'></asp:TextBox>
                <%-- Optional: Add a validator inside the grid to ensure 10 digits --%>
                <asp:RegularExpressionValidator ID="revGridMob" runat="server" 
                    ControlToValidate="txtGridMobile" ValidationExpression="^[0-9]{10}$"
                    ErrorMessage="*" ForeColor="Red" Display="Dynamic" />
            </EditItemTemplate>

</asp:TemplateField>

        <asp:BoundField DataField="Email" HeaderText="Email" />
        
      <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" CausesValidation="false"/>
        
    </Columns>
</asp:GridView>

    </div>
</div>
                
</div>

        
</form>
</body>
</html>
