package com.max.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String greeting() {
        return "greeting/greeting";
    }

    @GetMapping("/main")
    public String main() {
        return "main/main";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/reg")
    public String reg() {
        return "registration/registration";
    }

}
