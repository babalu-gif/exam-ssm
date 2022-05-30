package com.my.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.my.entity.ReturnObject;
import com.my.entity.User;
import com.my.service.UserService;
import com.my.utils.FileNameUtil;
import com.my.utils.HSSFUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    @Autowired
    private UserService userService;

    private String saveFileName = "";

    /**
     * 文件上传的类型
     */
    public static final List<String> AVATAR_TYPES = new ArrayList<>();
    static {
        AVATAR_TYPES.add("image/png");
        AVATAR_TYPES.add("image/jpg");
        AVATAR_TYPES.add("image/bmp");
        AVATAR_TYPES.add("image/jpeg");
    }

    // 修改用户信息
    @ResponseBody
    @RequestMapping(value = "/set.do")
    public Object set(User user) {
        ReturnObject returnObject = new ReturnObject();
        boolean flag = userService.set(user);
        if (flag == true){
            returnObject.setCode("200");
        } else {
            returnObject.setMessage("用户修改失败，用户名已存在!");
            returnObject.setCode("301");
        }
        return returnObject;
    }

    // 根据id值查找用户
    @ResponseBody
    @RequestMapping(value = "/getById.do")
    public User getById(Integer user_id) {
        User user = userService.getById(user_id);
        return user;
    }

    // 新增用户
    @ResponseBody
    @RequestMapping(value = "/save.do")
    public Object save(User user) {
        ReturnObject returnObject = new ReturnObject();
        boolean flag = userService.save(user);
        if (flag == true){
            returnObject.setCode("200");
        } else {
            returnObject.setMessage("用户添加失败，用户名已存在!");
            returnObject.setCode("301");
        }
        return returnObject;
    }

    // 删除多个用户
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public void deleteById(String ids) {
        // 将字符串以','分割保存到数组中
        String[] d = ids.split(",");
        userService.delete(d);
        return;
    }

    // 删除单个用户
    @ResponseBody
    @RequestMapping(value = "/deleteById.do")
    public void deleteById(Integer user_id) {
        boolean flag = userService.deleteById(user_id);
        return;
    }

    // 根据条件查找用户
    @ResponseBody
    @RequestMapping(value = "/find.do")
    public PageInfo<User> find(Integer page, Integer pageSize, User user) {
        PageHelper.startPage(page, pageSize);
        List<User> userList = userService.find(user);
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        return pageInfo;
    }

    // 获取所有用户信息
    @RequestMapping(value = "/getAll.do")
    public String getAll(HttpServletRequest request) {
        List<User> userList = userService.getAll();
        request.setAttribute("userList", userList);
        return "users";
    }

    // 登录验证
    @ResponseBody
    @RequestMapping(value = "/login.do")
    public Object login(HttpServletResponse response, HttpSession session,
                        String userName, String password, String isRemPwd) {
        User user = userService.login(userName, password);
        // 添加线程休眠，根据客户需求可以优化
        /*try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }*/

        ReturnObject returnObject = new ReturnObject();
        if(user != null) {
            session.setAttribute("user", user);
            returnObject.setCode("200");
        }
        else {
            returnObject.setCode("302");
            returnObject.setMessage("用户名或密码错误");
        }

        // 判断是否需要自动登录
        if ("true".equals(isRemPwd)){
            Cookie cookie = new Cookie("userName", userName);
            cookie.setMaxAge(10*24*60*60);
            response.addCookie(cookie);
            Cookie cookie1 = new Cookie("password", password);
            cookie1.setMaxAge(10*24*60*60);
            response.addCookie(cookie1);
        } else {
            // 把没有过期的cookie删除
            Cookie cookie = new Cookie("userName", "0");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            Cookie cookie1 = new Cookie("password", "0");
            cookie1.setMaxAge(0);
            response.addCookie(cookie1);
        }
        return returnObject;
    }

    @RequestMapping(value = "/toMain.do")
    public String toMain(){
        return "main";
    }

    @RequestMapping(value = "/logout.do")
    public String logout(HttpServletResponse response, HttpSession session){
        // 清除cookie
        Cookie cookie = new Cookie("userName", "0");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        Cookie cookie1 = new Cookie("password", "0");
        cookie1.setMaxAge(0);
        response.addCookie(cookie1);

        // 销毁session,释放内存
        session.invalidate();
        // 重定向到首页，不把数据传过去
        return "redirect:/";
    }

    @RequestMapping(value = "/toLogin.do")
    public String toLogin(){
        // 重定向到首页，不把数据传过去
        return "redirect:/";
    }

    // 用户注册
    @ResponseBody
    @RequestMapping(value = "/register.do")
    public Object register(String userName, String password) {
        boolean flag = userService.register(userName, password);
        ReturnObject returnObject = new ReturnObject();
        if(flag) {
            returnObject.setCode("200");
            returnObject.setMessage("注册成功");
        }
        else {
            returnObject.setCode("302");
            returnObject.setMessage("注册失败,用户名已存在");
        }
        return returnObject;
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

    @RequestMapping("/importUser.do")
    @ResponseBody
    public Object importUser(MultipartFile userFile){
        ReturnObject returnObject = new ReturnObject();

        try {
            InputStream is = userFile.getInputStream();
            HSSFWorkbook wb = new HSSFWorkbook(is);
            HSSFSheet sheet = wb.getSheetAt(0); // 页的下标，下标从0开始，依次递增
            // 根据sheet获取HSSFRow对象，封装了一行所有的信息
            HSSFRow row = null;
            HSSFCell cell = null;
            User user = null;
            List<User> userList = new ArrayList<>();
            for (int i = 1; i <= sheet.getLastRowNum(); i++){
                row = sheet.getRow(i);  // 行的下标，下标从0开始，依次增加
                user = new User();
                for (int j = 0; j < row.getLastCellNum(); j++){
                    cell = row.getCell(j); // 列的下标，下标从0开始，依次增加
                    // 获取列中的数据
                    String cellValue = HSSFUtils.getCellValueForStr(cell);
                    if (j == 1){
                        user.setUser_Name(cellValue);
                    } else if (j == 2){
                        user.setUser_Password(cellValue);
                    } else if (j == 3){
                        user.setUser_Sex(cellValue);
                    } else if (j == 4){
                        user.setUser_Email(cellValue);
                    }
                }
                // 每一行中所有列封装完之后，把activity保存到list中
                userList.add(user);
            }

            // 调用service层方法，保存市场活动
            int result = userService.saveUsers(userList);
            returnObject.setCode("1");
            returnObject.setMessage("成功导入"+result+"条数据");
        } catch (Exception e){
            returnObject.setCode("0");
            returnObject.setMessage("系统忙，请稍后重试...");
        }
        return returnObject;
    }

    // 异步ajax文件上传处理
    @ResponseBody
    @RequestMapping(value = "/ajaxImg.do")
    public Object ajaxImg(HttpServletRequest request, MultipartFile userImage) {
        saveFileName = FileNameUtil.getUUIDFileName()+FileNameUtil.getFileType(userImage.getOriginalFilename());

        if (!AVATAR_TYPES.contains(userImage.getContentType())){
            JSONObject object = new JSONObject();
            object.put("code", "303");
            object.put("message", "Allowed file types:" + AVATAR_TYPES);
            return object.toString();
        }

        // 得到项目中图片存储的路径
        String path = request.getServletContext().getRealPath("/image_user");
        // 转存
        try {
            userImage.transferTo(new File(path + File.separator + saveFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 返回给客户端JSON对象，封装图片的路径，为了在页面实现立即回显
        JSONObject object = new JSONObject();
        object.put("retData", saveFileName);
        object.put("code", "200");

        return object.toString();
    }

    // 修改用户密码
    @ResponseBody
    @RequestMapping(value = "/updatePwd.do")
    public Object updatePwd(User user, HttpSession session, HttpServletResponse response){
        boolean flag = userService.setPwd(user);
        ReturnObject returnObject = new ReturnObject();
        if (flag == true){
            Cookie cookie = new Cookie("password", "0");
            cookie.setMaxAge(0);
            response.addCookie(cookie);

            // 销毁session,释放内存
            session.invalidate();

            returnObject.setCode("200");
        } else {
            returnObject.setCode("304");
            returnObject.setMessage("系统忙，请稍后重试...");
        }
        return returnObject;
    }

    // 修改用户头像
    @ResponseBody
    @RequestMapping(value = "/setAvatar.do")
    public Object setAvatar(User user, HttpSession session) {
        ReturnObject returnObject = new ReturnObject();
        boolean flag = userService.setAvatar(user);
        if (flag == true){
            User u = (User) session.getAttribute("user");
            u.setAvatar(user.getAvatar());
            System.out.println("=========");
            System.out.println("=========");
            System.out.println(user.getAvatar());
            session.setAttribute("user", u);
            returnObject.setCode("200");
            returnObject.setMessage("头像修改成功");
        } else {
            returnObject.setCode("305");
            returnObject.setMessage("系统忙，请稍后再试...");
        }
        return returnObject;
    }
}
