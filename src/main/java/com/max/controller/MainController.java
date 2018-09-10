package com.max.controller;

import com.max.domain.User;
import com.max.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String greeting() {
        return "greeting/greeting";
    }

    @GetMapping("/main")
    public String main(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getFirstname());
        model.addAttribute("user",  user);
        model.addAttribute("usr", user.getUsername());

        return "main/main";
    }




}
