package com.scheduler.controller;

import com.scheduler.data.AddResourcesRepositoryImpl;
import com.scheduler.model.Teacher;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
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
@RequestMapping("/resources")
public class AddResourcesController {

    @Autowired
    private AddResourcesRepositoryImpl repository;

    @RequestMapping(value = "/teachers", method = GET)
    public String showTeacherForm(Model model) {
        try {
            List<Teacher> listOfTeacher = repository.getListOfAllTeachers();
            model.addAttribute(listOfTeacher);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("message", "Something went wrong while fetching list of teachers.");
        }
        return "teachers";
    }

    @RequestMapping(value = "/teachers/add", method = POST)
    public String processTeacherAddForm(@ModelAttribute("teacher") Teacher teacher, RedirectAttributes model) {
        try {
            int affectedRows = repository.addTeacher(teacher);
            model.addFlashAttribute("message", "Teacher added successfully.");
        } catch (EmptyResultDataAccessException ex) {
            model.addFlashAttribute("errorMessage", "Could not add teacher due to internal problem");
            System.err.println("Exception adding teacher: " + ex.getMessage());
        }
        return "redirect:/resources/teachers";
    }

}
