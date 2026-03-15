package com.cms.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class BaseEntity {
    private Long id;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer deleted;
    private String createBy;
    private String updateBy;
}
