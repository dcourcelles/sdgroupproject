<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TruphoxGP.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <br />
            <div class="header">
                <asp:Image ID="imgProfilePicture" runat="server" ImageUrl='<%#Eval("profileImage") %>' CssClass="img-circle person" Width="155" Height="155" />
                <h1>
                    <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label></h1>
                <div class="btn-group" role="group">
                    <asp:Button ID="btnPictureEdit" CssClass="btn btn-secondary" runat="server" Text="Profile Picture" Width="184px" OnClick="btnPictureEdit_Click" />
                    <asp:Button ID="btnEdit" CssClass="btn btn-secondary" runat="server" Text="Settings" Width="184px" OnClick="btnEdit_Click" />
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
                                <h2>ARTWORK</h2>
                                <asp:DataList ID="dlArt" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" OnItemCommand="dlArt_ItemCommand" DataKeyField="postID" CssClass="profileDL">
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
                                <asp:DataList ID="dlPhotots" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" OnItemCommand="dlPhotots_ItemCommand" DataKeyField="postID" CssClass="profileDL">
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
                                <asp:DataList ID="dlVideos" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" OnItemCommand="dlVideos_ItemCommand" DataKeyField="postID" CssClass="profileDL">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVpostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                        <br />
                                        <video controls="controls" width="200" height="200" src='<%#Eval("videoLink") %>' />
                                        <br />
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <%-- TURN LITERATURE INTO A PHOTO...???--%>
                            <div id="menu3" class="tab-pane fade">
                                <h2>LITERATURE</h2>
                                <asp:DataList ID="dlWriting" runat="server" RepeatDirection="Horizontal" RepeatColumns="2" CssClass="userWriting, profileDL" OnItemCommand="dlWriting_ItemCommand" DataKeyField="postID" RepeatLayout="Flow">
                                    <ItemTemplate>
                                        <div class="literature" <%--style="overflow:auto;"--%>>
                                            <asp:Label ID="lblWpostID" runat="server" Text='<%#Eval("postID") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="lblWriting" CssClass="" runat="server" Text='<%#Eval("writingText") %>' CommandName="Select"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <%--  <SeparatorStyle BorderStyle="Ridge" />--%>
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
            <asp:Panel ID="pnlEdit" runat="server" Visible="false">
                <div class="well">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblBio" runat="server" Text="Bio"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBioEdit" runat="server" TextMode="MultiLine" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblUsernameEdit" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>First Name:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            </td>
                            <td>
                                <asp:TextBox ID="txtFirstNameEdit" runat="server" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            </td>
                            <td>
                                <asp:TextBox ID="txtLastNameEdit" runat="server" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>DOB:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            </td>
                            <td>
                                <asp:TextBox ID="txtDOBEdit" runat="server" TextMode="Date" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Email:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmailEdit" runat="server" TextMode="Email" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Password:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassEdit" runat="server" TextMode="Password" Width="192px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Confirm Pass:
                            </td>
                            <td>
                                <asp:CompareValidator ID="cvPasswords" EnableClientScript="false" runat="server" ErrorMessage="Passwords must Match" ControlToCompare="txtPassConfirm" ControlToValidate="txtPassEdit"></asp:CompareValidator>
                                <asp:TextBox ID="txtPassConfirm" runat="server" TextMode="Password" Width="184px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Button ID="btnSave" CssClass="btn" runat="server" Text="Save" Width="192px" OnClick="btnSave_Click" />
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlImgChanges" runat="server" Visible="false">
                <div class="well">
                    Preview Image: 
                    <input type='file' id="imgInp" />
                    <img id="profileImgFU" src="#" alt="your image" class="img-circle person" width="155" height="155" />
                    <br />
                    Upload Image: 
                      <asp:FileUpload ID="fuProfileImage" runat="server" />
                    <asp:Button ID="btnSaveProfilePicture" CssClass="btn" runat="server" Text="Save" Width="192px" OnClick="btnSaveProfilePicture_Click" />
                </div>
            </asp:Panel>
            <div class="well">
                <h3>FOLLOWING</h3>
                <div class="Following">
                    <asp:DataList ID="dlFollowing" runat="server" OnItemCommand="dlFollowing_ItemCommand" DataKeyField="followedUser">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkFollowed" runat="server" Text='<%#Eval("followedUser") %>' CommandName="Select"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
                <br />
            </div>
           
        </div>
    </div>

    <script>        
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#profileImgFU').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#imgInp").change(function () {
            readURL(this);
        });

    </script>
</asp:Content>
