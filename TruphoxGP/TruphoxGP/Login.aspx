<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TruphoxGP.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <div class="divLogin">
        <div class="loginForm" style="height: 526px">
            <table class="table-bordered">
                <tr>
                    <td style="width: 101px">
                        <asp:Label ID="lblUsername" runat="server" Text="Username: " CssClass="username"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="login"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 101px">
                        <asp:Label ID="lblPassword" runat="server" Text="Password: " CssClass="password"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="login" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-block" Width="898px" />
            <div class="UOCenter" style="width: 92%; height: 169px; margin-left: 0px">
            <table class="table-bordered" style="height: 182px; width: 821px; margin-left: 0px;">
                <tr>
                    <td style="width: 675px" class="modal-lg">Remember Me? 
                        <asp:CheckBox ID="chkRememberMe" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 675px" class="modal-lg">
                        <asp:Label ID="lblRegister" runat="server" Text="Don't have an account? Register!"></asp:Label>
                        <br />
                        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn-secondary" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 675px" class="modal-lg">
                        <asp:Label ID="lblRecover" runat="server" Text="Forgot your username or password? Recover your password by clicking the button below:"></asp:Label>
                        <br />
                        <asp:Button ID="btnRecover" runat="server" Text="Recover Username/Password" OnClick="btnRecover_Click" CssClass="btn-secondary " />
                    </td>
                </tr>
            </table>
                </div>
        </div>
    </div>
</asp:Content>
