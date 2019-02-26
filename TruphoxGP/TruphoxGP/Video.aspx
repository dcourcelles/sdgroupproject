<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Video.aspx.cs" Inherits="TruphoxGP.Video" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="band" class="container text-center">
        <h3>VIDEOS</h3>
        <asp:DataList ID="dlVideoTrending" runat="server" OnItemCommand="dlVideoTrending_ItemCommand" RepeatDirection="Horizontal" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:LinkButton ID="videoLinks" runat="server" CommandName="Select">
                    <asp:Label ID="VideoTitle" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label>
                </asp:LinkButton>
                <br />
                <video controls="controls" width="200" height="200" src='<%#Eval("videoLink") %>' />
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="dlVideoRecent" runat="server" OnItemCommand="dlVideoRecent_ItemCommand" RepeatDirection="Horizontal" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:Label ID="lblATrend" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label>
                <br />
                <video controls="controls" width="200" height="200" src='<%#Eval("videoLink") %>' />
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="dlVideoFav" runat="server" OnItemCommand="dlVideoFav_ItemCommand" RepeatDirection="Horizontal" DataKeyField="postID" RepeatColumns="3">
            <ItemTemplate>
                <asp:Label ID="lblpostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                <br />
                <asp:Label ID="lblATrend" runat="server" Text='<%#Eval("postTitle") %>' CssClass="postTitle"></asp:Label>
                <br />
                <video controls="controls" width="200" height="200" src='<%#Eval("videoLink") %>' />
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
