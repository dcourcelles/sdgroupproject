<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Recover.aspx.cs" Inherits="TruphoxGP.Recover" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div>
        <h2>Account/Password Recovery</h2>
        <table>
            <tr>
                <td>
                    <h3>Recover Account</h3>
                </td>
            </tr>
            <tr>
                <td>
                    Email:
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnRecover" runat="server" Text="Recover Account" OnClick="btnRecover_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <h3>Reset Password:</h3>
                </td>                
            </tr>
            <tr>
                <td>
                    Username:
                </td>
                <td>
                    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                </td>
            </tr>
               <tr>
                <td>
                    <asp:Button ID="btnReset" runat="server" Text="Reset Password" OnClick="btnReset_Click" />
                </td>
                   </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                </td>
            </tr>
        </table>
    </div>
</asp:Content>
