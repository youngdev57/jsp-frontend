package com.jsptest.controller;

import com.jsptest.service.MyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class JspController {

    private final MyService service;

    public JspController(MyService service) {
        this.service = service;
    }

    @GetMapping({"/" ,"/main"})
    public String Main(Model model) {
        model.addAttribute("page", "pages/dashboard.jsp");
        return "main";
    }

    @GetMapping("/modules/{page}")
    public String Modules(Model model, @PathVariable String page) {
        String converted = service.convertPageName(page);
        model.addAttribute("page", "pages/module/" + converted + ".jsp");
        return "main";
    }

    @GetMapping("/tags/{page}")
    public String Tags(Model model, @PathVariable String page) {
        String converted = service.convertPageName(page);
        model.addAttribute("page", "pages/tag/" + converted + ".jsp");
        return "main";
    }

    @GetMapping("/common/{page}")
    public String Common(Model model, @PathVariable String page) {
        String converted = service.convertPageName(page);
        model.addAttribute("page", "pages/common/" + converted + ".jsp");
        return "main";
    }
}
