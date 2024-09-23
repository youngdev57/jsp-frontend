package com.jsptest.domain;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class JspController {

    @RequestMapping(method = RequestMethod.GET, value = "/")
    public String mainPage(Model model) {
        model.addAttribute("page", "pages/dashboard.jsp");
        return "main";
    }

    @GetMapping("/main")
    public String Main(Model model) {
        model.addAttribute("page", "pages/dashboard.jsp");
        return "main";
    }

    @GetMapping("/libraries/{page}")
    public String Libraries(Model model, @PathVariable String page) {
        model.addAttribute("page", "pages/library/" + page + ".jsp");
        return "main";
    }

    @GetMapping("/modules/{page}")
    public String Modules(Model model, @PathVariable String page) {
        model.addAttribute("page", "pages/module/" + page + ".jsp");
        return "main";
    }

    @GetMapping("/tags/{page}")
    public String Tags(Model model, @PathVariable String page) {
        model.addAttribute("page", "pages/tag/" + page + ".jsp");
        return "main";
    }

    @GetMapping("/common/{page}")
    public String Common(Model model, @PathVariable String page) {
        model.addAttribute("page", "pages/common/" + page + ".jsp");
        return "main";
    }
}
