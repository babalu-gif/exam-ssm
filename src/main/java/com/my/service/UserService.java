package com.my.service;

import com.my.entity.User;

import java.util.List;

public interface UserService {
    User login(String myname, String mypwd);

    boolean register(String myname, String mypwd);

    List<User> getAll();

    boolean deleteById(Integer user_id);

    boolean save(User user);

    List<User> find(User user);

    User getById(Integer user_id);

    boolean set(User user);

    Integer delete(String[] ids);

    List<User> findAllUsers();

    List<User> findUsersByIds(String[] ids);

    int saveUsers(List<User> userList);
}
