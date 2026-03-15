package com.cms.repository;

import com.cms.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserRepository {
    User findById(@Param("id") Long id);
    User findByUsername(@Param("username") String username);
    User findByEmail(@Param("email") String email);
    User findByOauth2Id(@Param("oauth2Id") String oauth2Id);
    int insert(User user);
    int update(User user);
}
