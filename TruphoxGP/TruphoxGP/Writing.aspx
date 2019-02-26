<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Writing.aspx.cs" Inherits="TruphoxGP.Writing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="band" class="container text-center">
        <h3>LITERATURE</h3>
        <asp:DataList ID="dlWriteTrending" runat="server" Width="791px" RepeatDirection="Horizontal" RepeatColumns="3"  DataKeyField="postID" OnItemCommand="dlWriteTrending_ItemCommand">
            <ItemTemplate>
                <div class="form-group">
                <div class="well well-lg">
                    <asp:LinkButton ID="lnkLitPosts" runat="server"  CommandName="Select"><asp:Label ID="lblTwritingTitle" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label></asp:LinkButton>
                <br />
                <asp:Label ID="lblTwritingSub" runat="server" Text='<%#Eval("postSubTitle") %>'></asp:Label>
                <br />
                  <div class="literature" id="Text">
                <asp:Label ID="lblTwritingText" runat="server" Text='<%#Eval("writingText") %>' CssClass="literature"></asp:Label>
                    </div>
                    <br />
                    </div>
                    </div>
            </ItemTemplate>
        </asp:DataList>
        <hr />
        <asp:DataList ID="dlWriteRecent" runat="server" Width="791px" RepeatDirection="Horizontal" RepeatColumns="3" CssClass="dlATrend" DataKeyField="postID" OnItemCommand="dlWriteRecent_ItemCommand">
            <ItemTemplate>
                <div class="form-group">
                <div class="well well-lg">
             <asp:LinkButton ID="lnkLitRPosts" runat="server"><asp:Label ID="lblTwritingTitle" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label></asp:LinkButton>
                <br />
                <asp:Label ID="lblTwritingSub" runat="server" Text='<%#Eval("postSubTitle") %>'></asp:Label>
                <br />
                  <div class="literature" id="Text">
                <asp:Label ID="lblTwritingText" runat="server" Text='<%#Eval("writingText") %>' CssClass="literature"></asp:Label>
                    </div>
                    </div>
                    </div>
            </ItemTemplate>
        </asp:DataList>
        <hr />
        <asp:DataList ID="dlWriteFav" runat="server" Width="791px" RepeatDirection="Horizontal" RepeatColumns="3" CssClass="dlATrend" DataKeyField="postID" OnItemCommand="dlWriteFav_ItemCommand">
            <ItemTemplate>
                <div class="form-group">
                <div class="well well-lg">
                  <asp:LinkButton ID="lnkLitFPosts" runat="server"><asp:Label ID="lblTwritingTitle" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label></asp:LinkButton>
                <br />
                <asp:Label ID="lblTwritingSub" runat="server" Text='<%#Eval("postSubTitle") %>'></asp:Label>
                <br />
                  <div class="literature" id="Text">
                <asp:Label ID="lblTwritingText" runat="server" Text='<%#Eval("writingText") %>' CssClass="literature"></asp:Label>
                    </div>
                    </div>
                    </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
