<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="viewProfile.aspx.cs" Inherits="TruphoxGP.viewProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <br />
            <div class="header">
                          <asp:Image ID="imgProfilePicture" runat="server" ImageUrl='<%#Eval("profileImage") %>' CssClass="img-circle person" Width="155" Height="155"  />
                   <h1><asp:Label ID="lblUsername" runat="server" Text=""></asp:Label></h1>
                <div class="btn-group" role="group">
                        <asp:Button ID="btnFollow" CssClass="btn btn-secondary" runat="server" Text="Follow" OnClick="btnFollow_Click" style="height: 44px" />
                    <asp:Button ID="btnBlock" CssClass="btn btn-secondary" runat="server" Text="Block" style="height: 44px" OnClick="btnBlock_Click" />
                </div>
            </div>
            <br />
            <div class="row content">
                <div class="leftcolumn">
                    <div class="well">
                        <h2>Recently Added</h2>
                        <div class="row">
                            <div class="col-sm-4">
                                 <br>
                                <a href="#demo" data-toggle="collapse">
                                    <asp:Image ID="imgRecent" runat="server" src="Images/phox.jpg" class="img-circle person" Width="155" Height="155" />
                                </a>
                                <div id="demo" class="collapse">
                                    <p>
                                        <asp:Label ID="lblpostID" runat="server" Text=""></asp:Label>
                                    </p>
                                    <h2>
                                        <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                                    </h2>
                                    <p>
                                        <asp:Label ID="lblSubTitle" runat="server" Text=""></asp:Label>
                                    <p>
                                    <p>
                                        <asp:Label ID="lblDateCreated" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                   <br>
                                <a href="#demo2" data-toggle="collapse">
                                    <asp:Image ID="imgRecent2" runat="server" src="Images/phox.jpg" class="img-circle person" Width="155" Height="155" />
                                </a>
                                <div id="demo2" class="collapse">
                                    <p>
                                        <asp:Label ID="lblpostID2" runat="server" Text=""></asp:Label>
                                    </p>
                                    <h2>
                                        <asp:Label ID="lblTitle2" runat="server" Text=""></asp:Label>
                                    </h2>
                                    <p>
                                        <asp:Label ID="lblSubTitle2" runat="server" Text=""></asp:Label>
                                    </p>
                                    <p>
                                        <asp:Label ID="lblDateCreated2" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <br>
                                <a href="#demo3" data-toggle="collapse">
                                    <asp:Image ID="imgRecent3" runat="server" src="Images/phox.jpg" class="img-circle person" Width="155" Height="155" />
                                </a>
                                <div id="demo3" class="collapse">
                                    <p>
                                        <asp:Label ID="lblpostID3" runat="server" Text=""></asp:Label>
                                    </p>
                                    <h2>
                                        <asp:Label ID="lblTitle3" runat="server" Text=""></asp:Label>
                                    </h2>
                                    <p>
                                        <asp:Label ID="lblSubTitle3" runat="server" Text=""></asp:Label>
                                    </p>
                                    <p>
                                        <asp:Label ID="lblDateCreated3" runat="server" Text=""></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div style="padding: 30px">
                        <h3 class="text-center">POSTS</h3>
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#home">ART</a></li>
                            <li><a data-toggle="tab" href="#menu1">PHOTOGRAPHY</a></li>
                            <li><a data-toggle="tab" href="#menu2">VIDEO</a></li>
                            <li><a data-toggle="tab" href="#menu3">LITERATURE</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="home" class="tab-pane fade in active">
                              <asp:DataList ID="dlArt" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" DataKeyField="postID" CssClass="profileDL" OnItemCommand="dlArt_ItemCommand">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                        <br />
                                        <asp:ImageButton ID="ibArt" runat="server" ImageUrl='<%#Eval("artLink") %>' CommandName="Select" CssClass="ATrendImages" />
                                        <br />
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div id="menu1" class="tab-pane fade">
                             <h2>PHOTOGRAPHY</h2>
                                <asp:DataList ID="dlPhotots" runat="server" RepeatDirection="Horizontal" RepeatColumns="2"  DataKeyField="postID" CssClass="profileDL" OnItemCommand="dlPhotots_ItemCommand">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPpostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                        <br />
                                        <asp:ImageButton ID="ibPhotography" runat="server" ImageUrl='<%#Eval("photoLink") %>' CommandName="Select" CssClass="ATrendImages" />
                                        <br />
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div id="menu2" class="tab-pane fade">
                                <h2>VIDEOS</h2>
                                <asp:DataList ID="dlVideos" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" DataKeyField="postID" CssClass="profileDL" OnItemCommand="dlVideos_ItemCommand">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVpostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                        <br />
                                        <asp:ImageButton ID="ibVideos" runat="server" ImageUrl='<%#Eval("videoLink") %>' CommandName="Select" CssClass="ATrendImages" />
                                        <br />
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div id="menu3" class="tab-pane fade">
                                <h2>LITERATURE</h2>
                                <asp:DataList ID="dlWriting" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" CssClass="userWriting, profileDL"  DataKeyField="postID" RepeatLayout="Flow" OnItemCommand="dlWriting_ItemCommand">
                                    <ItemTemplate>
                                        <div class="literature" <%--style="overflow:auto;"--%>>
                                            <asp:Label ID="lblWpostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="lblWriting" CssClass="" runat="server" Text='<%#Eval("writingText") %>' CommandName="Select"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
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
                <p>
                    <asp:Label ID="lblFirstName" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblLastName" runat="server" Text=""></asp:Label>
                </p>
                <p>
                    <asp:TextBox ID="txtBio" ReadOnly="true" runat="server" TextMode="MultiLine" CssClass="profileBio"></asp:TextBox>
                </p>
                <p>
                    <asp:Label ID="lblDOB" runat="server" Text=""></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                </p>
                <p>
                    <asp:Label ID="lblDateJoined" runat="server" Text=""></asp:Label>
                </p>
            </div>
            <div class="well">
               <h3>FOLLOWING</h3>
                <div class="Following">
                    <asp:DataList ID="dlFollowing" runat="server" OnItemCommand="dlFollowing_ItemCommand" DataKeyField="followedUser">
                          <ItemTemplate>
                            <br />
                         <asp:LinkButton ID="lnkFollowed" runat="server" Text='<%#Eval("followedUser") %>' CommandName="Select"></asp:LinkButton> 
                            <br />
                        </ItemTemplate>
                    </asp:DataList>
                </div>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
