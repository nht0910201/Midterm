package com.midterm.Midterm.filters;

import com.midterm.Midterm.beans.User;
import com.midterm.Midterm.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter")
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        boolean auth = (boolean) session.getAttribute("auth");
        User authUser = (User) session.getAttribute("authUser");
        if (auth == false) {
            ServletUtils.redirect("/auth/login",req,res);
            return;
        }
        chain.doFilter(request, response);
    }
}
