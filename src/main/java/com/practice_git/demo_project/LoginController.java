package com.practice_git.demo_project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {
    @GetMapping("/login")
    @ResponseBody
    public String getLoginPage() {
        return "Login Page";
    }
}
