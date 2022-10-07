package com.midterm.Midterm.dao;

import com.midterm.Midterm.beans.User;
import com.midterm.Midterm.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class UserDAO {
    public static boolean checkExistByEmail(String email) {
        final String query = "select * from user where email = :email";
        try (Connection con = DbUtils.getConnection()) {
            List<User> list = con.createQuery(query)
                    .addParameter("email", email)
                    .executeAndFetch(User.class);
            if (list.size() == 0) {
                return false;
            }
            return true;
        }
    }
    public static boolean addUser(User c) {
        String insertSql = "INSERT INTO user (name, email, password) VALUES (:name,:email,:password)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("name", c.getName())
                    .addParameter("email", c.getEmail())
                    .addParameter("password", c.getPassword())
                    .executeUpdate();
            return true;
        }catch (Exception e){
            return false;
        }
    }
    public static User findUserByEmail(String email,String password) {
        final String query = "select * from user where email = :email and password=:password";
        try (Connection con = DbUtils.getConnection()) {
            List<User> list = con.createQuery(query)
                    .addParameter("email", email)
                    .addParameter("password", password)
                    .executeAndFetch(User.class);
            if (list.size() == 0) {
                return null;
            }
            return list.get(0);
        }
    }
}
