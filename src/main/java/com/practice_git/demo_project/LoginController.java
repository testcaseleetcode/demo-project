package com.practice_git.demo_project;

import org.springframework.web.bind.annotation.GetMapping;

public class LoginController {
    @GetMapping("/login")
    public String getLoginPage() {
        return "Login Page";
    }
}
