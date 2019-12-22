<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyProject.Default" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, user-scalable=no"/>
<script>
        $(function () {
            GetHirings();
        });
        function GetHirings() {
            $.ajax({
                type: "POST",
                url: "api/myapi/GetHirings",
                data: JSON.stringify({
                    
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //console.log(data);
                   LoadData(data);
                },
                failure: function (response) {
                    alert(response.d);
                },
                beforeSend: function (xhr, settings) { xhr.setRequestHeader('Authorization', mycookie()); }
            });
        }

        function LoadData(data) {
            $("#table4").find("tr:gt(0)").remove();
            for (var i = 0; i < data.length; i++) {
                $('#table4').append('<tr ><td class="w3-border w3-round-large w3-padding"  id="t_' + i + '">' +
                    '<div class="w3-card-4 w3-border w3-round w3-row">' +
                        '<div class=" w3-padding w3-round-large w3-col m3" id="AvDiv_' + i + '"> <span class="w3-padding" style="font-weight:800;" id="IsAvailable_' + i + '"></span> </div>' +
                    '</div>' +
                    '<div class="w3-padding w3-round-large w3-col">' +
                        '<div class="w3-padding w3-round-large w3-border w3-col m2 "><span>Rate: </span><span> ' + data[i].Rate + '</span></div>' +
                        '<div class="w3-padding w3-round-large w3-border w3-col " style="width:30%;"><span id="withDriver_'+ i +'"></span>&nbsp;<span id="sash_'+i+'"></span><span id="withoutDriver_'+i+'"> </span></div>' +
                        '<div class="w3-padding w3-round-large w3-border w3-col m3 "><span>Location: </span><span> ' + data[i].Location + '</span></div>' +
                        '<span onclick="ViewMoreDet('+i+')";>&lt;&lt;More&gt;&gt;</span>' +
                    '</div>' +
                    '</td></tr>'+
                    '<tr id="Moredet_' + i + '" ><td>' +
                    '<div class="w3-col m2"><span> Brand: ' + data[i].Brand + '</span> </div>' +
                    '<div class="w3-col m2"><span> Model: ' + data[i].Model + '</span> </div>' +
                    '<div class="w3-col m2"><span> No of seats: ' + data[i].NoOfSeats + '</span> </div>' +
                    '<div class="w3-col m2"><span id="AC_' + i +' "> A/C: </span> </div>' +
                    '</td></tr>');

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
                if (data[i].IsAC == true) {

                }
            }
        }
        function ViewMoreDet(i) {
            $('#Moredet_' + i).show();
        }
    </script>
    <div class="w3-card-4" style="margin-top:1%; ">
         <div id="centre_body" style="padding-top:6px">
         <div id="centre_grid" class="row w3-col m12 s12">           
                <table id="table4" class="w3-table-all tr{border-bottom:1px solid #ddd}" style="background-color:#fbfbfb">
                    <tr class="w3-light-gray">
                        
                    </tr>
                    <tbody>
                    
                    </tbody>
                </table>
            </div>
      </div>
    </div>
</asp:Content>
