package com.my.controller;

import com.my.entity.User;
import com.my.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController
{
    @Autowired
    private UserService userService;

    // 修改用户信息
    @ResponseBody
    @RequestMapping(value = "/set.do")
    public void set(User user)
    {
        boolean flag = userService.set(user);
        return;
    }

    // 根据id值查找用户
    @ResponseBody
    @RequestMapping(value = "/getById.do")
    public User getById(Integer user_id)
    {
        User user = userService.getById(user_id);
        return user;
    }

    // 新增用户
    @ResponseBody
    @RequestMapping(value = "/save.do")
    public void save(User user)
    {
        boolean flag = userService.save(user);
        return;
    }

    // 删除用户
    @ResponseBody
    @RequestMapping(value = "/deleteById.do")
    public void deleteById(Integer user_id)
    {
        boolean flag = userService.deleteById(user_id);
        return;
    }

    // 根据条件查找用户
    @ResponseBody
    @RequestMapping(value = "/find.do")
    public List<User> find(User user)
    {
        List<User> userList = userService.find(user);
        return userList;
    }

    // 获取所有用户信息
    @RequestMapping(value = "/getAll.do")
    public String getAll(HttpServletRequest request)
    {
        List<User> userList = userService.getAll();
        request.setAttribute("userList", userList);
        return "users";
    }

    // 登录验证
    @RequestMapping(value = "/login.do")
    public String login(HttpSession session, Model model, User u)
    {
        User user = userService.login(u);
        if(user != null)
        {
            session.setAttribute("user", user);
            return "main";
        }
        else
        {
            model.addAttribute("errmsg", "用户名或密码错误");
        }
        return "login";
    }

    // 用户注册
    @RequestMapping(value = "/register.do")
    public String register(HttpServletRequest request, Model model, String myname, String mypwd)
    {
        boolean flag = userService.register(myname, mypwd);
        if(flag)
        {
            model.addAttribute("is", "注册成功");
        }
        else
        {
            model.addAttribute("is", "注册失败");
        }
        return "register";
    }
}
