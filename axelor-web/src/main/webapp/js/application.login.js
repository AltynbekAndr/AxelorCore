


  // $(document).ready(function(){
  //   $("#registration").onClick(function(){
  //     var lastname=$("#lastname").val();
  //     var names=$("#names").val();
  //     var passport=$("#passport").val();
  //     var register=$("#register").val();
  //     var indiv2=$("#indiv2").val();
  //     var indiv3=$("#indiv3").val();
  //     var indiv4=$("#indiv4").val();
  //     var indiv5=$("#indiv5").val();
  //     var legal2=$("#legal2").val();
  //     var legal3=$("#legal3").val();
  //     var legal4=$("#legal4").val();
  //     var legal5=$("#legal5").val();
  //     var id6=$("#id6").val();
  //     var id1=$("#id1").val();
  // //    var individual=$("#individual").val();
  //     var pageIndv2=$("#pageIndv2").val();
  //     var pageIndv3=$("#pageIndv3").val();
  //     var pageIndv4=$("#pageIndv4").val();
  //     var pageIndv5=$("#pageIndv5").val();
  //     var backIndv2=$("#backIndv2").val();
  //     var backIndv3=$("#backIndv3").val();
  //     var backIndv4=$("#backIndv4").val();
  //     var backIndv5=$("#backIndv5").val();

  //    // var legal=$("#legal").val();
  //     var pageLegal2=$("#pageLegal2").val();
  //     var pageLegal3=$("#pageLegal3").val();
  //     var confirmation=$("#confirmation").val();
  //     var pageLegal4=$("#pageLegal4").val();
  //     var pageLegal5=$("#pageLegal5").val();
  //     var backLegal2=$("#backLegal2").val();
  //     var backLegal3=$("#backLegal3").val();
  //     var backLegal4=$("#backLegal4").val();
  //     var backLegal5=$("#backLegal5").val();
  //     var authorized=$("#authorized").val();
  //     var cityChoose=$("#cityChoose").val();

  //   });

  // });

  // var item=$(".indivSelect").val();




            id1.hidden=false
            cityChoose.hidden = true;
            indiv2.hidden = true;
            indiv3.hidden = true;
            indiv4.hidden = true;
            legal2.hidden = true;
            legal3.hidden = true;
            legal4.hidden = true;
            legal5.hidden = true;
            addNumberIndv.hidden=true;
            addNumberLegal.hidden=true;




      pageOne.onclick = function() {
        if(lastname.value==='' || names.value==='') {
          pageOne=false;
        }else{
          id1.hidden = true;
          cityChoose.hidden = false;
          indiv2.hidden = false;
        }
    }

    document.querySelector('#individual').onclick = function(){

      legal2.hidden = true;
      indiv2.hidden = false;

      pageIndv2.onclick = function() {
        if (passport.value === "" || issuningAuthority.value === "" ||  ($('#registersAccount').val()==="") || ($('#dateOfBirth').val()==="")){

          return;
        }else if (($('#??itizenships').val()==="") || ($('#documentIssueDate').val()==="") ||  ($('#documentExpirationDate').val()==="") ){
          return;
        }
        else{
        indiv2.hidden = true;
        cityChoose.hidden = true;
        indiv3.hidden = false;
        }
      }



        pageIndv3.onclick = function() {
          if (($('#countryIndiv').val()==="") ||  ($('#townIndiv').val()==="") ){
            return;
          }else{

         indiv3.hidden = true;
          indiv4.hidden = false;
          cityChoose.hidden = true;
          }
        }

        addNum1.onclick=function(){
          addNumberIndv.hidden=false;
        }


          pageIndv4.onclick = function() {
            if($('emailIndiv')==="" || ($('#phoneCodeIndiv1').val()==="") ||  ($('#phoneNumIndiv1').val()==="")){
              return;
            }
            alert("?????????????????? ???????? ???????????? ?? ?????????????????? ?????? ???????????? ???? ??????????");
            let form = document.getElementById("registration");
             form.action="http://localhost:8080/axelor-sanarip-tamga-6.3.0/registration";
             form.method = "POST";
             form.submit();
          }
          backIndv2.onclick = function() {
            indiv2.hidden = true;
            id1.hidden = false;
            cityChoose.hidden = true;
          }
          backIndv3.onclick = function() {
            indiv3.hidden = true;
            indiv2.hidden = false;
            cityChoose.hidden = false;
          }

          backIndv4.onclick = function() {
            indiv4.hidden = true;
            indiv3.hidden = false;
            cityChoose.hidden = true;
          }

    }


    document.querySelector('#legal').onclick = function(){

      indiv2.hidden = true;
        legal2.hidden = false;


        pageLegal2.onclick = function() {
          if (($("#registersAccountLegal").val()==="") || ($("#??itizenshipsLegal").val()==="") ){
            return;
          }else if($("#companyLegal").val()===""){
            return;
          }
          legal2.hidden = true;
          legal3.hidden = false;
          cityChoose.hidden = true;
        }

          pageLegal3.onclick = function() {
            if ($("#adressLegal").val().length < 5){
              return;
            }else if(($("#countryLegal").val()==="")|| ($("#townLegal").val()==="")){
              return;
            }
            legal3.hidden = true;
            legal4.hidden = false;
            cityChoose.hidden = true;
            confirmation.onclick = function() {
             legal4.hidden = true;
              legal5.hidden = false;
              cityChoose.hidden = true;
          }
        }
        addNum2.onclick=function(){
          addNumberLegal.hidden=false;
        }

            pageLegal4.onclick = function() {
              if(($('#emailLegal').val()==="") || ($('#phoneCodeLegal1').val()==="") ||  ($('#phoneNumLegal1').val()=="")) {
                return;
              }
              alert("?????????????????? ???????? ???????????? ?? ?????????????????? ?????? ???????????? ???? ??????????");
              let form = document.querySelector("#registration");
               form.action="http://localhost:8080/axelor-sanarip-tamga-6.3.0/registration";
               form.method = "POST";
               form.submit();
            }

            backLegal2.onclick = function() {
              legal2.hidden = true;
              id1.hidden = false;
              cityChoose.hidden = true;
            }
            backLegal3.onclick = function() {
              legal3.hidden = true;
              legal2.hidden = false;
              cityChoose.hidden = false;
            }
            backLegal4.onclick = function() {
              legal4.hidden = true;
              legal3.hidden = false;
              cityChoose.hidden = true;
              }
              backLegal5.onclick = function() {
                legal5.hidden = true;
                legal4.hidden = false;
                cityChoose.hidden = true;
                }
              }
