<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Photography.aspx.cs" Inherits="TruphoxGP.Photography" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="band" class="container text-center">
        <h3>PHOTOGRAPHY</h3>
        <asp:DataList ID="dlPhotoTrending" runat="server" OnItemCommand="dlPhotoTrending_ItemCommand" Width="791px" RepeatDirection="Horizontal" CssClass="dlATrend" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:ImageButton ID="imgPTrend" CssClass="ATrendImages" runat="server" CommandName="Select" ImageUrl='<%#Eval("photoLink") %>' />
                <br />
                <asp:Label ID="lblPostTitle" runat="server" Text='<%#Eval("postTitle") %>'  CssClass="postTitle"></asp:Label>
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="dlPhotoRecent" runat="server" OnItemCommand="dlPhotoRecent_ItemCommand" Width="791px" RepeatDirection="Horizontal" CssClass="dlATrend" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:ImageButton ID="imgATrend" CssClass="ATrendImages" runat="server" CommandName="Select" ImageUrl='<%#Eval("photoLink") %>' />
                <br />
                <asp:Label ID="lblATrend" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label>
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="dlPhotoFav" runat="server" OnItemCommand="dlPhotoFav_ItemCommand" Width="791px" RepeatDirection="Horizontal" CssClass="dlATrend" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:ImageButton ID="imgATrend" CssClass="ATrendImages" runat="server" CommandName="Select" ImageUrl='<%#Eval("photoLink") %>' />
                <br />
                <asp:Label ID="lblATrend" runat="server" Text='<%#Eval("postTitle") %>'  CssClass="postTitle"></asp:Label>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
