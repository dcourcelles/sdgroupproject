<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TruphoxGP.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Register</h1>
        <p>Please fill in this form to create an account.</p>
        <hr>
        <br />
        <table>
            <tr>
                <td>
                    <label for="email"><b>Username</b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtUsername" placeholder="Enter Username" runat="server" Width="142px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="psw"><b>Password: </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtPassword" placeholder="Enter Password" runat="server" Width="142px" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="psw-repeat"><b>Repeat Password:&nbsp;&nbsp;&nbsp;&nbsp; </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtpswRepeat" placeholder="Repeat Password" runat="server" Width="142px" TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="email"><b>First Name: </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtFirst" placeholder="Enter First Name" runat="server" Width="142px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="email"><b>Last Name: </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtLast" placeholder="Enter Last Name" runat="server" Width="142px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="email"><b>DOB: </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtDOB" placeholder="Enter Date of Birth" runat="server" Width="142px" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="email"><b>Email: </b></label>
                </td>
                <td>
                    <asp:TextBox ID="txtEmail" placeholder="Enter Email" runat="server" Width="142px" TextMode="Email"></asp:TextBox>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        <br />
        <hr>
        <p>By creating an account you agree to our <a href="TAP.aspx">Terms & Privacy</a>.</p>
        <asp:Button ID="btnSubmit" runat="server" CssClass="registerbtn" Text="Submit" OnClick="btnSubmit_Click" />
    </div>
    <div class="container signin">
        <p>Already have an account? <a href="#">Sign in</a>.</p>
    </div>
</asp:Content>
