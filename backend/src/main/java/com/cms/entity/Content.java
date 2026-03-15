package com.cms.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class Content extends BaseEntity {
    private String title;
    private String content;
    private String category;
    private String tags;
    private String status;
    private Long authorId;
    private String authorName;
    private Integer viewCount;
    private Integer likeCount;
}
