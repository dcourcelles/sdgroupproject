<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="submitLit.aspx.cs" Inherits="TruphoxGP.submitLit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlSubmit" runat="server">
    <div class="container-fluid text-center">
        <br />
        <h3>SUBMIT LITERATURE</h3>
    </div>
    <div style="padding: 30px">
        <asp:Label ID="lblTitle" runat="server" Text="Lit Title"></asp:Label>
        <br />
        <asp:TextBox ID="txtTitle" runat="server" Width="240px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblSub" runat="server" Text="Lit Subtitle"></asp:Label>
        <br />
        <asp:TextBox ID="txtSubtitle" runat="server" Width="242px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblWritingText" runat="server" Text="Lit Text"></asp:Label>
        <br />
        <asp:TextBox ID="txtWriting" runat="server" Width="442px" Height="166px" TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <asp:Label runat="server" Text="Does your text contain  mature content?"></asp:Label>
        <asp:RadioButtonList ID="rblMature" runat="server">
            <asp:ListItem Value="1">Yes </asp:ListItem>
            <asp:ListItem Value="2" Selected="True"> No</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="lblMature" runat="server" Text="This post has mature content and will only be viewed by people over 16." Visible="false"></asp:Label>
        <br />
        <asp:Button ID="btnSubmitLit" runat="server" Text="Submit Thread" OnClick="btnSubmitLit_Click" />
    </div>
        </asp:Panel>
    <asp:Panel ID="pnlUpdate" runat="server" Visible="false">
            <div class="container-fluid text-center">
        <br />
        <h3>UPDATE LITERATURE</h3>
    </div>
       <div style="padding: 30px">
        <asp:Label ID="lblPostID" runat="server" Text=""></asp:Label>
        <br />
        <asp:Label ID="lblUTitle" runat="server" Text="Lit Title"></asp:Label>
        <br />
        <asp:TextBox ID="txtUTitle" runat="server" Width="240px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblUSubtitle" runat="server" Text="Lit Subtitle"></asp:Label>
        <br />
        <asp:TextBox ID="txtUSubtitle" runat="server" Width="242px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="lblUText" runat="server" Text="Lit Text"></asp:Label>
        <br />
        <asp:TextBox ID="txtUText" runat="server" Width="442px" Height="166px" TextMode="MultiLine"></asp:TextBox>
        <br />
        <br />
        <asp:Label runat="server" Text="Does your text contain  mature content?"></asp:Label>
        <asp:RadioButtonList ID="rblUMature" runat="server">
            <asp:ListItem Value="1">Yes </asp:ListItem>
            <asp:ListItem Value="2" Selected="True"> No</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="Label4" runat="server" Text="This post has mature content and will only be viewed by people over 16." Visible="false"></asp:Label>
        <br />
        <asp:Button ID="btnUpdateLit" runat="server" Text="Submit Thread" OnClick="btnUpdateLit_Click" />
    </div>
    </asp:Panel>
</asp:Content>
