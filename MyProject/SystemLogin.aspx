<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="SystemLogin.aspx.cs" Inherits="MyProject.SystemLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="css/w3.css" rel="stylesheet" />
    <link href="css/CustomStyle.css" rel="stylesheet" />
    <script src="Js/cookiefile.js"></script>
    <%--<script  src="https://code.jquery.com/jquery-3.2.1.min.js"  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="  crossorigin="anonymous"></script>--%>
    <script src="Js/jquery-3.2.1.min.js"></script>
    <script>
        $(function () {
            document.getElementById('contain1').style.display = 'none';
        });
        function login() {
            var user_id = $('#userid').val();
            var password = $('#password').val();

            $.ajax({
                type: "POST",
                url: "api/access/login",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ user_id: user_id, password: password }),
                dataType: "json",
                success: function (data) {
                    //fill_table(data);
                    $('#error_message').text('');
                    if (data.status == 0) {
                        $('#error_message').text(data.message);
                        setCookie('erptk', 'COOKEIE VALUE NOT SET', 0);
                    }
                    else {
                        setCookie('erptk', data.para1, 1);
                        window.location.replace("default.aspx");
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function userRegistration() {
            var password1 = $('#password1').val();
            var password2 = $('#password2').val();
            var user_Id = $('#userid2').val();

            $.ajax({
                type: "POST",
                url: "api/access/UserRegistration",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ UserID: user_Id, NewPassword: password1, ConfirmPassword: password2 }),
                dataType: "json",
                success: function (data) {
                    alert(data.message);
                    if (data.status != 0) {
                        $('#password1').val(null);
                        $('#password2').val(null);
                        $('#userid2').val(null);
                        document.getElementById('contain1').style.display = 'none';
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });

        }




    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="w3-container" style="max-width: 600px">
        <div class="w3-card-4">
            <div class="w3-section">
                <div class="w3-row">
                    <div class="w3-container">
                        <h4>Login</h4>
                        <br />
                        <label><b>Username</b></label>
                        <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="userid" id="userid" required="required" />
                        <label><b>Password</b></label>
                        <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="password" id="password" required="required" />
                        <input  class="w3-button w3-block w3-blue w3-section w3-padding" id="reset" type="button" onclick="login()"  value="Login" />
                        <!-- <input class="w3-check w3-margin-top" type="checkbox" checked="checked"> Remember me -->
                        <div style="color:red;"><span id="error_message"></span></div>
                        <br />
                        <div>
                           <%-- <input  class="w3-button w3-padding w3-small w3-margin-bottom w3-grey  w3-round" style="width:30%" id="newUser" type="button" onclick="login()"  value="Are you a new user?" /> --%>
                           <div onclick="document.getElementById('contain1').style.display='block'" class="w3-button w3-grey w3-round w3-margin-bottom w3-padding w3-small" style="width:30%">Are you a new user?</div>
                        </div>
                     </div>   
      
                       <div class=" w3-modal w3-card-2" id="contain1">
                        <div class="w3-modal-content w3-card-2 " style="width:500px">
                          <div style="padding-top:4px; padding-left:10px; padding-right:10px;">
                            <span onclick="document.getElementById('contain1').style.display='none'" class="w3-button w3-display-topright">&times;</span>
                            </br>
                            <label><b>Username</b></label>
                            <input class="w3-input w3-border" type="text" placeholder="Enter Username" name="userid" id="userid2" required="required" />
                            <label><b>Password</b></label>
                            <input class="w3-input w3-border" type="password" placeholder="Enter Password" name="password" id="password1" required="required" />
                            <label><b>Confirm Password</b></label>
                            <input class="w3-input w3-border " type="password" placeholder="Enter Password" name="password" id="password2" required="required" />
                            </br>
                            <span style="padding-left:80%">       
                               <span onclick="userRegistration()" class="w3-button w3-blue w3-round"> Register </span>
                            </span>
                          </div>
                        </div>
                       </div>
                   
                </div>
            </div>
            <%--w3-container w3-border-top w3-padding-16 w3-light-grey">
                        <button onclick="window.close();" type="button" class="w3-button w3-red">Cancel</button>
                        <!-- <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span> -->--%>
                    
        </div>
    </div>

    </form>
</body>
</html>
