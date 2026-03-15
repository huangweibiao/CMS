package com.cms.config;

import com.cms.entity.User;
import com.cms.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String oauth2Id = oAuth2User.getAttribute("sub");
        String username = oAuth2User.getAttribute("preferred_username");
        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");

        User user = userRepository.findByOauth2Id(oauth2Id);
        if (user == null) {
            user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setNickname(name);
            user.setOauth2Id(oauth2Id);
            user.setOauth2Provider("oauth2");
            userRepository.insert(user);
            log.info("New user created: {}", username);
        } else {
            log.info("Existing user logged in: {}", username);
        }

        return oAuth2User;
    }
}
