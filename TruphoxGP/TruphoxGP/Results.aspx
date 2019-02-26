<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="TruphoxGP.Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <div class="col-sm-8 text-left">
            <div class="header resultDiv">
                <img src="Images/foxx.jpg" class="resultHeader" />
            </div>
            <div class="row content">
                <div class="leftcolumn">
                    <asp:DataList ID="dlUnity" runat="server" RepeatColumns="3" CssClass="" DataKeyField="postID" OnItemCommand="dlUnity_ItemCommand" Width="791px">
                        <ItemTemplate>
                            <div class="resultDiv">
                                <div class="header">
                                    <asp:Label ID="lblPostID" runat="server" Text='<%#Eval("postID") %>' Visible="false"></asp:Label>
                                    <h1><asp:Button ID="btnSelect" runat="server" Text='<%#Eval("postTitle") %>' CommandName="Select" CssClass="SearchHL" /></h1>
                                    <asp:Label ID="lblType" runat="server" Text='<%#Eval("type") %>' Visible="false"></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <div class="resultDiv">
                        <asp:DataList ID="dlUserSearch" runat="server" RepeatColumns="4" DataKeyField="username" OnItemCommand="dlUserSearch_ItemCommand" Width="791px">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgUser" CommandName="Select" runat="server" ImageUrl='<%#Eval("profileImage") %>' CssClass="img-circle person" Width="255" Height="255" />
                                <h1><asp:Label ID="lblUsername" runat="server" Text='<%#Eval("username") %>' CssClass="resultUser"></asp:Label></h1>
                                <br />
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                    <br>
                    <asp:Label ID="lblNotFound" runat="server" Visible="false" Text=""></asp:Label>
                </div>
            </div>
        </div>
      <br />
    </div>
</asp:Content>
