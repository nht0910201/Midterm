package com.midterm.Midterm.dao;

import com.midterm.Midterm.beans.Product;
import com.midterm.Midterm.utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class ProductDAO {
    public static List<Product> findAll(){
        final String query = "select * from product";
        try (Connection con = DbUtils.getConnection()) {
             List<Product> list = con.createQuery(query)
                    .executeAndFetch(Product.class);
             return list;
        }
    }
    public static boolean checkExistByProductName(String name) {
        final String query = "select * from product where name = :name";
        try (Connection con = DbUtils.getConnection()) {
            List<Product> list = con.createQuery(query)
                    .addParameter("name", name)
                    .executeAndFetch(Product.class);
            if (list.size() == 0) {
                return false;
            }
            return true;
        }
    }
    public static boolean addProduct(Product p) {
        String insertSql = "INSERT INTO product (name, price) VALUES (:name,:price)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("name", p.getName())
                    .addParameter("email", p.getPrice())
                    .executeUpdate();
            return true;
        }catch (Exception e){
            return false;
        }
    }
    public static boolean deleteProduct(int id) {
        String Sql = "delete from product where id=:id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(Sql)
                    .addParameter("id", id)
                    .executeUpdate();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
