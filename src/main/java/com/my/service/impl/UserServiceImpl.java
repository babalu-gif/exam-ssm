package com.my.service.impl;

import com.my.dao.UserDao;
import com.my.entity.User;
import com.my.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public boolean set(User user) {
        boolean flag = true;
        User u = userDao.findUserByName(user.getUser_Name());
        if (u != null){
            if (u.getUser_Name().equals(user.getUser_Name())){ // 如果修改的名字没有改变，可以修改
                flag = true;
            } else {
                flag = false;
            }
        }
       int count = userDao.set(user);
        if(count != 1) {
            flag = false;
        }
        return flag;
    }

    @Override
    public User getById(Integer user_id) {
        User user = userDao.getById(user_id);
        return user;
    }

    @Override
    public boolean save(User user) {
        User u = userDao.findUserByName(user.getUser_Name());
        if (u != null){
            return false;
        }
        // 如果没有选择头像，则使用默认的头像
        if ("未选择文件...".equals(user.getAvatar())){
            user.setAvatar("logo.jpg");
        }
        int count = userDao.save(user);
        if(count != 1) {
            return false;
        }
        return true;
    }

    @Override
    public Integer delete(String[] ids) {
        return userDao.delete(ids);
    }

    @Override
    public boolean deleteById(Integer user_id) {
        boolean flag = true;
        int count = userDao.deleteById(user_id);
        if(count != 1) {
            flag = false;
        }
        return flag;
    }

    @Override
    public List<User> find(User user) {
        List<User> userList = userDao.find(user);
        return userList;
    }

    @Override
    public List<User> getAll() {
        List<User> userList = userDao.getAll();
        return userList;
    }

    @Override
    public User login(String myname, String mypwd) {
        User user = userDao.login(myname, mypwd);
        return user;
    }

    @Override
    public boolean register(String myname, String mypwd) {
        User user  = userDao.findUserByName(myname);
        if (user != null){
            return false;
        }
        int count = userDao.register(myname, mypwd);
        if(count != 1) {
            return false;
        }
        return true;
    }

    @Override
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

    @Override
    public List<User> findUsersByIds(String[] ids) {
        return userDao.findUsersByIds(ids);
    }

    @Override
    public int saveUsers(List<User> userList) {
        return userDao.saveUsers(userList);
    }

    @Override
    public boolean setPwd(User user) {
        boolean flag = false;
        int count = userDao.setPwd(user);
        if (count > 0){
            flag = true;
        }
        return flag;
    }

    @Override
    public boolean setAvatar(User user) {
        boolean flag = false;
        int count = userDao.setAvatar(user);
        if (count > 0){
            flag = true;
        }
        return flag;
    }
}
