aaa<%--

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
String copyright = String.format("&copy; 2005 - %s Axelor. All Rights Reserved.", year);

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
        <form id="registration" action="registration.jsp" method="POST"> 
        <script src="js/application.login.js"></script> 
        <div id="id1"  class="panel-body1">
            <div class="form-fields">
              <p style="text-align:center;"></p><img src="img/axelor.png" width="50px" class="logo"></p><br>
              <h2 class="fs-title"><b>Предварительное информирование</b></h2>
              <h3 class="fs-subtitle">Регистрация</h3>
              <b class="headings">Фамилия</b><br>
              <input type="text" placeholder="Введите Вашу фамилию*" name="lastname" id="lastname" required>
              <b class="headings">Имя</b><br>
              <input type="text" placeholder="Введите Ваше имя*" name="names" id="names" required>
              <b class="headings">Отчество</b><br>
              <input type="text" placeholder="Введите Ваше отчество*" name="middlename" id="middlename" required>
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
              <div>
                <button id="pageOne" data-btn-next="2" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
                <br><b>Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
              </div>
            </div>
        </div>
        <div id="indiv2"  class="panel-indv2">
          <div class="form-fields">
              <div class="сitizenship">
                <b>Гражданско-правовой статус*</b><br>
                <div >
                  <input  type="radio" name="flexRadioDefault" id="legal"  checked>
                  <label for="legal">Юридическое лицо</label>
                </div>
                <div >
                  <input  type="radio" name="flexRadioDefault" id="individual">
                  <label  for="individual">Физическое лицо"</label>
                  </div>
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select name="registersAccount" id="registersAccount">
                      <option value="kgz">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select>
              </div>
                  <div >
                      <b>Гражданство</b><br>
                      <select name="сitizenships" id="сitizenships">
                      <option value="kgz">Кыргызстан</option>
                      <option value="ru">Россия</option>
                      <option value="kz">Казакстан</option>
                      <option value="uz">Узбекистан</option>
                      </select>
                  </div>
                  <div>
                      <b>Идентификатор физического лица</b><br>
                      <input type="text" placeholder="Идентификатор физического лица" name="passport" id="passport" required>
                  </div>
                  <div>
                      <b>Дата рождения</b><br>
                      <input type="date" placeholder="Число/месяц/год*" name="dateOfBirth" id="dateOfBirth" required>
                  </div>        
                  <button id="pageIndv2" data-btn-next="2" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
                  <button id="backIndv2" data-btn-next="1" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
                  <br>
                  <br>
                  <br><b>Есть аккаунт?</b>
                  <a href="login.jsp">Войти</a>
        </div>	
      </div>
         
        <div id="indiv3"  class="panel-indv3">
          <div class="form-fields">
            <div>
              <div>
                <b>Орган выдачи документа</b><br>
                <input type="text" placeholder="Орган выдачи документа" name="issuningAuthority" id="issuningAuthority" required>
              </div>
              <div>
                  <b>Дата выдачи документа</b><br>
                  <input type="date" placeholder="Число/месяц/год*" name="documentIssueDate" id="DocumentIssueDate" required>
                  </div>    
                  <div>
                    <b>Срок истечения документа</b><br>
                    <input type="date" placeholder="Число/месяц/год*" name="documentExpirationDate" id="DocumentExpirationDate" required>
                  </div>
              <div>
                <b>Домашний адрес</b><br>
                <input type="text" placeholder="Страна" name="country" id="country" required>
                <input type="text" placeholder="Область" name="region" id="region" required>
              </div> 			
                <button id="pageIndv3" data-btn-next="3" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
                <button id="backIndv3" data-btn-next="2" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
                <br>
                <br>
                <br><b>Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
              </div>	
         </div>
         </div>
           <div id="indiv4"  class="panel-indv4">
            <div class="form-fields">
                    <div>
                        <input type="text" placeholder="Район"  name="area" id="area" required>
                <input type="text" placeholder="Почтовый индекс" name="postcode" id="postcode" required>
                <input type="text" placeholder="Город/село*" name="town" id="town" required>
                <input type="text" placeholder="Название улицы*" name="street" id="street" required>
                <input type="text" placeholder="Номер дома*" name="homeNum" id="homeNum" required>
                <input type="text" placeholder="Номер квартиры" name="apartments" id="apartments" required>
                    </div> 
              <div>
                        <b>Номер телефона*</b><br>
                        <select name="phoneType" id="phoneType">
                        <option>Мобильный</option>
                <option>Офисный</option>
                </select>
                <div style="display: d-flex; flex-direction:column">
                <select name="phoneType" id="phoneType">
                <option>+ Код страны</option>
                <option>+996</option>
                <option>+7</option>
                </select>
                <input type="text" placeholder="Пример:777007700" name="numberPhone" id="numberPhone" required>
              </div>
              <button id="addNum1" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img src="img/addNumber.png" width =24px
                height = 15px>Добавить номер</button>
                    </div> 
                    <br>
                    <div id ="extraNum1" class="extraNum1" style="display:none">
                        <select name="phoneType" id="phoneType">
                        <option>Мобильный</option>
                <option>Офисный</option>
                </select>
                <select name="phoneType2" id="phoneType2">
                <option>+ Код страны</option>
                <option>+996</option>
                <option>+7</option>
                </select>
                <input type="text" placeholder="Пример:777007700" name="numberPhone" id="numberPhone" required>
                    </div>
                <button id="pageIndv4" data-btn-next="5" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
                <button id="backIndv4" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
                <br>
                <br>
                <br><b>Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
          </div>	
         </div>
        
         <div id="indiv5" class="panel-indv5">
          <div class="form-fields">
            <div>
              <br>
              <br>
              <b>Электронная почта</b><br>
              <input type="email" placeholder="example@gmail.com" name="email" id="email" required>
            </div>
              <b>Пароль</b><br>
              <input type="password" value="FakePSW" name="password" id="myInput" ><br>
              <div class="form-footer">
                <button id="pageIndv5" data-btn-next="6" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
              </div>
              <br>
              <br>
              <button id="backIndv5" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
              <br>
              <br>
              <br><b style="float: left;">Есть аккаунт?</b>
              <a href="login.jsp" style="float: left;">Войти</a>
          </div>
        </div>
        <div id="legal2"  class="panel-legal2">
          <div class="form-fields">
              <div class="сitizenship">
                  <!-- <div>
                      <b>Гражданско-правовой статус*</b><br>
              <input type="radio" id="legal" value="Юридическое лицо" checked="checked">
              <label for="legal"></label><br>
              <input type="radio" id="individual" value="Физическое лицо">
              <label for="individual"></label><br> 
                  </div><br> -->
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select name="registersAccountLegal" id="registersAccountLegal">
                      <option value="kgz">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select>
              </div>
                  <div >
                      <b>Страна регистрации юридического лица</b><br>
                      <select name="сitizenshipsLegal" id="сitizenshipsLegal">
              <option value="kgz">Страна регистрации юридического лица</option>
                      <option value="kgz">Кыргызстан</option>
                      <option value="ru">Россия</option>
                      <option value="kz">Казакстан</option>
                      <option value="uz">Узбекистан</option>
                      </select>
                  </div>
                  <div>
                      <b>Наименование компании</b><br>
                      <input type="text" placeholder="ОсОО Компания" name="companyLegal" id="companyLegal" required>
                  </div>
              <button id="pageLegal2" data-btn-next="3" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
              <button id="backLegal2" data-btn-next="1" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
              <br>
              <br>
              <br><b>Есть аккаунт?</b>
              <a href="login.jsp">Войти</a>
        </div>	
       </div>
       
       <div id="legal3"  class="panel-legal3">
         <div class="form-fields">
            <div>
            <b>Идентификтор налогоплательщика</b><br>
            <input type="text" placeholder="Идентификтор налогоплательщика" name="TaxID" id="TaxID" required>
            </div>
          <div>
              <b>Юридический адрес</b><br>
              <input type="text" placeholder="Страна" name="countryLegal" id="countryLegal" required>
          <input type="text" placeholder="Область" name="regionLegal" id="regionLegal" required>
          <input type="text" placeholder="Район" name="areaLegal" id="areaLegal" required>
          <input type="text" placeholder="Почтовый индекс"name="postcodeLegal" id="postcodeLegal" required>
          <input type="text" placeholder="Город*" name="townLegal" id="townLegal" required>
          <input type="text" placeholder="Номер здания*" name="homeNumLegal" id="homeNumLegal" required>
          <input type="text" placeholder="Номер офиса" name="officeNumber" id="officeNumber" required>
            </div> 			
          <button id="pageLegal3" data-btn-next="4" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/right-arrow.png" width=25" height="25" ></button>
            <button id="backLegal3" data-btn-next="2" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
            <br>
            <br>
            <br><b>Есть аккаунт?</b>
            <a href="login.jsp">Войти</a>
          </div>	
        </div>
      
       
         <div id="legal4"  class="panel-legal4">
          <div class="form-fields">
            <button id ="confirmation" class="btn-default"  type="submit" style="float: center;">Подтверждение включения лица в реестр таможенных представителей</button>
         
          
          <div>
                  <b>Номер телефона*</b><br>
                  <select name="phoneTypeLegal" id="phoneTypeLegal">
              <option>Мобильный</option>
              <option>Офисный</option>
            </select>
            <select name="phoneTypeLegal" id="phoneTypeLegal">
                      <option>+ Код страны</option>
              <option>+996</option>
              <option>+7</option>
            </select>
            <input type="text" placeholder="Пример:777007700" name="numberPhone" id="numberPhone" required>
                  </div> 
                  <div>
                    <button id="addNum2" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img src="img/addNumber.png" width =24px
                      height = 15px>Добавить номер</button>
                  </div><br>
            <div id = "extraNum2" class="extraNum2" style="display:none">
                      <select name="phoneTypeLegal2" id="phoneTypeLegal2">
                      <option>Мобильный</option>
              <option>Офисный</option>
              </select>
              <select name="phoneTypeLegal2" id="phoneTypeLegal2">
                      <option>+ Код страны</option>
              <option>+996</option>
              <option>+7</option>
              </select>
              <input type="text" placeholder="Пример:777007700" name="numberPhone" id="numberPhone" required>
                  </div>
            <div>
                      <b>Электронная почта</b><br>
                      <input type="email" placeholder="example@gmail.com" name="emailLegal" id="emailLegal" required>
                   </div>
                       <b>Пароль</b><br>
                       <input type="password" value="FakePSW" name="passwordLegal" id="passwordLegal"><br>
               
              <button id="pageLegal4" data-btn-next="5" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
    
              <br>
              <button id="backLegal4" data-btn-next="4" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
              <br>
              <br>
              <br><b>Есть аккаунт?</b>
              <a href="login.jsp">Войти</a>
        </div>	
       </div>
       
      <div id="legal5"  class="panel-legal5">
        <div class="form-fields">
          <div style="border: 1px solid rgb(10, 8, 8);padding: 5px;">
            <b>Подтверждение включения лица в реестр таможенных представителей</b><br>
            </div><br> 
            <div>
            <b>Страна включившая лицо в реестр</b><br>
            <select name="includedPerson">
                    <option>Кыргызстан</option>
                    <option>Казакстан</option>
                </select>
            </div>
            <div>
              <b>Регистрационный номер юридического лица при включении в реестр</b><br>
            <input type="text" placeholder="Регистрационный номер" name="registrationNumber" id="registratioNumber">
          </div> 
            <div>
              <b>Код признака перегистрации документа</b><br>
            <input type="text" placeholder="Код перерегисрации документа" name="documentRegistrationCode" id="documentRegistrationCode">
          </div> 	
          <button id="pageLegal5" data-btn-next="6" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>       
             <button id="backLegal5" data-btn-next="5" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/left-arrow.png" width=25" height="25" >Назад</button>
          <br>
          <br>
          <br><b>Есть аккаунт?</b>
          <a href="login.jsp">Войти</a>
            </div>	
        </div>
        <div id="id6" class="panel-body6">
          <div class="form-fields">
            <p style="text-align:center;"></p><img src="img/axelor.png" width="50px" class="logo"></p><br>
            <h2 class="fs-title"><b>Предварительное информирование</b></h2>
            <h3 class="fs-subtitle" style="color:rgb(18, 216, 107)">Проверьте электронную почту и подтвердите Ваши данные</h3>
            <a href="login.jsp" ><p style="text-align:center;">Назад</p></a>
          </div>
        </div>
        </form>
           </div>
                              
           

        <script>
          const user = $(document.getElementById('msform'));
              user.submit(function(e){
                e.preventDefault();
                var submit = true;
                // evaluate the form using generic validaing
                if( !validator.checkAll( $(this) ) ){
                  submit = false;
                }
                if( submit )
                  this.submit();
                return false;
              });
  

            </script> 
  </body>
</html>



