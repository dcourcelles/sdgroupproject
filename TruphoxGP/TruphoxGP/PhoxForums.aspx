<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="PhoxForums.aspx.cs" Inherits="TruphoxGP.PhoxFourms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <div class="header">
                <h1>PHOX FORUMS</h1>
            </div>            
            <asp:Panel ID="pnlLoginDiv" runat="server" Visible="false">
                <div class="well">
                    <div class="header">
                        <h3>PLEASE LOGIN TO VIEW FORMS</h3>
                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="likebutton" OnClick="btnLogin_Click" Width="500px" />
                    </div>
                </div>
            </asp:Panel>
            <div class="well well-lg">
                <asp:GridView ID="gvForum" runat="server" DataKeyNames="forumID" AutoGenerateColumns="false" CssClass="cssforum" PagerStyle-CssClass="forumPager" HeaderStyle-CssClass="forumHeader"
                    RowStyle-CssClass="forumRow" AllowPaging="true" OnPageIndexChanging="gvForum_PageIndexChanging" PageSize="3" AllowSorting="true" OnRowCommand="gvForum_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="forumTitle" HeaderText="Title" />
                        <asp:BoundField DataField="forumText" HeaderText="Text" />
                        <asp:BoundField DataField="username" HeaderText="Author" />
                        <asp:BoundField DataField="forumDate" HeaderText="DatePublished" />
                        <asp:CheckBoxField DataField="rating" HeaderText="Mature?" />
                        <asp:ButtonField ButtonType="button" Text="Read More" CommandName="More" />
                    </Columns>
                </asp:GridView>
            </div>
            <asp:Button ID="btnCreate" runat="server" CssClass="btn-info" Text="New Forum" OnClick="btnCreate_Click" />
            <asp:Panel runat="server" ID="pnlcreateForum" Visible="false">
                <div class="row content">
                    <div class="leftcolumn">
                        <br>
                        <div style="padding: 30px">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#home">FORUMS</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="home" class="tab-pane fade in active">
                                    <h2>Title: </h2>
                                    <asp:TextBox ID="txtforumTitle" runat="server"></asp:TextBox>
                                    <h2>Text: </h2>
                                    <asp:TextBox ID="txtForumText" runat="server" Height="100px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                                    <br />
                                    Does your forum contain mature content?
                                    <asp:RadioButtonList ID="rblMature" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblMature_SelectedIndexChanged">
                                        <asp:ListItem Value="1">Yes </asp:ListItem>
                                        <asp:ListItem Value="2"> No</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:Label ID="lblMature" runat="server" Text="This post has mature content and will only be viewed by people over 16." Visible="false"></asp:Label>
                                    <br />
                                    <asp:Button ID="btnSubmitForum" runat="server" Text="Submit Thread" OnClick="btnSubmitForum_Click" />
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <div class="col-sm-4">
            <div class="well">
                <h3>MORE FROM TRUPHOX</h3>
                <p>Something could have been here.</p>
                <p>Did not have the time to come up with something.</p>
            </div>
            <div class="well">
                <h3>MORE FROM TRUPHOX</h3>
                <p>
                    <asp:DataList ID="dlUnion" runat="server" DataKeyField="postID" OnItemCommand="dlUnion_ItemCommand" RepeatColumns="3" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" ImageUrl='<%#Eval("Images") %>' CssClass="img-circle" Height="90px" max-width="90px" CommandName="post" />
                            <asp:Label ID="lblType" runat="server" Text='<%#Eval("type") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                </p>
            </div>
        </div>
    </div>
</asp:Content>
