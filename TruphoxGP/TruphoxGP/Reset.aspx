<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Reset.aspx.cs" Inherits="TruphoxGP.Reset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <h2>Reset Password</h2>
    <div>
        <asp:Button ID="btnHome" runat="server" Text="Back to Home" Visible="false" OnClick="btnHome_Click" />
        <br />
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        <asp:Label ID="lblUsername" runat="server" Text="" Visible="false"></asp:Label>
        <asp:Panel ID="pnlReset" runat="server">
            <table>
                    <tr>
                        <td>New Password:
                        </td>
                        <td>
                            <asp:TextBox ID="txtNewPassword" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Retype new Password:
                        </td>
                        <td>
                            <asp:TextBox ID="txtRetypePassword" runat="server"></asp:TextBox>
                        </td>
                    </tr>
            </table>
            <asp:Button ID="btnReset" runat="server" Text="Reset Password" OnClick="btnReset_Click" />
        </asp:Panel>
    </div>
</asp:Content>
