<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TruphoxGP.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
       <li data-target="#myCarousel" data-slide-to="3"></li>
    </ol>
           <div class="carousel-inner" role="listbox">
      <div class="item active">
        <img src="Images/mountains.jpg" alt="Art" width="1200" height="700">
        <div class="carousel-caption">
          <h3>ART</h3>
            <p>An ordinary significance</p>
        </div>      
      </div>
                   <div class="item">
        <img src="Images/camera.jpg" alt="Photography" width="1200" height="700">
        <div class="carousel-caption">
          <h3>PHOTOGRAPHY</h3>
            <p>The art of producing images of objects on sensitized surfaces by chemic actions of light and energy.</p>
        </div>      
      </div>
        <div class="item">
        <img src="Images/lights.jpg" alt="Videos" width="1200" height="700">
        <div class="carousel-caption">
          <h3>VIDEO</h3>
            <p>Reception of an image</p>
        </div>      
      </div>
              <div class="item">
        <img src="Images/convet.jpg" alt="Writting" width="1200" height="400">
        <div class="carousel-caption">
          <h3>LITERATURE</h3>
            <p>Connection with ideas of permanent and universal interest</p>
        </div>      
      </div>
    </div>
        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
</div>
    <div id="band" class="container text-center">
        <h3>WELCOME TO TRUPHOX!</h3>
        <p><strong>A website for even the most novice of artists, videographers and poets. </strong></p>
        <p><strong> Share your creativity, like and share other ones and join the community that will accept you where ever you are...</strong></p>
    </div>
</asp:Content>
