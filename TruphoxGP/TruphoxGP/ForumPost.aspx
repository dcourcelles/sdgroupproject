<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="ForumPost.aspx.cs" Inherits="TruphoxGP.ForumPost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <div class="header">               
               <a href="PhoxForums.aspx"><h1>PHOX FORUMS</h1></a> 
            </div>
            <div class="well well-lg">
                <div class="header">
                    <h2>
                        <asp:Label ID="lblTitle" runat="server" Text='<%#Eval("forumTitle") %>'></asp:Label>
                    </h2>
                </div>
                <asp:Label ID="lblUsername" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblPostID" runat="server" Text="" Visible="false"></asp:Label>
                <br />
                <asp:GridView ID="GVForumPost" runat="server" AutoGenerateColumns="false" CssClass="cssforum" HeaderStyle-CssClass="forumHeader" RowStyle-CssClass="forumRow">
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="Author" />
                        <asp:BoundField DataField="forumDate" HeaderText="Date" />
                        <asp:BoundField DataField="forumText" HeaderText="Post" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="well well-lg">
                <div class="header">
                    <h3>Replies</h3>
                </div>
                <asp:GridView ID="GVForumResponse" runat="server" AutoGenerateColumns="false" CssClass="cssforum" HeaderStyle-CssClass="forumHeader" 
                    AllowPaging="true" RowStyle-CssClass="forumRow" PageSize="5" PagerStyle-CssClass="forumPager" OnPageIndexChanging="GVForumResponse_PageIndexChanging" OnRowCommand="GVForumResponse_RowCommand"  >
                    <Columns>
                        <asp:BoundField DataField="username" HeaderText="Username" />
                        <asp:BoundField DataField="forumResDate" HeaderText="Date" />
                        <asp:BoundField DataField="forumResText" HeaderText="Response" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="well well-lg">
                 <div class="header">
                    <h3>Reply to Forum Post</h3>
                </div>
                <asp:TextBox ID="txtReplyForum" runat="server" TextMode="MultiLine" MaxLength="500" CssClass="forumReply"></asp:TextBox>
                <div class="header">
                    <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="likeButton" OnClick="btnReply_Click" />
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="col-sm-4">
            <div class="well">
                <h3>MORE FROM TRUPHOX</h3>
                <p>This space would've been used</p>
                <p>if we would've had more time in order to come </p>
                <p>up with something better than this long text rant.</p>
            </div>
            <div class="well">
                <h3>MORE FROM TRUPHOX</h3>
                <p>There is nothing here either.</p>
            </div>
        </div>
    </div>

</asp:Content>
