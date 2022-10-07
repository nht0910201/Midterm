package com.midterm.Midterm.controllers;

import com.midterm.Midterm.beans.Product;
import com.midterm.Midterm.dao.ProductDAO;
import com.midterm.Midterm.utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product/*")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/manage":
                List<Product> products = ProductDAO.findAll();
                request.setAttribute("productList",products);
                ServletUtils.forward("/views/product.jsp", request, response);
                break;
            case "/more":
                ServletUtils.forward("/views/204.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/add":
                addProduct(request,response);
                break;
            case "/delete":
                deleteProduct(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String product_name = request.getParameter("product_name");
        Double price = Double.parseDouble(request.getParameter("price"));
        if(product_name.equals("")){
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Please enter product name");
            ServletUtils.forward("/views/product.jsp",request,response);
        }else{
            boolean checkExist = ProductDAO.checkExistByProductName(product_name);
            if(checkExist)
            {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Product already exist");
                ServletUtils.forward("/views/product.jsp",request,response);
            }else{
                Product newProduct = new Product(product_name,price);
                boolean add = ProductDAO.addProduct(newProduct);
                if(add){
//                    List<Product> products = ProductDAO.findAll();
//                    request.setAttribute("products",products);
                    ServletUtils.redirect("/product/manage",request,response);
                }else{
                    request.setAttribute("hasError", true);
                    request.setAttribute("errorMessage", "Product already exist");
                    ServletUtils.forward("/views/product.jsp",request,response);
                }
            }
        }

    }
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("pro_id"));
        boolean check = ProductDAO.deleteProduct(id);
        if(check)
        {
            ServletUtils.redirect("/product/manage", request, response);
        }else{
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Delete product failed");
            ServletUtils.forward("/views/product.jsp",request,response);
        }

    }
}
