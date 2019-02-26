<%@ Page Title="" Language="C#" MasterPageFile="~/MasterSupreme.Master" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="TruphoxGP.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid text-center">
        <br />
        <h3 class="notificationTitle">NOTIFICATIONS</h3>
        <div class="well">            
            <div id="notifications">
                
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            getNotifications();
        });

        function getNotifications() {
            $.ajax({
                type: "GET",
                url: "readNotification.ashx",//handler
                cache: false,
                data: {},
                success: function (data) {
                    notification(data);
                },
                err: function (error) {
                    alert("error");
                }
            });
        }

        function notification(data) {
            //Get notification div created that will be used to append notification HTML created
            var sectionNotification = document.getElementById("notifications");
            var notification = JSON.parse(data);

            //loop through each notification for the post and create required elements for a notification
            for (i in notification.Table) {
                n = notification.Table[i];
                var divNotification = document.createElement("div");
                divNotification.innerHTML = (
                    "<div class='well'>" +
                    "<p class='notificationText'>" + n.notificationText + "</p>" +
                    "<p class='notificationDateText'>" + n.notificationDate + "</p>" +
                    "</div><br />"                    
                );
                sectionNotification.appendChild(divNotification);
            }
        }
    </script>
</asp:Content>
