<%@ Page Language="C#" MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="ManageHirings.aspx.cs" Inherits="MyProject.ManageHirings" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, user-scalable=no"/>
    <style>
        
    </style>
    <script>
        $(function () {
            GetHirings();
            GetVehicle();
            ToggleButtonDefault();
        });
        
        function GetVehicle() {
            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/GetVehicle",
                data: JSON.stringify({
                    Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var listItems = "";
                    listItems += "<option value=''>----New----</option>";
                    for (var i = 0; i < data.length; i++) {
                        listItems += "<option value='" + data[i].VehicleId + "'>" + data[i].Brand + "</option>";
                    }
                    $("#vehicles").html(listItems);
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (request) {
                    handle_error(request);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function GetVehicleForEdit() {
            var VehicleId = $('#vehicles').val();
            if (VehicleId == null || VehicleId == "") {
                ClearVehicle();
                return;
            }
            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/GetVehicle",
                data: JSON.stringify({
                    VehicleId:VehicleId,Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    LoadVehicleData(data);
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (request) {
                    handle_error(request);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function LoadVehicleData(data) {
            //$('#vehicles').val(data[0].VehicleId);
            $('#brand').val(data[0].Brand);
            $('#model').val(data[0].Model);
            $('#NoOfseats').val(data[0].NoOfSeats);
            $('#other').val(data[0].OtherOptions);
            document.getElementById("AC").checked = data[0].WithAC;
        }
        function ToggleButton(Fld,Lbl,ChkId) {
            if ($('#' + ChkId).is(":checked")) {
                document.getElementById(Fld).style.backgroundImage = 'linear-gradient(white , green)';
                $('#' + Lbl).text('Available');
            } else {
                document.getElementById(Fld).style.backgroundImage = 'linear-gradient(white , red)';
                $('#' + Lbl).text('Unavailable');
            }
        }
        function ToggleButtonSt(Fld, Lbl, ChkId) {
            if ($('#' + ChkId).is(":checked")) {
                document.getElementById(Fld).style.backgroundImage = 'linear-gradient(white , green)';
                $('#' + Lbl).text('Online');
            } else {
                document.getElementById(Fld).style.backgroundImage = 'linear-gradient(white , red)';
                $('#' + Lbl).text('Ofline');
            }
        }
        function ToggleButtonDefault() {
            document.getElementById("chk_available").checked = true;
            document.getElementById("chk_status").checked = true;
            document.getElementById("AvFld").style.backgroundImage = 'linear-gradient(white , green)';
            $('#AvLbl').text('Available');
            document.getElementById("StFld").style.backgroundImage = 'linear-gradient(white , green)';
            $('#StLbl').text('Online');
        }
        function SetHiring() {
            var VehicleId = $('#vehicles').val();
            var Rate = $('#Rate').val();
            var WithDriver = false;
            var WithoutDriver = false;
            var IsAvailable = false;
            var Location = $('#Location').val();
            var Status = "OFFLINE";
            var Token = mycookie();
            if (VehicleId == "" || VehicleId == null) {
                alert('Select vehicle!');
                return;
            }
            if ($('#WithDriver').is(":checked")) {
                WithDriver = true;
            }
            if ($('#WithoutDriver').is(":checked")) {
                WithoutDriver = true;
            }
            if ($('#chk_available').is(":checked")) {
                IsAvailable = true;
            }
            if ($('#chk_status').is(":checked")) {
                Status = "ONLINE";
            }
            $.ajax({
                type: "POST",
                url: "api/myapi/SetHiring",
                data: JSON.stringify({
                    VehicleId:VehicleId,Rate:Rate,WithDriver:WithDriver,WithoutDriver:WithoutDriver,IsAvailable:IsAvailable,Location:Location,Status:Status,Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert(data.message);
                    if (data.status == 1) {
                        ClearData();
                    }
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (request) {
                    handle_error(request);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function ClearData() {
            $('#vehicles').val('');
            $('#Rate').val(null);
            $('#Location').val('');
            document.getElementById("chk_available").checked = true;
            document.getElementById("chk_status").checked = true;
            document.getElementById("AvFld").style.backgroundImage = 'linear-gradient(white , green)';
            $('#AvLbl').text('Available');
            document.getElementById("StFld").style.backgroundImage = 'linear-gradient(white , green)';
            $('#StLbl').text('Online');
            document.getElementById("WithDriver").checked = false;
            document.getElementById("WithoutDriver").checked = false;
        }
        function MngVehicleModal() {
            document.getElementById('VehicleMng').style.display = "block";
        }
        function SetVehicle() {
            var VehicleID = $('#vehicles').val();
            var Brand = $('#brand').val();
            var Model = $('#model').val();
            var AC = false;
            var NoOfSeats = $('#NoOfseats').val();
            var Other = $('#other').val();
            var ImagePath = '<%=ImagePath%>';
            if ($('#AC').is(":checked")) {
                AC = true;
            }

            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/SetVehicle",
                data: JSON.stringify({
                    VehicleId:VehicleID,Brand:Brand,Model:Model,WithAC:AC,NoOfSeats:NoOfSeats,OtherOptions:Other, Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.status == 1) {
                        ClearVehicle();
                    }
                    alert(data.message);
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (request) {
                    handle_error(request);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function ClearVehicle() {
            $('#vehicles').val();
            $('#brand').val('');
            $('#model').val('');
            $('#NoOfseats').val(null);
            $('#other').val('');
            document.getElementById("AC").checked = true;

        }
        function GetHirings() {
            var Token = mycookie();
            $.ajax({
                type: "POST",
                url: "api/myapi/GetUserHirings",
                data: JSON.stringify({
                    Token: Token
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //console.log(data);
                    LoadHireData(data);
                },
                failure: function (response) {
                    alert(response.d);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }
        function LoadHireData(data) {
            $("#table4").find("tr:gt(0)").remove();
            for (var i = 0; i < data.length; i++) {
                $('#table4').append('<tr ><td class="w3-border w3-round-large w3-padding"  id="t_' + i + '">' +
                    '<div class="w3-card-4 w3-border w3-round w3-row">' +
                        '<div class=" w3-padding w3-round-large w3-col m3" id="AvDiv_' + i + '"> <span class="w3-padding" style="font-weight:800;" id="IsAvailable_' + i + '"></span> </div>' +
                    '</div>' +
                    '<div class="w3-padding w3-round-large w3-col">' +
                        '<div class="w3-padding w3-round-large w3-border w3-col m2 "><span>Rate: </span><span> ' + data[i].Rate + '</span></div>' +
                        '<div class="w3-padding w3-round-large w3-border w3-col " style="width:30%;"><span id="withDriver_' + i + '"></span>&nbsp;<span id="sash_' + i + '"></span><span id="withoutDriver_' + i + '"> </span></div>' +
                        '<div class="w3-padding w3-round-large w3-border w3-col m3 "><span>Location: </span><span> ' + data[i].Location + '</span></div>' +
                        '<span onclick=ViewMoreDet(' + i + ');>&lt;&lt;More&gt;&gt;</span>' +
                    '</div>' +
                    '</td></tr>' +
                    '<tr id="Moredet_' + i + '">' +
                        '<td>referf</td>' +
                    '</tr>');

                $('#Moredet_' + i).hide();
                if (data[i].IsAvailable == true) {
                    //document.getElementById("IsAvailable_" + i).style.backgroundImage = 'linear-gradient(green,white)';
                    document.getElementById("IsAvailable_" + i).style.color = 'green';
                    $('#IsAvailable_' + i).text('Available');
                } else {
                    //document.getElementById("IsAvailable_" + i).style.backgroundImage = 'linear-gradient(red,white)';
                    $('#IsAvailable_' + i).text('Not Available');
                    document.getElementById("IsAvailable_" + i).style.color = 'red';
                }
                if (data[i].WithDriver == true) {
                    $('#withDriver_' + i).text('With Driver');
                }
                if (data[i].WithoutDriver == true) {
                    $('#withoutDriver_' + i).text('Without Driver');
                }
                if (data[i].WithDriver == true && data[i].WithoutDriver == true) {
                    $('#sash_' + i).text('/');
                }
            }
        }
    </script>
    <div style="margin-top:1%">
        <div class="w3-container w3-indigo">
            <h3>Manage hires</h3>
        </div>
        <div class="w3-row w3-responsive w3-card-4 w3-padding-16" style="padding-left:10px;padding-right:10px;">
            <div class="w3-row w3-col m10 w3-padding w3-card-2 w3-border w3-round-large" style="display:inline-block;">
                <fieldset class="w3-border w3-border-blue w3-round-large w3-padding">
                    <legend class="legend-font">Vehicle</legend>
                    <div class="w3-col w3-gray m6">
                        <select id="vehicles" style="width:100%;height:30px" onblur="GetVehicleForEdit();">
                            <option value="">...</option>
                        </select>
                    </div>
                    <div class="w3-col w3-button m4" onclick="MngVehicleModal();" style="height:30px;">New/Edit</div>
                </fieldset>
            </div>
            <div class="w3-row w3-col m12 w3-padding w3-card-2 w3-border w3-round-large">
                <div class="w3-col m2 ">
                    <fieldset class="w3-border w3-border-blue w3-round-large">
                        <legend class="legend-font">Rate:</legend>
                        <span><input class="w3-border w3-border-blue w3-round-large" type="number" id="Rate" style="height:28px;"/></span>
                    </fieldset>
                </div>
                <div class="w3-col m4 ">
                    <fieldset class="w3-border w3-border-blue w3-round-large">
                        <legend class="legend-font">Driver:</legend>
                        <div class="w3-col m5"><span>With</span>
                            <span><input class="w3-border w3-border-blue w3-round-large w3-check" type="checkbox" id="WithDriver"/></span>
                        </div>
                        <div class="w3-col m5"><span>Without</span>
                            <span><input class="w3-border w3-border-blue w3-round-large w3-check" type="checkbox" id="WithoutDriver"/></span>
                        </div>
                    </fieldset>
                </div>
                <div class="w3-col m5 ">
                    <fieldset class="w3-border w3-border-blue w3-round-large">
                        <legend class="legend-font">Location:</legend>
                        <span><input class="w3-border w3-border-blue w3-round-large" type="text" id="Location" style="height:28px;width:100%;"/></span>
                    </fieldset>
                </div>
                <div class="w3-col m3 " >
                    <fieldset class="w3-border w3-border-blue w3-round-large" id="AvFld">
                        <legend class="legend-font" style="" >Availability:</legend>
                        <input class="chk-input" type="checkbox" id="chk_available" onclick="ToggleButton('AvFld','AvLbl','chk_available')" />
                        <label for="chk_available" class="my-lbl" id="AvLbl" style="height:100%;width:100%;">
                           Available
                        </label>
                    </fieldset>
                </div>
                <div class="w3-col m3 ">
                    <fieldset class="w3-border w3-border-blue w3-round-large" id="StFld" >
                        <legend class="legend-font" style="" >Status:</legend>
                        <input class="chk-input" type="checkbox" id="chk_status" onclick="ToggleButtonSt('StFld', 'StLbl', 'chk_status')" />
                        <label for="chk_status" class="my-lbl" id="StLbl" style="height:100%;width:100%;">
                           Online
                        </label>
                    </fieldset>
                </div>
                <div class="w3-col m5 w3-padding w3-center"><div>&nbsp;</div>
                    <div class="w3-button w3-border w3-border-blue w3-round-large m8 w3-green" onclick="SetHiring();">
                        <i class="fas fa-save w3-large "></i><span style="font-size:20px;padding-left:3px;">Save</span>
                    </div>
                    <div class="w3-button w3-border w3-border-blue w3-round-large m8 w3-red" onclick="ClearData();">
                        <i class="fas fa-times-circle w3-large"></i><span style="font-size:20px;padding-left:3px;">Cancel</span>
                    </div>
                </div>
            </div>
            <div class="w3-row w3-col m12 w3-padding w3-card-2 w3-border w3-round-large">
                <table id="table4" class="w3-table-all tr{border-bottom:1px solid #ddd}" style="background-color:#fbfbfb">
                    <tbody>
                    
                    </tbody>
                </table>
            </div>
        </div>
        <div id="VehicleMng" class="w3-modal " style="padding-top:5%;">
            <div class="w3-modal-content w3-card-4 w3-row w3-responsive w3-row w3-round-large w3-animate-zoom my-modal-st" style="">
                <div class="w3-padding w3-col" style="width:100% ; background-image:linear-gradient(to right,#4f8ff7,#e1e9f7);"><span class="modal-font" id="" style="text-align:center;">Manage vehicles</span><span class="w3-red w3-margin" onclick="document.getElementById('VehicleMng').style.display='none';GetVehicle();"><i class="far fa-window-close w3-xlarge w3-red" style="float:right;" ></i></span></div>
                <div class="w3-col m5">
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding " ><label> Brand </label></div>
                        <div class="w3-padding"> <input id="brand" /></div>

                    </div>
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding"> <label> Model </label></div>
                        <div class="w3-padding"> <input id="model" /></div>

                    </div>
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding"> <label> AC </label></div>
                        <div class="w3-padding"> <input class="w3-check" type="checkbox" id="AC" /></div>

                    </div>
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding"> <label> No of seats </label></div>
                        <div class="w3-padding"> <input class="" type="number" id="NoOfseats" /></div>

                    </div>
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding"> <label> Other options </label></div>
                        <div class="w3-padding"> <input id="other" /></div>

                    </div>
                    <div class="w3-padding m4 w3-amber"> 
                        <div class="w3-padding"> <label> &nbsp;</label></div>
                        <div class="w3-padding w3-button w3-green" onclick=" SetVehicle()"><label> Save</label></div>

                    </div>
                </div>
                <div class="w3-col m5 w3-center">
                    <div class="w3-col">
                        <img id="V_img" runat="server" src="images/avatar2.png" class="w3-center w3-circle w3-hover-border-blue w3-hover-grayscale" style="width:50%; height:50%;"/>
                    </div>
                    <div class="w3-col">
                        <asp:FileUpload runat="server" ID="VImg"/>
                        <asp:Button CssClass="w3-button w3-light-blue" runat="server" ID="ImgUpload" Text="Save image" OnClick="ImgUpload_Click"/>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
</asp:Content>

