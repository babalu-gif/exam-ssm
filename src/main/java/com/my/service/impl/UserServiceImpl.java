package com.my.service.impl;

import com.my.dao.UserDao;
import com.my.entity.User;
import com.my.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService
{
    @Autowired
    private UserDao userDao;

    @Override
    public boolean set(User user)
    {
        boolean flag = true;
       int count = userDao.set(user);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public User getById(Integer user_id)
    {
        User user = userDao.getById(user_id);
        return user;
    }

    @Override
    public boolean save(User user)
    {
        boolean flag = true;
        int count = userDao.save(user);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public Integer delete(String[] ids)
    {
        return userDao.delete(ids);
    }

    @Override
    public boolean deleteById(Integer user_id)
    {
        boolean flag = true;
        int count = userDao.deleteById(user_id);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public List<User> find(User user)
    {
        List<User> userList = userDao.find(user);
        return userList;
    }

    @Override
    public List<User> getAll()
    {
        List<User> userList = userDao.getAll();
        return userList;
    }

    @Override
    public User login(User u)
    {
        User user = userDao.login(u);
        return user;
    }

    @Override
    public boolean register(String myname, String mypwd)
    {
        boolean flag = true;
        int count = userDao.register(myname, mypwd);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

    @Override
    public List<User> findUsersByIds(String[] ids) {
        return userDao.findUsersByIds(ids);
    }
}
