<%--

    Axelor Business Solutions

    Copyright (C) 2005-2022 Axelor (<http://axelor.com>).

    This program is free software: you can redistribute it and/or  modify
    it under the terms of the GNU Affero General Public License, version 3,
    as published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@ taglib prefix="x" uri="WEB-INF/axelor.tld" %>
<%@ page language="java" session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" session="true" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Map.Entry"%>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.function.Function"%>
<%@ page import="org.pac4j.http.client.indirect.FormClient" %>
<%@ page import="com.axelor.i18n.I18n" %>
<%@ page import="com.axelor.app.AppSettings" %>
<%@ page import="com.axelor.auth.pac4j.AuthPac4jModule" %>
<%@ page import="com.axelor.common.HtmlUtils" %>
<%@ page import="com.axelor.auth.AuthService" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>

<%

Function<String, String> T = new Function<String, String>() {
  public String apply(String t) {
    try {
      return I18n.get(t);
    } catch (Exception e) {
      return t; 
    }
  }
};


String errorMsg = T.apply(request.getParameter(FormClient.ERROR_PARAMETER));

String loginTitle = T.apply("Please sign in");
String loginRemember = T.apply("Remember me");
String loginSubmit = T.apply("Log in");

String loginUserName = T.apply("Username");
String loginPassword = T.apply("Password");

String warningBrowser = T.apply("Update your browser!");
String warningAdblock = T.apply("Adblocker detected!");
String warningAdblock2 = T.apply("Please disable the adblocker as it may slow down the application.");

String loginWith = T.apply("Log in with %s");

int year = Calendar.getInstance().get(Calendar.YEAR);
String copyright = String.format("&copy;  @ 2022 — Предварительное информирование. Государственная таможенная служба при Министерстве финансов Кыргызской Республики.", year);

String loginHeader = "/login-header.jsp";
if (pageContext.getServletContext().getResource(loginHeader) == null) {
  loginHeader = null;
}

@SuppressWarnings("all")
Map<String, String> tenants = (Map) session.getAttribute("tenantMap");
String tenantId = (String) session.getAttribute("tenantId");

AppSettings settings = AppSettings.get();
String callbackUrl = AuthPac4jModule.getCallbackUrl();

Set<String> centralClients = AuthPac4jModule.getCentralClients();
  

	%>
  


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="google" content="notranslate">
    <link rel="shortcut icon" href="ico/favicon.ico">
    <link href="css/application.login.css" rel="stylesheet">
<script src="lib/jquery.ui/js/jquery.js"></script>

<script src="lib/bootstrap/js/bootstrap.js"></script>
<script src="js/axelor.ns.js"></script>
<link href="css/login.css" rel="stylesheet">
</head>
  <body>
    <div class="panel-body">
      <form id="authorization" action="<%=callbackUrl%>" method="POST" >
        <script src="js/application.login.js"></script>
        <div class="form-fields">
          <p style="text-align:center;"></p><img src="img/logo.png" width="50px" class="logo"></p>
          <h2 class="fs-title"><b>Предварительное информирование</b></h2>
          <h3 class="fs-subtitle">Войти</h3>
          <div id="error-msg" class="alert alert-block alert-error text-center <%= errorMsg == null ? "hidden" : "" %>">
            <h4>Неправильный логин или пароль</h4>
          </div>
          <b>Логин</b> <br>
          <div class="input-prepend" style="margin-top:6px">
            <input type="text" id="usernameId" name="username" placeholder="<%= loginUserName %>" autofocus="autofocus">
          </div><br>
          
          <div style="display: flex; justify-content:space-between">
            <b>Пароль</b>
            <a href="change-password.jsp">Изменить пароль</a>
          </div>
          <div class="password" style="margin-top:6px">
            <input type="password" id="passwordId" name="password" placeholder="<%= loginPassword %>">
            <a href="#" class="password-control"></a>

          </div>
        <% if (tenants != null && tenants.size() > 1) { %>
        <div class="input-prepend">
          <span class="add-on"><i class="fa fa-database"></i></span>
          <select name="tenantId">
          <% for (String key : tenants.keySet()) { %>
            <option value="<%= key %>" <%= (key.equals(tenantId) ? "selected" : "") %>><%= tenants.get(key) %></option>
          <% } %>
          </select>
        </div>
          <% } %>

          <label class="ibox">
            <input type="checkbox" value="rememberMe" name="rememberMe">
            <span class="box"></span>
            <span class="title"><%= loginRemember %></span>
          </label>
          <input type="hidden" name="hash_location" id="hash-location">
         
          <button class="btn btn-primary btn-lg btn-block" type="submit" id="sighIn">Войти</button>  
       <br>
         <div style="display: flex; justify-content:space-between">
          <b>У вас нет аккаунта?</b>
          <a href="registration.jsp">Зарегистрироваться</a>
        </div>
      </div>
        <footer class="container-fluid" id="footerLogin" >
          <p class="credit small"><%= copyright %></p>
        </footer>
      </form>
      
   </div>

   

      <div id="br-warning" class="alert alert-block alert-error hidden">
	  	<h4><%= warningBrowser %></h4>
	  	<ul>
	  		<li>Chrome</li>
	  		<li>Firefox</li>
	  		<li>Safari</li>
	  		<li>IE >= 11</li>
	  	</ul>
	  </div>
	  <div id="ad-warning" class="alert hidden">
	  	<h4><%= warningAdblock %></h4>
	  	<div><%= warningAdblock2 %></div>
	  </div>
    

  
    
    <!-- <div id="adblock"></div> -->

    <script type="text/javascript">
    $(function () {
	    if (axelor.browser.msie && !axelor.browser.rv) {
	     	$('#br-warning').removeClass('hidden');
	    }
	    if ($('#adblock') === undefined || $('#adblock').is(':hidden')) {
	     	$('#ad-warning').removeClass('hidden');
	    }
	    
	    $("#social-buttons").on('click', 'button', function (e) {
	     var client = $(e.currentTarget).data('provider');
	     window.location.href = './?client_name=' + client
	         + "&hash_location=" + encodeURIComponent(window.location.hash);
	    });

        $('#login-form').submit(function(e) {
          document.getElementById("hash-location").value = window.location.hash;
        });
    });
        </script>
       <script>
        $('body').on('click', '.password-control', function(){
          if ($('#passwordId').attr('type') == 'password'){
            $(this).addClass('view');
            $('#passwordId').attr('type', 'text');
          } else {
            $(this).removeClass('view');
            $('#passwordId').attr('type', 'password');
          }
          return false;
        });
        </script>

<!-- <script>
  $(document).ready(function(){
    $("#msform").click(function(){
      lastname //Фамилия
      names  // Имя
      middlename //Отчество

      //физический лицо
      registersAccount  //Кем регистрируется данный аккаунт
      сitizenships //Гранжданство
      passport //Идентификатор физического лица<
      dateOfBirth//Дата рождения
      issuningAuthority//Орган выдачи документа
      documentIssueDate // Дата выдачи документа
      documentExpirationDate //Срок истечение паспорта
      country //Страна
      region //Область

      area  //Район
      postcode //почтовый индекс
      town  //Город/село
      street //Название улицы
      homeNum // Номер дома
      apartments //Номер квартиры
      phoneType // Номер телефона  .....
      phoneType2 //Добавить номер
      email  // Электронная почта
      password //пароль

      //юридическоелицо
      registersAccountLegal //Кем регистрируется данный аккаунт
      сitizenshipsLegal  //Страна регистрации юридического лица
      companyLegal //Наименование компании
      TaxID // Идентификтор налогоплательщика
      countryLegal //Страна
      regionLegal //Область
      areaLegal  //Район
      postcodeLegal //почтовый индекс
      townLegal  //Город
      homeNumLegal //Номер здания
      officeNumber //Номер офиса
      phoneTypeLegal //Номер телефона
      phoneTypeLegal2 //Добавить номер
      emailLegal //Электронная почта
      passwordLegal //Пароль

      includedPerson //Страна включившая лицо в реестр
      registrationNumber //Регистрационный номер
      documentRegistrationCode //Код перерегисрации документа

</script> -->


  </body>
</html>



