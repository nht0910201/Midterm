package com.midterm.Midterm.controllers;

import com.midterm.Midterm.beans.User;
import com.midterm.Midterm.dao.UserDAO;
import com.midterm.Midterm.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AuthServlet", value = "/auth/*")
public class AuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/register":
                ServletUtils.forward("/views/register.jsp", request, response);
                break;
            case "/login":
                ServletUtils.forward("/views/login.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        request.setCharacterEncoding("UTF-8");
        switch (path) {
            case "/register":
                registerUser(request, response);
                break;
            case "/login":
                login(request, response);
                break;
            case "/logout":
                logout(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean userExist = UserDAO.checkExistByEmail(email);
        if(userExist){
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Email already exist");
            ServletUtils.forward("/views/register.jsp",request,response);
        }
        else{
            User newUser = new User(name, email,password);
            boolean check = UserDAO.addUser(newUser);
            if(check)
            {
                ServletUtils.redirect("/auth/login", request, response);
            }else{
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Has error when occurred");
                ServletUtils.forward("/views/register.jsp",request,response);
            }
        }
    }
    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        User user = UserDAO.findUserByEmail(email,password);
        if(user != null){
            HttpSession session = request.getSession();
            session.setAttribute("auth", true);
            session.setAttribute("authUser", user);
            ServletUtils.redirect("/product/manage",request,response);
        }else{
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Incorrect username or password");
            ServletUtils.forward("/views/login.jsp", request, response);
        }

    }
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());
        ServletUtils.redirect("/auth/login", request, response);
    }
}
