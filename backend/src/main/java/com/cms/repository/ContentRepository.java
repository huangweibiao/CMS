package com.cms.repository;

import com.cms.entity.Content;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ContentRepository {
    Content findById(@Param("id") Long id);
    List<Content> findAll();
    List<Content> findByStatus(@Param("status") String status);
    List<Content> findByAuthorId(@Param("authorId") Long authorId);
    int insert(Content content);
    int update(Content content);
    int deleteById(@Param("id") Long id);
}
