package com.cms.controller;

import com.cms.dto.ApiResponse;
import com.cms.entity.User;
import com.cms.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/info")
    public ApiResponse<User> getUserInfo(@AuthenticationPrincipal OAuth2User oauth2User) {
        String username = oauth2User.getAttribute("preferred_username");
        User user = userService.findByUsername(username);
        return ApiResponse.success(user);
    }
}
