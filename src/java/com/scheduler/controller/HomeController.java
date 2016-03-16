package com.scheduler.controller;

import com.scheduler.config.SessionConfig;
import com.scheduler.data.LoginRepository;
import com.scheduler.model.Login;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Nikesh
 */
@Controller
@RequestMapping("/")
public class HomeController {

    @Autowired
    private SessionConfig session;
    @Autowired
    private LoginRepository loginRepo;

    /**
     * Routes to /.
     *
     * @return The login page if its the new session otherwise the homepage.
     */
    @RequestMapping(method = GET)
    public String showHomepage() {
        if (session.getUserId() != 0) {
            return "redirect:/home";
        }
        return "index";
    }

    @RequestMapping(method = POST)
    public String processLogin(@ModelAttribute("login") Login login, Model model, RedirectAttributes redirectAttributes) {
        int id = loginRepo.validate(login);
        session.setUserId(id);

        if (id == 0) {
            model.addAttribute("incorrect", "Incorrect username or password");
            return "index";
        } else {
            redirectAttributes.addFlashAttribute("login", login);
            return "redirect:/home";
        }
    }

    @RequestMapping(method = GET, value = "logout")
    public String logoutUser(HttpSession sessionHTTP) {
        sessionHTTP.invalidate();
        return "redirect:/home";
    }

    @RequestMapping(method = GET, value = "home")
    public String showHomePage() {
        return "home";
    }

}
