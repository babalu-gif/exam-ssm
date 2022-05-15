package com.my.filter;


import com.my.entity.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("过滤器初始化");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        // 1.得到HttpServletRequest
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        // 2.获取session
        HttpSession session = request.getSession();

        // 3，得到User对象
        User user = (User) session.getAttribute("user");

        // 4.得到请求路径
        String url = request.getRequestURI();

        // 5. 判断session是否存在user对象  如果存在,表示已登录;不存在,则未登录
        // indexOf 方法的作用   如果包含子字符串  则返回 子字符串的索引  如果不包含  则返回 -1
        if (user == null && url.indexOf("login.do") == -1) {
            // 重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        }
        else {
            // 过滤器放行
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {
        System.out.println("过滤器销毁");
    }
}
