package com.my.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.my.entity.User;
import com.my.service.UserService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
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

    // 删除多个用户
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public void deleteById(String ids)
    {
        // 将字符串以','分割保存到数组中
        String[] d = ids.split(",");
        userService.delete(d);
        return;
    }

    // 删除单个用户
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
    public PageInfo<User> find(Integer page, Integer pageSize, User user)
    {
        PageHelper.startPage(page, pageSize);
        List<User> userList = userService.find(user);
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        return pageInfo;
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
            return "login";
        }

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

    @RequestMapping("/exportAllUsers.do")
    public void exportCheckedUsers(HttpServletResponse response) throws IOException {
        // 调用service层方法，查询勾选的市场活动
        List<User> userList = userService.findAllUsers();
        // 创建excel文件，并且把activityList写入到excel文件中
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("用户信息列表");
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("ID");
        cell = row.createCell(1);
        cell.setCellValue("用户名");
        cell = row.createCell(2);
        cell.setCellValue("密码");
        cell = row.createCell(3);
        cell.setCellValue("性别");
        cell = row.createCell(4);
        cell.setCellValue("邮箱");

        if (userList != null && userList.size() > 0){
            User user = null;
            // 遍历activityList，创建HSSFRow对象，生成所有数据行
            for (int i = 0; i < userList.size(); i++){
                user = userList.get(i);
                // 每遍历一个activity，生成一行
                row = sheet.createRow(i+1);
                cell = row.createCell(0);
                cell.setCellValue(user.getUser_id());
                cell = row.createCell(1);
                cell.setCellValue(user.getUser_Name());
                cell = row.createCell(2);
                cell.setCellValue(user.getUser_Password());
                cell = row.createCell(3);
                cell.setCellValue(user.getUser_Sex());
                cell = row.createCell(4);
                cell.setCellValue(user.getUser_Email());
            }
        }

        // 把生成的excel文件下载到客户端
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=userList.xls");
        OutputStream out = response.getOutputStream();

        wb.write(out);

        wb.close();
        out.flush();
    }

    @RequestMapping("/exportCheckedUsers.do")
    public void exportCheckedUsers(HttpServletResponse response, String[] id) throws IOException {
        // 调用service层方法，查询勾选的市场活动
        List<User> userList = userService.findUsersByIds(id);
        // 创建excel文件，并且把activityList写入到excel文件中
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("用户信息列表");
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("ID");
        cell = row.createCell(1);
        cell.setCellValue("用户名");
        cell = row.createCell(2);
        cell.setCellValue("密码");
        cell = row.createCell(3);
        cell.setCellValue("性别");
        cell = row.createCell(4);
        cell.setCellValue("邮箱");

        if (userList != null && userList.size() > 0){
            User user = null;
            // 遍历activityList，创建HSSFRow对象，生成所有数据行
            for (int i = 0; i < userList.size(); i++){
                user = userList.get(i);
                // 每遍历一个activity，生成一行
                row = sheet.createRow(i+1);
                cell = row.createCell(0);
                cell.setCellValue(user.getUser_id());
                cell = row.createCell(1);
                cell.setCellValue(user.getUser_Name());
                cell = row.createCell(2);
                cell.setCellValue(user.getUser_Password());
                cell = row.createCell(3);
                cell.setCellValue(user.getUser_Sex());
                cell = row.createCell(4);
                cell.setCellValue(user.getUser_Email());
            }
        }

        // 把生成的excel文件下载到客户端
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=userList.xls");
        OutputStream out = response.getOutputStream();

        wb.write(out);

        wb.close();
        out.flush();
    }
}
