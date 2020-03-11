package com.dx.ssm.client.persist.service;

import com.dx.ssm.client.model.domain.UserDO;
import com.dx.ssm.client.persist.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author  daxia
 */
@Service
public class UserService {
    @Resource
    private UserMapper userMapper;

    public List<UserDO> listUsers(){
        return userMapper.listUsers();
    }

    public List<UserDO> listUserByUserName(String userName){
        return  userMapper.listUserByUserName(userName);
    }

    public  UserDO getUserByIrd(int id){
        return userMapper.getUserById(id);
    }

    public int saveUser(UserDO user){
        return userMapper.saveUser(user);
    }

    public  int removeUserById(int id){
        return userMapper.removeUserById(id);
    }

    public  int updateUser(UserDO user){
        return userMapper.updateUser(user);
    }
}

