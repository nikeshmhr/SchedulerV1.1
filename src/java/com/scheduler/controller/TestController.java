package com.scheduler.controller;

import com.scheduler.config.SessionConfig;
import com.scheduler.model.Login;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 *
 * @author Nikesh
 */
@Controller
@RequestMapping("/test")
@SessionAttributes("userId")
public class TestController {
    
    @Autowired
    private SessionConfig session;
    
    @RequestMapping(method=GET)
    public String getPage(Model model){
        Login l = (Login) model.asMap().get("login");
        
        System.out.println("User ID: " + l.getUsername());
        return "test";
    }
    
}
