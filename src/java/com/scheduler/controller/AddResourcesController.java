package com.scheduler.controller;

import com.scheduler.data.AddResourcesRepository;
import com.scheduler.model.ClassType;
import com.scheduler.model.Classroom;
import com.scheduler.model.Module;
import com.scheduler.model.Teacher;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Nikesh
 */
@Controller
@RequestMapping("/resources")
public class AddResourcesController {

    @Autowired
    private AddResourcesRepository repository;

    @RequestMapping(value = "/teachers", method = GET)
    public String showTeachers(Model model) {
        try {
            List<Teacher> listOfTeacher = repository.getListOfAllTeachers();
            model.addAttribute(listOfTeacher);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of teachers.");
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
            System.out.println("Exception adding teacher: " + ex.getMessage());
        }
        return "redirect:/resources/teachers";
    }

    @RequestMapping(value = "/modules", method = GET)
    public String showModules(Model model) {
        try {
            List<Module> listOfModules = repository.getListOfAllModules();
            model.addAttribute(listOfModules);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of modules.");
        }
        return "modules";
    }

    @RequestMapping(value = "/modules/add", method = POST)
    public String processModuleAddForm(@ModelAttribute("module") Module module,
            @RequestParam("typesOfClasses.typeId") int[] typeIds, HttpServletRequest request, RedirectAttributes model) {
        List<ClassType> typeOfClasses = new ArrayList<ClassType>();
        for (int i = 0; i < typeIds.length; i++) {
            int typeId = typeIds[i];
            ClassType type = new ClassType(typeId, Double.parseDouble(request.getParameter("hours" + typeId)));

            typeOfClasses.add(type);
        }
        module.setTypeOfClasses(typeOfClasses);

        try {
            int rowsAffected = repository.addModule(module);
            model.addFlashAttribute("message", "Module added successfully.");
        } catch (DataAccessException ex) {
            model.addFlashAttribute("errorMessage", "Could not add module due to internal problem");
            System.out.println("Exception adding module: " + ex.getMessage());
        }

        return "redirect:/resources/modules";
    }

    @RequestMapping(value = "/classrooms", method = GET)
    public String showClassrooms(Model model) {
        try {
            List<Classroom> listOfClassrooms = repository.getListOfAllClassrooms();
            model.addAttribute(listOfClassrooms);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of classrooms.");
        }
        return "classrooms";
    }

    @RequestMapping(value = "/classrooms/add", method = POST)
    public String processClassroomAddForm(@ModelAttribute("classroom") Classroom classroom, RedirectAttributes redirAttr) {
        try {
            int affectedRows = repository.addClassroom(classroom);
            redirAttr.addFlashAttribute("message", "Classroom added successfully.");
        } catch (EmptyResultDataAccessException ex) {
            redirAttr.addFlashAttribute("errorMessage", "Could not add classroom due to internal problem");
            System.out.println("Exception adding classroom: " + ex.getMessage());
        }
        return "redirect:/resources/classrooms";
    }

}
