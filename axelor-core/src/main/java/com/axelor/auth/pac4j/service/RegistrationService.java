package com.axelor.auth.pac4j.service;

import java.sql.*;

public class RegistrationService {

  public Connection getConnection() {
    final String USER = "postgres";
    final String PASS = "axelor";
    final String DB_URL = "jdbc:postgresql://localhost:5432/sanarip_db";
    Connection connection = null;
    try {
      connection = DriverManager.getConnection(DB_URL, USER, PASS);
      return connection;
    } catch (SQLException e) {
    }
    return null;
  }

  public int createEmployee(
      String dateOfBirth,
      String phoneType,
      String phoneType2,
      String names,
      String сitizenships,
      String town,
      String country,
      String area,
      String passport,
      String documentExpirationDate,
      String documentIssueDate,
      String issuningAuthority,
      Connection connectionP) {

    int id = getLastEmployeeId(connectionP) + 1;
    String sqlInsert =
        "INSERT INTO hr_employee ( "
            + " id, version, created_on, birth_date,  "
            + " external, fixed_pro_phone, hourly_rate, hr_manager, lunch_voucher_format_select, "
            + " marital_status,  mobile_pro_phone ,  name, "
            + " step_by_step_select, time_logging_preference_select, "
            + " timesheet_imputation_select, timesheet_reminder, "
            + " weekly_work_hours, created_by, "
            + " citizenship,  city_of_birth, country_of_birth, department_of_birth, "
            + " imposed_day_events_planning, public_holiday_events_planning, "
            + " weekly_planning, "
            + " passport , passport_expiration_date , passport_issue_date , passport_issued_by, "
            + " contact_partner) "
            + "values( "
            + id
            + ",4,current_timestamp,to_date('"
            + dateOfBirth
            + "','yyyy-mm-dd'),true,'"
            + phoneType
            + "',0,false,0, "
            + "2,'"
            + phoneType2
            + "','"
            + names
            + "',5,'days',1,false,0,1,"
            + сitizenships
            + ","
            + town
            + ","
            + country
            + ","
            + area
            + ", "
            + "1,1,1,'"
            + passport
            + "',to_date('"
            + documentExpirationDate
            + "','yyyy-mm-dd'),to_date('"
            + documentIssueDate
            + "','yyyy-mm-dd'),'"
            + issuningAuthority
            + "',1) ";
    if (connectionP != null) {
      createNewEmployee(sqlInsert, connectionP);
    }
    return id;
  }

  public void createUser(
      String password,
      String login,
      String username,
      String email,
      int employee_id,
      Connection connectionP) {
    int id = getLastUserId(connectionP) + 1;
    String insertSQl =
        "INSERT INTO AUTH_USER(id,activate_on,expires_on,code,group_id,name,password,blocked,force_password_change,is_include_sub_context_projects,"
            + "is_pfp_validator,is_super_pfp_user,language,no_help,receive_emails,send_email_upon_password_change,single_tab,use_signature_for_purchase_quotations,"
            + "use_signature_for_sales_quotations,use_signature_for_stock,created_on ,email,version,full_name,step_status_select,employee) "
            + "VALUES ("
            + id
            + ",current_timestamp, to_date('01.01.2035', 'dd.mm.yyyy' ), '"
            + login
            + "', 4,'"
            + username
            + "','"
            + password
            + "',false,false,false,false,false,"
            + "'ru',false,true,true,false,false,false,false,current_timestamp,'"
            + email
            + "',4,'"
            + username
            + "',5,"
            + employee_id
            + ")";
    try (Statement stmt = connectionP.createStatement()) {
      stmt.executeUpdate(insertSQl);
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public void createNewEmployee(String sql, Connection connectionP) {
    try (Statement stmt = connectionP.createStatement()) {
      stmt.executeUpdate(sql);
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public int getLastEmployeeId(Connection connectionP) {
    String sql = "select id from HR_EMPLOYEE order by id desc limit 1";
    try (Statement stmt = connectionP.createStatement()) {
      ResultSet rs = stmt.executeQuery(sql);
      while (rs.next()) {
        return rs.getInt("id");
      }
    } catch (Exception e) {
    }
    return 0;
  }

  public int getLastUserId(Connection connectionP) {
    String sql = "select id from AUTH_USER order by id desc limit 1";
    try {
      Statement stmt = connectionP.createStatement();
      ResultSet rs = stmt.executeQuery(sql);
      while (rs.next()) {
        return rs.getInt("id");
      }
    } catch (Exception e) {
    }
    return 0;
  }
}
