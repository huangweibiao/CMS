package com.cms.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class User extends BaseEntity {
    private String username;
    private String email;
    private String nickname;
    private String avatar;
    private String oauth2Id;
    private String oauth2Provider;
}
