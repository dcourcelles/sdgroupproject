<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="submitPhotography.aspx.cs" Inherits="TruphoxGP.submitPhotography" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlSubmit" runat="server" Visible="false">
        <div class="container-fluid text-center">
            <br />
            <h3>SUBMIT PHOTOGRAPHY</h3>
        </div>
        <div style="padding: 30px">
            <asp:Label ID="lblFU" runat="server" Text="Choose a file to upload "></asp:Label>
            <asp:FileUpload ID="fuPhotography" runat="server" />
            <br />
            <asp:Label ID="lblTitle" runat="server" Text="Photography Title"></asp:Label>
            <br />
            <asp:TextBox ID="txtTitle" runat="server" Width="240px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" EnableClientScript="false" ErrorMessage="Please Enter a Title" ControlToValidate="txtTitle"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="lblSub" runat="server" Text="Photography Subtitle"></asp:Label>
            <br />
            <asp:TextBox ID="txtSubtitle" runat="server" Width="242px"></asp:TextBox>
            <br />
            <asp:Label runat="server" Text="Does your image contain mature content?"></asp:Label>
            <asp:RadioButtonList ID="rblMature" runat="server">
                <asp:ListItem Value="1">Yes </asp:ListItem>
                <asp:ListItem Value="2" Selected="True"> No</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="lblMature" runat="server" Text="This post has mature content and will only be viewed by people over 16." Visible="false"></asp:Label>
            <br />
            <asp:Button ID="btnSubmitPhotography" runat="server" Text="Submit Thread" OnClick="btnSubmitPhotography_Click" />
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlUpdate" runat="server" Visible="false">
             <div class="container-fluid text-center">
            <br />
            <h3>UPDATE PHOTOGRAPHY</h3>
        </div>
        <div style="padding: 30px">
            <asp:Label ID="lblPostID" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="lblUTitle" runat="server" Text="Photography Title"></asp:Label>
            <br />
            <asp:TextBox ID="txtUTitle" runat="server" Width="240px"></asp:TextBox>
            <br />
            <asp:Label ID="lblUSubtitle" runat="server" Text="Photography Subtitle"></asp:Label>
            <br />
            <asp:TextBox ID="txtUSubtitle" runat="server" Width="242px"></asp:TextBox>
            <br /><br />
            <asp:Image ID="imgPrevPhotography" runat="server" CssClass="imgPreview" Width="800px" Height="" />
            <br />
            <asp:Label runat="server" Text="Does your image contain mature content?"></asp:Label>
            <asp:RadioButtonList ID="rblUMature" runat="server" RepeatDirection="Vertical">
                <asp:ListItem Value="1">Yes </asp:ListItem>
                <asp:ListItem Value="2" Selected="True"> No</asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="lblUMature" runat="server" Text="This post has mature content and will only be viewed by people over 16." Visible="false"></asp:Label>
            <br />
            <asp:Button ID="btnUpdatePhotography" runat="server" Text="Submit Updated Photography" OnClick="btnUpdatePhotography_Click" />
        </div>
    </asp:Panel>
</asp:Content>
