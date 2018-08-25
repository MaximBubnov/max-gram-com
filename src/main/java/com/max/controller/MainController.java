package com.max.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @GetMapping("/")
    public String greeting(@RequestParam(value = "name", required = false, defaultValue = "Maxim") String name, Model model) {
        model.addAttribute("name", name);
        return "greeting";
    }

}
