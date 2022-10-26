package com.axelor.auth.pac4j.service;

import java.sql.*;

public class RegistrationService {

  public Connection getConnection() {
    final String USER = "postgres";
    final String PASS = "postgres";
    final String DB_URL = "jdbc:postgresql://localhost:5433/sanarip_db";
    Connection connection = null;
    try {
      connection = DriverManager.getConnection(DB_URL, USER, PASS);
      return connection;
    } catch (SQLException e) {
    }
    return null;
  }

  public void createUser(
      String password, String login, String username, String email, Connection connectionP) {
    int id = getLastUserId(connectionP) + 1;
    String insertSQl =
        "INSERT INTO AUTH_USER(id,activate_on,expires_on,code,group_id,name,password,blocked,force_password_change,is_include_sub_context_projects,"
            + "is_pfp_validator,is_super_pfp_user,language,no_help,receive_emails,send_email_upon_password_change,single_tab,use_signature_for_purchase_quotations,"
            + "use_signature_for_sales_quotations,use_signature_for_stock,created_on ,email,version,full_name,step_status_select) "
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
            + "',5) ";
    System.out.println(insertSQl);
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
