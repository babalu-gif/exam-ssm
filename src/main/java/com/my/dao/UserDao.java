package com.my.dao;

import com.my.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    User login(@Param("myname") String myname, @Param("mypwd") String mypwd);

    int register(@Param("myname") String myname, @Param("mypwd") String mypwd);

    List<User> getAll();

    List<User> find(User user);

    User findUserByName(String name);

    int deleteById(Integer user_id);

    int save(User user);

    User getById(Integer user_id);

    int set(User user);

    Integer delete(String[] ids);

    List<User> findAllUsers();

    List<User> findUsersByIds(String[] ids);

    int saveUsers(List<User> userList);

    int setPwd(User user);

    int setAvatar(User user);
}
