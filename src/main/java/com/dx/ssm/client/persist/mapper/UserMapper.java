package com.dx.ssm.client.persist.mapper;

import com.dx.ssm.client.model.domain.UserDO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author daxia
 */
@Repository
public interface UserMapper {

    /**
     * 列出所有用户
     * @return
     */
    List<UserDO> listUsers();

    /**
     * 按照用户名查找
     * @param userName 用户名
     * @return
     */
    List<UserDO> listUserByUserName(String userName);

    /**
     * 按照id查找用户
     * @param id 用户id
     * @return
     */
    UserDO getUserById(int id);

    /**
     * 插入用户
     * @param user 待保存的用户
     * @return
     */
    int saveUser(@Param("user")UserDO user);

    /**
     * 通过id删除用户
     * @param id
     * @return
     */
    int removeUserById(int id);

    /**
     * 更新用户
     * @param user
     * @return
     */
    int updateUser(@Param("user")UserDO user);


}

