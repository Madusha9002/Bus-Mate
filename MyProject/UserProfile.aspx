<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="E5.UserProfile" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, user-scalable=no"/>
    <script>
        $(function () {
            GetUserData();
            $('#btnUpdateUser').hide();
            $('#first_name').prop('disabled', true);
            $('#last_name').prop('disabled', true);
            $('#EmailAdd').prop('disabled', true);
            $('#mobile_no').prop('disabled', true);
        });
        function GetUserData() {
            var token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/GetUserData",
                data: JSON.stringify({
                    token: token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    LoadUserData(data[0]);
                },
                failure: function (response) {
                    alert(response.d);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function LoadUserData(data) {
            
            $('#userId').text(data.UserID);
            $('#first_name').val(data.FirstName);
            $('#last_name').val(data.LastName);
            $('#EmailAdd').val(data.Email);
            $('#mobile_no').val(data.MobilePhone);
        }
        function UpdateUserProfile() {
            var FirstName = $('#first_name').val();
            var LastName = $('#last_name').val();
            var Email = $('#EmailAdd').val();
            var MobilePhone = $('#mobile_no').val();
            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/UpdateUserProfile",
                data: JSON.stringify({
                    FirstName: FirstName, LastName: LastName, Email: Email, MobilePhone: MobilePhone, Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert(data.message);
                },
                failure: function (response) {
                    alert(response.d);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function ChangePassword() {
            var Password = $('#curr_password').val();
            var NewPassword = $('#new_password').val();
            var ConfPass = $('#confPass').val();
            if (NewPassword != ConfPass) { alert("Passwords mismatch!"); return; }
            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/ChangePassword",
                data: JSON.stringify({
                    Password: Password,NewPassword:NewPassword, Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#curr_password').val('');
                    $('#new_password').val('');
                    $('#confPass').val('');
                    alert(data.message);
                },
                failure: function (response) {
                    alert(response.d);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function MatchPass() {
            var NewPassword = $('#new_password').val();
            var ConfPass = $('#confPass').val();
            if (NewPassword != ConfPass) {
                document.getElementById('confPass').style.borderColor = "red";
            } else {
                document.getElementById('confPass').style.borderColor = "blue";
            }
        }
        function enableFeilds(FeildName) {
            $('#' + FeildName).prop('disabled', false);
            $('#btnUpdateUser').show();
        }
    </script>
    <div style="margin-top:1%">
        <div class="w3-padding w3-responsive w3-row w3-card-4 w3-border-blue w3-round-xlarge w3-center m12">
            <div class="w3-col">
                <img src="/images/avatar2.png" class="w3-circle" style="width:10%;height:10%;"/>
            </div>
            <div class="w3-col"><span class="User-id-font" id="userId"></span></div>
        </div>
        <div class="w3-responsive w3-col w3-margin-top ">
            <fieldset class="w3-border w3-border-blue w3-round-large w3-padding">
                <legend class="legend-font">User Data</legend>
                <div class="w3-col" title="First Name" ondblclick="enableFeilds('first_name');"><div class="m3 modal-font">First Name</div>
                    <span ><input id="first_name" required="required" placeholder="First Name" style="width:100%;"/></span>
                </div>
                <div class="w3-col" title="Last Name" ondblclick="enableFeilds('last_name');"><div class="m3 modal-font">Last Name</div>
                    <span><input id="last_name" required="required" placeholder="Last Name" style="width:100%;"/></span>
                </div>
                <div class="w3-col" title="Email" ondblclick="enableFeilds('EmailAdd');"><div class="m3 modal-font">Email</div>
                    <span><input id="EmailAdd" type="email" placeholder="Email" style="width:100%;"/></span>
                </div>
                <div class="w3-col" title="Mobile no" ondblclick="enableFeilds('mobile_no');"><div class="m3 modal-font">Mobile No</div>
                    <span><input id="mobile_no" placeholder="Mobile No" style="width:100%;"/></span>
                </div>
                <div id="div_save" class="w3-col m10 w3-padding w3-center w3-margin-left" >
                    <div id="btnUpdateUser" class="w3-button w3-blue m4 modal-font" onclick="UpdateUserProfile();" title="Save" style="text-shadow:0px 0px black"><span><i class="far fa-save"></i></span><span>Save</span></div>
                </div>
            </fieldset>
        </div>
        <div class="w3-responsive w3-col w3-margin-top ">
            <fieldset class="w3-border w3-border-blue w3-round-large w3-padding">
                <legend class="legend-font">Change Password</legend>
                <div id="curr_pass_div" class="w3-col" title="Current Password"><div class="m3 modal-font">Current Password</div>
                    <span><input id="curr_password" type="password" placeholder="Current Password" style="width:100%;"/></span>
                </div>
                <div id="pass_div" class="w3-col" title="New Password"><div class="m3 modal-font">New Password</div>
                    <span><input id="new_password" type="password" placeholder="New Password" style="width:100%;"/></span>
                </div>
                <div id="conpass_div" class="w3-col" title="Confirm Password"><div class="m3 modal-font">Confirm Password</div>
                    <span><input id="confPass" type="password" placeholder="Confirm Password" onkeyup="MatchPass();" style="width:100%;"/></span>
                </div>
                <div class="w3-col m10 w3-padding w3-center w3-margin-left" >
                    <div class="w3-button w3-blue m4 modal-font" onclick="ChangePassword();" title="Save" style="text-shadow:0px 0px black"><span><i class="far fa-save"></i></span><span>Save</span></div>
                </div>
            </fieldset>
        </div>
    </div>
    <style>
        .User-id-font{
            font-family:'Times New Roman', Times, serif;
            font-weight:600;
            font-size:large;
        }
        .legend-font{
            font-family:'Times New Roman', Times, serif;
            color:gray;
            font-size:large;
        }
    </style>
</asp:Content>
