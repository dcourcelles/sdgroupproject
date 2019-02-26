<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Post.aspx.cs" Inherits="TruphoxGP.Post" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <br />
            <div class="header">
                <h1>
                    <asp:Label ID="lblPostTitle" runat="server" Text=""></asp:Label></h1>
                <h3>
                    <asp:Label ID="lblPostSubtitle" runat="server" Text=""></asp:Label></h3>
            </div>
            <div class="row content">
                <div class="leftcolumn">
                    <%-- Artwork --%>
                    <asp:Panel ID="pnlArtwork" runat="server" Visible="false">
                        <asp:Image ID="imgArtwork" runat="server" CssClass="PostImage" />
                    </asp:Panel>

                    <%-- Writing --%>
                    <asp:Panel ID="pnlWriting" runat="server" Visible="false">
                        <p>
                            <asp:Label ID="lblWriting" runat="server" Text=""></asp:Label>
                        </p>
                    </asp:Panel>

                    <%-- Photography --%>
                    <asp:Panel ID="pnlPhotography" runat="server" Visible="false">
                        <asp:Image ID="imgPhotography" runat="server" CssClass="PostImage" />
                    </asp:Panel>

                    <%-- Video --%>
                    <asp:Panel ID="pnlVideo" runat="server" Visible="false">
                        <video id="postVideo" runat="server" controls="controls" width="800">
                        </video>
                    </asp:Panel>

                    <div class="row">
                        <div class="col-sm-4">
                            <a class="label label-danger fa-2x" style="background-color: #FF5733">
                                <i class="fa fa-heart "></i>
                                <asp:Label ID="lblLikes" runat="server" Text=""></asp:Label>
                            </a>
                            <br />
                            <asp:Panel ID="pnlLike" runat="server" Visible="false">
                                    <asp:Button ID="btnLike" runat="server" Text="Like" OnClick="btnLike_Click" CssClass="likeButton" />
                            </asp:Panel>
                            <p></p>
                            <br>
                        </div>
                    </div>

                    <div style="padding: 30px">
                        <h3 class="text-center">COMMENTS</h3>
                        <asp:Panel ID="pnlComments" runat="server" Visible="false">
                            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" CssClass="commentTextBox"></asp:TextBox>
                            <br />
                            <asp:Button ID="btnComment" runat="server" Text="Comment" OnClick="btnComment_Click" />
                        </asp:Panel>
                        <br />
                        <br />
                        <br />
                        <div>
                            <%-- Div created for grabElementByID in Javascript section. Comments will be loaded here --%>
                            <div id="comments">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />
        <div class="col-sm-4">
            <div class="well">
                <h1>
                    <asp:LinkButton ID="lnkBtnUsername" runat="server" OnClick="lnkBtnUsername_Click">
                        <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label>
                    </asp:LinkButton></h1>
            </div>
            <asp:Panel ID="pnlEditPost" runat="server" Visible="false">
                <div class="well">
                    <asp:Button ID="btnEditPost" runat="server" Text="Edit" OnClick="btnEditPost_Click" />
                    <asp:Button ID="btnDeletePost" runat="server" Text="Delete" OnClick="btnDeletePost_Click" />
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlEdit" runat="server" Visible="false">
                <div class="well">
                    <table>
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <div class="well">
                <h3>MORE FROM USER</h3>
                <p>
                    <asp:DataList ID="dlMoreUser" runat="server" DataKeyField="postID" RepeatColumns="3" RepeatDirection="Horizontal" OnItemCommand="dlMoreUser_ItemCommand">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" ImageUrl='<%#Eval("Images") %>' CssClass="img-circle" Height="100px" max-width="100px" CommandName="post" />
                            <asp:Label ID="lblType" runat="server" Text='<%#Eval("type") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                </p>
            </div>
        </div>
    </div>

    <script>        
        $(document).ready(function () {
            var postID = getUrlParameter('postID');
            getComments(postID);
        });

        function getComments(postID) {
            $.ajax({
                type: "POST",
                url: "readComment.ashx",//handler
                cache: false,
                data: { "postID": postID },
                success: function (data) {
                    comments(data);
                },
                err: function (error) {
                    alert(error);
                }
            });
        };

        function comments(data) {
            //Get comment section created that will be used to append comment HTML created
            var sectionComments = document.getElementById("comments");
            var comment = JSON.parse(data);

            //loop through each comment for the post and create required elements for a comment
            for (i in comment.Table) {
                c = comment.Table[i];
                var divComments = document.createElement("div");
                divComments.setAttribute('id', 'c' + i);
                divComments.innerHTML = (
                    "<div class='well well-sm'>"
                    + "<div class='w3-row'>" + "<hr>"
                    + "<div class='w3-col l2 m3'>"
                    + "<img src='./Images/" + c.profileImage + "' class='img-circle commentPic'/>"
                    + "<br/>" + "</div>"
                    + "<div class='w3-col l10 m9'>"
                    + "<a href=''>" + c.username + "</a><br />" + "<span class='w3-opacity w3-medium'>" + c.commentDate
                    + "</span>" + "<br />" + "<br />"
                    + "<div class='usercomment'>" + c.commentText + "</div>" + "<br />");                 
                sectionComments.appendChild(divComments);
            };
        };

        function getUrlParameter(name) {
            name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
            var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
            var results = regex.exec(location.search);
            return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
        };

        function likeComment(commentID) {
            $.ajax({
                type: "POST",
                url: "likeComment.ashx", //handler
                cache: false,
                data: { "commentID": commentID },
                success: function () {
                    readCommentLikes()
                },
                err: function (error) {
                    alert("error");
                }
            });
            return false;
        };

        function replyComment() {
            var postID = getUrlParameter('postID');
            var commentText = getElementById("txtComment");
            alert(commentText);
            $.ajax({
                type: "POST",
                url: "replyComment.ashx", //handler
                cache: false,
                data: { postID, commentText },
                success: function () {
                },
                err: function (error) {
                    alert(error);
                }
            });
            return false;
        };
    </script>
</asp:Content>
