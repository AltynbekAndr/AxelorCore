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
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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
<%@ page import="com.axelor.auth.db.Country" %>

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






    <div id="register" class="animate form">
        <form id="registration" action="registration.jsp" method="POST" required=""> 
        
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
              <div>
                <button id="pageOne" data-btn-next="2" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button>
                <br><b>Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
              </div>
            </div>
        </div>
      
      <!-- Second page -->
        <div id="cityChoose"  class="panel-indv2 panel-legal2">
          <div class="form-fields"  style="height: 720px;">
            <div class="сitizenship">
              <b>Гражданско-правовой статус*</b>
              <div  class="radio">
              <input type="radio" id="legal" value="Юридическое лицо" name="btnRadio" class="radio__input">
              <label for="legal" class="radio__label">Юридическое лицо</label><br>
          </div>
          <div class="radio">
              <input type="radio" id="individual" value="Физическое лицо" name="btnRadio" class="radio__input">
              <label for="individual" class="radio__label">Физическое лицо</label> 
          </div>
            </div>
                <br>
                <div id="indiv2" >
                  
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select class="indivSelect" name="registersAccount" id="registersAccount" required>
                      <option value="1">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select>
              
                  <br>
                      <b>Гражданство</b><br>
                      <select class="indivSelect" name="сitizenships" id="сitizenships" required>
                        <option value="1" >Выберите страну</option>  
                      <option value="kgz">Кыргызстан</option>
                      <option value="ru">Россия</option>
                      <option value="kz">Казакстан</option>
                      <option value="uz">Узбекистан</option>
                      </select>
             
                  <div style="margin-top: 10px;">
                      <b>Идентификатор физического лица</b><br>
                      <input type="text" min="5" placeholder="Идентификатор физического лица" name="passport" id="passport" required >
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
                  <button id="pageIndv2" data-btn-next="2" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25"></button>
                  <button id="backIndv2" data-btn-next="1" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
                  <br>
                  <br>
                  <br><b>Есть аккаунт?</b>
                  <a href="login.jsp">Войти</a>
                </div>
                

                <div id="legal2" class="сitizenship">
                 <br> 
                      <b>Кем регистрируется данный аккаунт</b><br>
                      <select name="registersAccountLegal" id="registersAccountLegal">
                      <option value="1">Пожалуйста, выберите из выпадающего списка*</option>
                      <option value="ru">Выбор1</option>
                      <option value="kz">Выбор2</option>
                      <option value="uz">Выбор3</option>
                      </select>


                      <div >
                        <b>Страна регистрации юридического лица</b><br>
                        <select name="сitizenshipsLegal" id="сitizenshipsLegal" required = "required">
                        <option value="1">Страна регистрации юридического лица</option>
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
                <button id="pageLegal2" data-btn-next="3" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button>
                <button id="backLegal2" data-btn-next="1" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
                <br>
                <br>
                <br><b>Есть аккаунт?</b>
                <a href="login.jsp">Войти</a>
          </div>	
              </div>


                
        </div>	





         
        <div id="indiv3"  class="panel-indv3">
          <div class="form-fields"  >
            <div>
             <div>
                <b>Домашний адрес</b><br><br>
                <select name="country" id="countryIndiv" required="" >
                      <option value=1>AFGHANISTAN</option>
                      <option value=2>SOUTH AFRICA</option>
                      <option value=3>ALBANIA</option>
                      <option value=4>ALGERIA</option>
                      <option value=5>GERMANY</option>
                      <option value=6>ANDORRA</option>
                      <option value=7>ANGOLA</option>
                      <option value=8>ANTIGUA-AND-BARBUDA</option>
                      <option value=9>SAUDI ARABIA</option>
                      <option value=10>ARGENTINA</option>
                      <option value=11>ARMENIA</option>
                      <option value=12>AUSTRALIA</option>
                      <option value=13>AUSTRIA</option>
                      <option value=14>AZERBAIDJAN</option>
                      <option value=15>BAHAMAS</option>
                      <option value=16>BAHRAIN</option>
                      <option value=17>BANGLADESH</option>
                      <option value=18>BARBADOS</option>
                      <option value=19>BELGIUM</option>
                      <option value=20>BELIZE</option>
                      <option value=21>BENIN</option>
                      <option value=22>BHUTAN</option>
                      <option value=23>BELARUS</option>
                      <option value=24>MYANMAR</option>
                      <option value=25>BOLIVIA</option>
                      <option value=26>BOSNIA-HERZEGOVINA</option>
                      <option value=27>BOTSWANA</option>
                      <option value=28>BRAZIL</option>
                      <option value=29>BRUNEI DURASSALAM</option>
                      <option value=30>BULGARIA</option>
                      <option value=31>BURKINA FASO</option>
                      <option value=32>BURUNDI</option>
                      <option value=33>CAMBODIA</option>
                      <option value=34>CAMEROON</option>
                      <option value=35>CANADA</option>
                      <option value=36>CABO VERDE</option>
                      <option value=37>CENTRAL AFRICAN (REPUBLIC)</option>
                      <option value=38>CHILE</option>
                      <option value=39>CHINA</option>
                      <option value=40>CYPRUS</option>
                      <option value=41>COLOMBIA</option>
                      <option value=42>COMOROS</option>
                      <option value=43>CONGO (REPUBLIC)</option>
                      <option value=44>CONGO (DEMOCRATIC REPUBLIC)</option>
                      <option value=45>KOREA (REPUBLIC OF)</option>
                      <option value=46>KOREA (DEMOCRATIC REPUBLIC)</option>
                      <option value=47>COSTA RICA</option>
                      <option value=48>COTE D’IVOIRE</option>
                      <option value=49>CROATIA</option>
                      <option value=50>CUBA</option>
                      <option value=51>DENMARK</option>
                      <option value=52>DJIBOUTI</option>
                      <option value=53>DOMINICAN (REPUBLIC)</option>
                      <option value=54>DOMINICA</option>
                      <option value=55>EGYPT</option>
                      <option value=56>EL SALVADOR</option>
                      <option value=57>UNITED ARAB EMIRATES</option>
                      <option value=58>ECUADOR</option>
                      <option value=59>ERITREA</option>
                      <option value=60>SPAIN</option>
                      <option value=61>ESTONIA</option>
                      <option value=62>UNITED STATES OF AMERICA</option>
                      <option value=63>ETHIOPIA</option>
                      <option value=64>MACEDONIA</option>
                      <option value=65>FIJI</option>
                      <option value=66>FINLAND</option>
                      <option value=67>FRANCE</option>
                      <option value=68>GABON</option>
                      <option value=69>GAMBIA</option>
                      <option value=70>GEORGIA</option>
                      <option value=71>GHANA</option>
                      <option value=72>GREECE</option>
                      <option value=73>GRENADA</option>
                      <option value=74>GUATEMALA</option>
                      <option value=75>GUINEA</option>
                      <option value=76>EQUATORIAL GUINEA</option>
                      <option value=77>GUINEA-BISSAU</option>
                      <option value=78>GUYANA</option>
                      <option value=79>HAITI</option>
                      <option value=80>HONDURAS</option>
                      <option value=81>HUNGARY</option>
                      <option value=82>INDIA</option>
                      <option value=83>INDONESIA</option>
                      <option value=84>IRAN</option>
                      <option value=85>IRAQ</option>
                      <option value=86>IRELAND</option>
                      <option value=87>ICELAND</option>
                      <option value=88>ISRAEL</option>
                      <option value=89>ITALY</option>
                      <option value=90>JAMAICA</option>
                      <option value=91>JAPAN</option>
                      <option value=92>JORDAN</option>
                      <option value=93>KAZAKHSTAN</option>
                      <option value=94>KENYA</option>
                      <option value=95>KYRGYZSTAN</option>
                      <option value=96>KIRIBATI</option>
                      <option value=97>KOSOVO</option>
                      <option value=98>KUWAIT</option>
                      <option value=99>LAO</option>
                      <option value=100>LESOTHO</option>
                      <option value=101>LATVIA</option>
                      <option value=102>LEBANON</option>
                      <option value=103>LIBERIA</option>
                      <option value=104>LIBYA</option>
                      <option value=105>LIECHTENSTEIN</option>
                      <option value=106>LITHUANIA</option>
                      <option value=107>LUXEMBOURG</option>
                      <option value=108>MADAGASCAR</option>
                      <option value=109>MALAYSIA</option>
                      <option value=110>MALAWI</option>
                      <option value=111>MALDIVES</option>
                      <option value=112>MALI</option>
                      <option value=113>MALTA</option>
                      <option value=114>MOROCCO</option>
                      <option value=115>MARSHALL ISLANDS</option>
                      <option value=116>MAURITIUS</option>
                      <option value=117>MAURITANIA</option>
                      <option value=118>MEXICO</option>
                      <option value=119>MICRONESIA (FEDERATED STATES OF)</option>
                      <option value=120>MOLDOVA</option>
                      <option value=121>MONACO</option>
                      <option value=122>MONGOLIA</option>
                      <option value=123>MONTENEGRO</option>
                      <option value=124>MOZAMBIQUE</option>
                      <option value=125>NAMIBIA</option>
                      <option value=126>NAURU</option>
                      <option value=127>NEPAL</option>
                      <option value=128>NICARAGUA</option>
                      <option value=129>NIGER</option>
                      <option value=130>NIGERIA</option>
                      <option value=131>NORWAY</option>
                      <option value=132>NEW-ZEALAND</option>
                      <option value=133>OMAN</option>
                      <option value=134>UGANDA</option>
                      <option value=135>UZBEKISTAN</option>
                      <option value=136>PAKISTAN</option>
                      <option value=137>PALAU (ISLANDS)</option>
                      <option value=138>PANAMA</option>
                      <option value=139>PAPUA-NEW-GUINEA</option>
                      <option value=140>PARAGUAY</option>
                      <option value=141>NETHERLANDS</option>
                      <option value=142>PERU</option>
                      <option value=143>PHILIPPINES</option>
                      <option value=144>POLAND</option>
                      <option value=145>PORTUGAL</option>
                      <option value=146>QATAR</option>
                      <option value=147>ROMANIA</option>
                      <option value=148>UNITED-KINGDOM</option>
                      <option value=149>RUSSIAN FEDERATION</option>
                      <option value=150>RWANDA</option>
                      <option value=151>SAINT-KITTS-AND-NEVIS</option>
                      <option value=152>SAINT-LUCIA</option>
                      <option value=153>SAN-MARINO</option>
                      <option value=154>SAINT-VINCENT-AND-THE-GRENADINES</option>
                      <option value=155>SOLOMON ISLANDS</option>
                      <option value=156>SAMOA</option>
                      <option value=157>SAO-TOME-AND-PRINCIPE</option>
                      <option value=158>SENEGAL</option>
                      <option value=159>SERBIA</option>
                      <option value=160>SEYCHELLES</option>
                      <option value=161>SIERRA LEONE</option>
                      <option value=162>SINGAPORE</option>
                      <option value=163>SLOVAKIA</option>
                      <option value=164>SLOVENIA</option>
                      <option value=165>SOMALIA</option>
                      <option value=166>SUDAN</option>
                      <option value=167>SRI LANKA</option>
                      <option value=168>SWEDEN</option>
                      <option value=169>SWITZERLAND</option>
                      <option value=170>SURINAME</option>
                      <option value=171>SWAZILAND</option>
                      <option value=172>SYRIAN ARAB REPUBLIC</option>
                      <option value=173>TAJIKISTAN</option>
                      <option value=174>TANZANIA</option>
                      <option value=175>CHAD</option>
                      <option value=176>CZECHIA</option>
                      <option value=177>THAILAND</option>
                      <option value=178>TIMOR-LESTE</option>
                      <option value=179>TOGO</option>
                      <option value=180>TONGA</option>
                      <option value=181>TRINIDAD-AND-TOBAGO</option>
                      <option value=182>TUNISIA</option>
                      <option value=183>TURKMENISTAN</option>
                      <option value=184>TURKEY</option>
                      <option value=185>TUVALU</option>
                      <option value=186>UKRAINE</option>
                      <option value=187>URUGUAY</option>
                      <option value=188>VANUATU</option>
                      <option value=189>HOLY SEE (VATICAN)</option>
                      <option value=190>VENEZUELA</option>
                      <option value=191>VIETNAM</option>
                      <option value=192>YEMEN</option>
                      <option value=193>ZAMBIA</option>
                      <option value=194>ZIMBABWE</option>
                      <option value=195>ÂLAND ISLAND</option>
                      <option value=196>AMERICAN SAMOA</option>
                      <option value=197>ANTARCTICA</option>
                      <option value=198>BONAIRE, SINT EUSTATIUS AND SABA</option>
                      <option value=199>BOUVET ISLAND</option>
                      <option value=200>BRITISH INDIAN OCEAN TERRITORY</option>
                      <option value=201>CAYMAN ISLANDS</option>
                      <option value=202>CHRISTMAS ISLAND</option>
                      <option value=203>COCOS (KEELING) ISLANDS</option>
                      <option value=204>COOK ISLANDS</option>
                      <option value=205>CURAÇAO</option>
                      <option value=206>FALKLAND ISLANDS (MALVINAS)</option>
                      <option value=207>FAROE ISLANDS</option>
                      <option value=208>FRENCH GUIANA</option>
                      <option value=209>FRENCH POLYNESIA</option>
                      <option value=210>FRENCH SOUTHERN TERRITORIES</option>
                      <option value=211>GIBRALTAR</option>
                      <option value=212>GREENLAND</option>
                      <option value=213>GUADELOUPE</option>
                      <option value=214>GUAM</option>
                      <option value=215>GUERNSEY</option>
                      <option value=216>HEARD ISLAND AND MCDONALD ISLANDS</option>
                      <option value=217>HONG KONG</option>
                      <option value=218>ISLE OF MAN</option>
                      <option value=219>JERSEY</option>
                      <option value=220>MACAO</option>
                      <option value=221>MARTINIQUE</option>
                      <option value=222>MAYOTTE</option>
                      <option value=223>MONTSERRAT</option>
                      <option value=224>NEW CALEDONIA</option>
                      <option value=225>NIUE</option>
                      <option value=226>NORTHERN MARIANA ISLANDS</option>
                      <option value=227>PALESTINE</option>
                      <option value=228>PITCAIRN</option>
                      <option value=229>PUERTO RICO</option>
                      <option value=230>REUNION</option>
                      <option value=231>SAINT BARTHELEMY</option>
                      <option value=232>SAINT HELENA, ASCENSION AND TRISTAN DE CUNHA</option>
                      <option value=233>SAINT MARTIN (FRENCH PART)</option>
                      <option value=234>SAINT PIERRE AND MIQUELON</option>
                      <option value=235>SINT MARTEEN (DUTCH PART)</option>
                      <option value=236>SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS</option>
                      <option value=237>SOUTH SUDAN</option>
                      <option value=238>SVALBARD AND JAN MAYEN</option>
                      <option value=239>TAIWAN</option>
                      <option value=240>TOKELAU</option>
                      <option value=241>TURKS AND CAICOS ISLANDS</option>
                      <option value=242>UNITED STATES MINOR OUTLYING ISLANDS</option>
                      <option value=243>VIRGIN ISLANDS (BRITISH)</option>
                      <option value=244>VIRGIN ISLANDS (U.S.)</option>
                      <option value=245>WALLIS AND FUTUNA</option>
                      <option value=246>WESTERN SAHARA</option>
                  </select>
                <select name="region" id="regionIndiv" required="" >
                  <option value="1">Область*</option>
                  <option value="ru">Выбор1</option>
                  <option value="kz">Выбор2</option>
                  <option value="uz">Выбор3</option>
                  </select>
                <select name="area" id="areaIndiv" required="" >
                  <option value="1">Район*</option>
                  <option value="ru">Выбор1</option>
                  <option value="kz">Выбор2</option>
                  <option value="uz">Выбор3</option>
                  </select>
                <input type="text" placeholder="Почтовый индекс" name="postcode" id="postcodeIndiv"><br>
                <select name="town" id="townIndiv" required="" >
                  <option value="1">Город*</option>
                  <option value="ru">Выбор1</option>
                  <option value="kz">Выбор2</option>
                  <option value="uz">Выбор3</option>
                  </select>
                <input type="text" placeholder="Название улицы*" name="street" id="streetIndiv"><br>
                <input type="text" placeholder="Номер дома*" name="homeNum" id="homeNumIndiv"><br>
                <input type="text" placeholder="Номер квартиры" name="apartments" id="apartmentsIndiv">
            </div>
           
                <button id="pageIndv3" data-btn-next="3" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button>
                <button id="backIndv3" data-btn-next="2" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
                <br>
                <br>
                <br><b>Есть аккаунт?</b>
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
                   
              <div>
                        <b>Номер телефона*</b><br>
                        <select name="phoneType" id="phoneTypeIndiv1">
                        <option>Мобильный</option>
                <option>Офисный</option>
                </select>
                <select name="phoneType" id="phoneCodeIndiv1">
                        <option value="1">+ Код страны</option>
                <option>+996</option>
                <option>+7</option>
                </select>
                <input type="text" name="phoneNumIndiv1" id="phoneNumIndiv1"/>
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
                <input  type="text" name="phoneNumIndiv2"/>
                    </div>
              <div class="form-footer">
                <button id="pageIndv4" data-btn-next="6" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
              </div>
              <br>
              <br>
              <button id="backIndv4" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
              <br>
              <br>
              <br><b style="float: left;">Есть аккаунт?</b>
              <a href="login.jsp" style="float: left;">Войти</a>
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
                <option value="1">Страна*</option>
                <option value="ru">Выбор1</option>
                <option value="kz">Выбор2</option>
                <option value="uz">Выбор3</option>
                </select>
              <!-- <input type="text" placeholder="Страна" name="country" id="country" required><br> -->
              <select name="regionLegal" id="regionLegal" required="" >
                <option value="1">Область*</option>
                <option value="ru">Выбор1</option>
                <option value="kz">Выбор2</option>
                 <option value="uz">Выбор3</option>
                </select>
              <!-- <input type="text" placeholder="Область" name="region" id="region" required><br> -->
              <select name="areaLegal" id="areaLegal" required="" >
                <option value="1">Район*</option>
                <option value="ru">Выбор1</option>
                <option value="kz">Выбор2</option>
                <option value="uz">Выбор3</option>
                </select>
              <!-- <input type="text" placeholder="Район"  name="area" id="area" required><br> -->
              <input type="text" placeholder="Почтовый индекс" name="postcodeLegal" id="postcodeLegal"><br>
              <!-- <input type="text" placeholder="Город/село*" name="town" id="town" required><br> -->
              <select name="town" id="townLegal" required="" >
                <option value="1">Город*</option>
                <option value="ru">Выбор1</option>
                <option value="kz">Выбор2</option>
                <option value="uz">Выбор3</option>
                </select>
          <input type="text" placeholder="Номер здания*" name="homeNumLegal" id="homeNumLegal" required>
          <input type="text" placeholder="Номер офиса" name="officeNumber" id="officeNumber" required>
            </div> 			
          <button id="pageLegal3" data-btn-next="4" class="btn btn-link"  type="submit" style="float: right;">Вперед<img alt="Вперед" src="img/forward.png" width=25" height="25" ></button>
            <button id="backLegal3" data-btn-next="2" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
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
                  <select name="phoneTypeLegal1" id="phoneTypeLegal1">
              <option>Мобильный</option>
              <option>Офисный</option>
            </select>
            <select name="phoneCodeLegal1" id="phoneCodeLegal1">
                      <option>+ Код страны</option>
              <option>+996</option>
              <option>+7</option>
            </select>
            <input type="text" name="phoneNumLegal1" id="phoneNumLegal1"/>
                  </div> 
                  <div>
                    <button id="addNum2" data-btn-next="3" class="btn btn-link"  type="submit" style="float: left;"><img src="img/addPhone.png" width =24px
                      height = 15px>Добавить номер</button>
                  </div><br>
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
              <input type="text" name="phoneNumLegal2"/>
                  </div>
            <div>
                      <b>Электронная почта</b><br>
                      <input type="email" placeholder="example@gmail.com" name="emailLegal" id="emailLegal" required>
                   </div>
                       <b>Пароль</b><br>
                       <br>
               
              <button id="pageLegal4" data-btn-next="5" class="btn btn-primary btn-lg btn-block"  type="submit" style="float: center;">Зарегистрироваться</button>
              <br>
              <button id="backLegal4" data-btn-next="4" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
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
            <input type="text" placeholder="Код перерегисрации документа" name="documentRegistrationCode" id="">
          </div> 	
             <button id="backLegal5" data-btn-next="5" class="btn btn-link"  type="submit" style="float: left;"><img alt="Назад" src="img/back.png" width=25" height="25" >Назад</button>
          <br>
          <br>
          <br><b id="account">Есть аккаунт?</b>
          <a href="login.jsp">Войти</a>
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



