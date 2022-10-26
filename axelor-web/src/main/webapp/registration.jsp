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
String copyright = String.format("&copy;   2022 — Предварительное информирование. Государственная таможенная служба при Министерстве финансов Кыргызской Республики.", year);

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
    
    <div id="register" class="animate form">
        <form id="registration" action="http://localhost:8080/axelor-sanarip-tamga-6.3.0/registration" method="POST" required="" >
        
        <!-- First page -->
        <div id="id1"  class="panel-body1">
            <div class="form-fields">
              <p style="text-align:center; line-height: 0;"></p><img src="img/logo.png" width="50px" class="logo"></p>
              <h2 class="fs-title"><b>Предварительное информирование</b></h2>
              <h3 class="fs-subtitle">Регистрация</h3>
              <b class="headings">Фамилия</b><br>
              <input type="text" placeholder="Введите Вашу фамилию*" name="lastname" id="lastname" required>
              <b class="headings">Имя</b><br>
              <input type="text" placeholder="Введите Ваше имя*" name="names" id="names" required>
              <b class="headings">Отчество</b><br>
              <input type="text" placeholder="Введите Ваше отчество*" name="middlename" id="middlename">
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
              <div id="buttonForward">
                <button id="pageOne" data-btn-next="2" class="btn btn-link"  type="submit">Вперед<img alt="Вперед" src="img/forward.png" width="25" height="25" ></button></div>
              <br><br>
              <div class ="signDown">
                <b >Есть аккаунт?</b>
                  <a href="login.jsp">Войти</a>
              </div>
            </div>
        </div>
      
      <!-- Second page -->
        <div id="cityChoose"  class="panel-indv2 panel-legal2">
          <div class="form-fields"  style="height: 720px;">
            <div class="сitizenship"><br>
              <b>Гражданско-правовой статус*</b><br><br>
              <div  class="radio">
              <input type="radio" id="legal" value="Юридическое лицо" name="btnRadio" class="radio__input">
              <label for="legal" class="radio__label">Юридическое лицо</label><br>
          </div><br>
          <div class="radio">
              <input type="radio" id="individual" value="Физическое лицо" name="btnRadio" class="radio__input">
              <label for="individual" class="radio__label">Физическое лицо</label> 
          </div>
            </div>
                <br>
                <div id="indiv2" >
                  
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select class="indivSelect" name="registersAccount" id="registersAccount"  required>
                      <option  value="">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select>
              
                  <br>
                      <b>Гражданство</b><br>
                      <select class="indivSelect" name="сitizenships" id="сitizenships" required>
                        <option value="" >Выберите страну</option>  
                      <option value="kgz">Кыргызстан</option>
                      <option value="ru">Россия</option>
                      <option value="kz">Казакстан</option>
                      <option value="uz">Узбекистан</option>
                      </select>
             
                  <div style="margin-top: 10px;">
                      <b>Идентификатор физического лица</b><br>
                      <input type="text" minlength="5" placeholder="Идентификатор физического лица" name="passport" id="passport" required >
                  </div>
                  <div style="margin-top: 10px;">
                      <b>Дата рождения</b><br>
                      <input class="indivSelect" type="date" placeholder="Число/месяц/год*" name="dateOfBirth" id="dateOfBirth" required>
                  </div>  
                  <div style="margin-top: 10px;">
                    <b>Орган выдачи документа</b><br>
                    <input type="text" placeholder="Орган выдачи документа" name="issuningAuthority" id="issuningAuthority" required>
                  </div>
                  <div style="margin-top: 10px;">
                      <b>Дата выдачи документа</b><br>
                      <input type="date" placeholder="Число/месяц/год*" name="documentIssueDate" id="documentIssueDate" required>
                      </div>    
                      <div style="margin-top: 10px;">
                        <b>Срок истечения документа</b><br>
                        <input type="date" placeholder="Число/месяц/год*" name="documentExpirationDate" id="documentExpirationDate" required>
                      </div>  
                      <div id="buttonForward"> 
                  <button id="pageIndv2" data-btn-next="2" class="btn btn-link"  type="submit">Вперед<img alt="Вперед" src="img/forward.png" width="25" height="25"></button></div>
                 <div id="buttonBack">
                  <button id="backIndv2" data-btn-next="1" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width="25" height="25" >Назад</button></div>
                  <br>
                  <br>
                  <div class="signDown">
                    <b >Есть аккаунт?</b>
                      <a href="login.jsp" >Войти</a>
                </div>
                </div>

                <div id="legal2" class="сitizenship">
                 <br> 
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select name="registersAccountLegal" id="registersAccountLegal" required>
                      <option value="">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select><br>
                     <br> <div >
                        <b>Страна регистрации юридического лица</b><br>
                        <select  name="сitizenshipsLegal" id="сitizenshipsLegal" required = "required">
                        <option value="">Страна регистрации юридического лица</option>
                        <option value="kgz">Кыргызстан</option>
                        <option value="ru">Россия</option>
                        <option value="kz">Казакстан</option>
                        <option value="uz">Узбекистан</option>
                        </select>
                    </div><br>
                    <div>
                        <b>Наименование компании</b><br>
                        <input type="text" placeholder="ОсОО Компания" name="companyLegal" id="companyLegal" required>
                    </div>
                    <div id="buttonForward">
                <button id="pageLegal2" data-btn-next="3" class="btn btn-link"  type="submit">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button></div>
                <div id="buttonBack">
                <button id="backLegal2" data-btn-next="1" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
                <br>
                <br>
                <div class="signDown">
                  <b >Есть аккаунт?</b>
                    <a href="login.jsp">Войти</a>
                </div>
          </div>	
              </div>                
        </div>	
      
         
        <div id="indiv3"  class="panel-indv3">
          <div class="form-fields"  >
             <div>
                <b>Домашний адрес</b><br><br>
                <select name="country" id="countryIndiv" required="" >
                  <option value="">Страна*</option>
                  <option value="kg">Кыргызстан</option>
                  <option value="ru">Россия</option>
                  <option value="kz">Казахстан</option>
                  <option value="uz">Узбекистан</option>
                  </select>
                <select name="town" id="townIndiv" required="" >
                    <option value="">Город*</option>
                                    <option value="1">Бишкек</option>
                                    <option value="2">Талаc</option>
                                    <option value="3">Иссык-куль</option>
                                    <option value="4">Ош</option>
                                    <option value="5">Джалал-абад</option>
                                    <option value="6">Баткен</option>
                                    <option value="7">Нарын</option>
                  </select>
                <input type="text" placeholder="Название улицы*" name="street" id="streetIndiv"><br>
                <input type="text" placeholder="Номер дома*" name="homeNum" id="homeNumIndiv"><br>
                <input type="text" placeholder="Номер квартиры" name="apartments" id="apartmentsIndiv">
            </div>
            <div id="buttonForward">
                <button id="pageIndv3" data-btn-next="3" class="btn btn-link"  type="submit">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button></div>
                <div id="buttonBack">
                <button id="backIndv3" data-btn-next="2" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
                <br>
                <br>
                <div class ="signDown">
                  <b >Есть аккаунт?</b>
                    <a href="login.jsp">Войти</a>
                </div>
         </div>
         </div>

           
         <div id="indiv4" class="panel-indv5">
          <div class="form-fields">
            <div>
              <br>
              <br>
              <b>Электронная почта</b><br>
              <input type="email" placeholder="example@gmail.com" name="email" id="emailIndiv" required>
            </div>
            <div>
              <br>
              <div style="display:flex">
                <h4  style="height: 32px!important; width: 100%;">Номер телефона*</h4>
               <br> <select name="phoneType" id="phoneTypeIndiv1" style="height: 32px!important; width: 55%; "> 
            <option>Мобильный</option>
            <option>Офисный</option>
          </select></div>
          <div style="display:flex">
          <select style=" width: 30%;" name="phoneType" id="phoneCodeIndiv1" required>
                    <option value="" >+ Код страны</option>
            <option>+996</option>
            <option>+7</option>
          </select>
          <input placeholder="Номер телефона" style=" width: 100%;" type="text" name="phoneNumIndiv1" id="phoneNumIndiv1" required/>
                  </div>

                    <button id="addNum1" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img src="img/addPhone.png" width =24px
                        height = 15px>Добавить номер</button>
                    </div><br>
                    <div class="extraNum" id="addNumberIndv">
                        <select name="phoneType" id="phoneTypeIndiv2">
                        <option>Мобильный</option>
                <option>Офисный</option>
                </select>
                <select name="phoneType">
                        <option>+ Код страны</option>
                <option>+996</option>
                <option>+7</option>
                </select>
                <input  placeholder="Номер телефона" type="text" name="phoneNumIndiv2"/>
                    </div>
              <div class="form-footer">
                <button id="pageIndv4" data-btn-next="6" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
              </div>
              <br>
              <br>
              <div id="buttonBack">
              <button id="backIndv4" data-btn-next="3" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
              <br>
              <br>
              <div class ="signDown">
                <b >Есть аккаунт?</b>
                  <a href="login.jsp">Войти</a>
              </div>
          </div>
        </div>
        
   
       
       <div id="legal3"  class="panel-legal3">
         <div class="form-fields">
            <div>
            <b>Идентификтор налогоплательщика</b><br>
            <input type="text" minlength="8" placeholder="Идентификтор налогоплательщика" name="adressLegal" id="adressLegal" required>
            </div>
          <div>
              <b>Юридический адрес</b><br>
              <select name="countryLegal" id="countryLegal" required="" >
                <option value="">Страна*</option>
                <option value="kg">Кыргызстан</option>
                <option value="ru">Россия</option>
                <option value="kz">Казахстан</option>
                <option value="uz">Узбекистан</option>
                </select>



              <select name="town" id="townLegal" required="" >
              <option value="">Город*</option>
              <option value="1">Бишкек</option>
              <option value="2">Талаc</option>
             <option value="3">Иссык-куль</option>
             <option value="4">Ош</option>
             <option value="5">Джалал-абад</option>
             <option value="6">Баткен</option>
             <option value="7">Нарын</option>
                </select>

          <input type="text" placeholder="Номер здания*" name="homeNumLegal" id="homeNumLegal" required>
          <input type="text" placeholder="Номер офиса" name="officeNumber" id="officeNumber" required>
            </div> 		
            <div id="buttonForward"	>
          <button id="pageLegal3" data-btn-next="4" class="btn btn-link"  type="submit">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button></div>
            <div id="buttonBack">
          <button id="backLegal3" data-btn-next="2" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
            <br>
            <br>
            <div class ="signDown">
              <b >Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
            </div>
          </div>	
        </div>
      
       
         <div id="legal4"  class="panel-legal4">
          <div class="form-fields">
            
            <button id ="confirmation" class="btn-default"  type="submit" style="float: center;">Подтверждение включения лица в реестр таможенных представителей</button>
         
          <div>
            
            <br>
            <div style="display:flex">
                  <h4  style="height: 32px!important; width: 100%;">Номер телефона*</h4>
                 <br> <select name="phoneTypeLegal1" id="phoneTypeLegal1" style="height: 32px!important; width: 55%; "> 
              <option>Мобильный</option>
              <option>Офисный</option>
            </select></div>
            <div style="display:flex">
            <select style=" width: 30%;" name="phoneCodeLegal1" id="phoneCodeLegal1" required>
                      <option value="" >+ Код страны</option>
              <option>+996</option>
              <option>+7</option>
            </select>
            <input placeholder="Номер телефона" style=" width: 100%;" type="text" name="phoneNumLegal1" id="phoneNumLegal1" required/>
            </div>
                  </div> 
                  <div>
                    <button id="addNum2" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img src="img/addPhone.png" width =24px
                      height = 15px>Добавить номер</button>
                  </div>
            <div class="extraNum" id="addNumberLegal">
                      <select name="phoneTypeLegal2" id="phoneTypeLegal2">
                      <option>Мобильный</option>
              <option>Офисный</option>
              </select>
              <select name="phoneTypeLegal2">
                      <option>+ Код страны</option>
              <option>+996</option>
              <option>+7</option>
              </select>
              <input placeholder="Номер телефона" type="text" name="phoneNumLegal2"/>
                  </div>
            <div><br><br>
                      <b>Электронная почта</b>
                      <input type="email" placeholder="example@gmail.com" name="emailLegal" id="emailLegal" required>

                   </div>
              
              <button id="pageLegal4" data-btn-next="5" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
              <br>
              <div id="buttonBack">
              <button id="backLegal4" data-btn-next="4" class="btn btn-link"  type="submit"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
              <br>
              <br><br>
              <div class ="signDown">
                <b >Есть аккаунт?</b>
                  <a href="login.jsp">Войти</a>
              </div>
        </div>	
       </div>
       
      <div id="legal5"  class="panel-legal5">
        <div class="form-fields">
          <br>
          <div id ="confirmation2" class="btn-default"  type="submit" style="float: center;">
            <b>Подтверждение включения лица в реестр таможенных представителей</b><br>
            </div><br> <br>
            <div>
            <b>Страна включившая лицо в реестр</b><br>
            <select name="includedPerson">
                    <option>Кыргызстан</option>
                    <option>Казакстан</option>
                </select>
            </div>
            <div><br><br>
              <b>Регистрационный номер юридического лица при включении в реестр</b><br>
            <input type="text" placeholder="Регистрационный номер" name="registrationNumber" id="registratioNumber">
          </div> 
            <div><br><br>
              <b>Код признака перегистрации документа</b><br>
            <input type="text" placeholder="Код перерегисрации документа" name="documentRegistrationCode" id="">
          </div> 	
          <div id="buttonBack">
             <button id="backLegal5" data-btn-next="5" class="btn btn-link"  type="submit" ><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button></div>
          <br>
          <br>
          <br>
          <div class ="signDown">
            <b id="account">Есть аккаунт?</b>
              <a href="login.jsp">Войти</a>
          </div>	
            </div>
        </div>
       
        <footer class="container-fluid" id="footerRegister" >
          <p class="credit small"><%= copyright %></p>
        </footer>
        
        </form>
      </div>
     
     
<script src="js/application.login.js"></script> 
  </body>
</html>



