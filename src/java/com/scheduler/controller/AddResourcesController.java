package com.scheduler.controller;

import com.scheduler.data.AddResourcesRepository;
import com.scheduler.model.ClassType;
import com.scheduler.model.Classroom;
import com.scheduler.model.Group;
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
        setTeachersIntoModel(model);
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
        setModulesIntoModel(model);
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
        setClassroomsIntoModel(model);
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

    @RequestMapping(value = "/groups", method = GET)
    public String showGroups(Model model) {
        setGroupsIntoModel(model);
        return "groups";
    }

    @RequestMapping(value = "/groups/add", method = POST)
    public String processGroupAddForm(@ModelAttribute("group") Group group, RedirectAttributes redirAttr) {
        try {
            int affectedRows = repository.addGroup(group);
            redirAttr.addFlashAttribute("message", "Group added successfully.");
        } catch (EmptyResultDataAccessException ex) {
            redirAttr.addFlashAttribute("errorMessage", "Could not add group due to internal problem.");
            System.out.println("Exception adding group: " + ex.getMessage());
        }
        return "redirect:/resources/groups";
    }

    @RequestMapping(value = "/teachers/edit", method = GET)
    public String showTeachersEditPage(Model model) {
        setTeachersIntoModel(model);
        return "editTeachers";
    }

    @RequestMapping(value = "/teachers/edit", method = POST)
    public String processTeacherEditForm(@ModelAttribute("teacher") Teacher teacher, RedirectAttributes redirectAttr) {
        try {
            int affectedRows = repository.updateTeacher(teacher);
            if (affectedRows > 0) {
                redirectAttr.addFlashAttribute("message", "Teacher updated successfully.");
            } else {
                redirectAttr.addFlashAttribute("errorMessage", "Could not update fields.");
            }
        } catch (DataAccessException ex) {
            redirectAttr.addFlashAttribute("errorMessage", "Could not update teacher because of internal problem");
            System.out.println("Exception updating classroom: " + ex.getMessage());
        }
        return "redirect:/resources/teachers/edit";
    }

    @RequestMapping(value = "/modules/edit", method = GET)
    public String showModulesEditPage(Model model) {
        setModulesIntoModel(model);
        return "editModules";
    }

    @RequestMapping(value = "/modules/edit", method = POST)
    public String processModuleEditForm(@ModelAttribute("module") Module module, HttpServletRequest request, RedirectAttributes redirectAttr) {
        setClassTypes(module, request);
        
        try{
            int affectedRows = repository.updateModule(module);
            if(affectedRows > 0){
                redirectAttr.addFlashAttribute("message", "Module updated successfully.");
            }else{
                redirectAttr.addFlashAttribute("errorMessage", "Could not update fields.");
            }
        }catch(DataAccessException ex){
            redirectAttr.addFlashAttribute("errorMessage", "Could not update module because of internal problem");
            System.out.println("Exception updating module: " + ex.getMessage());
        }

        return "redirect:/resources/modules/edit";
    }

    @RequestMapping(value = "/classrooms/edit", method = GET)
    public String showClassroomsEditPage(Model model) {
        setClassroomsIntoModel(model);
        return "editClassrooms";
    }

    @RequestMapping(value = "/classrooms/edit", method = POST)
    public String processClassroomEditForm(@ModelAttribute("classroom") Classroom classroom, RedirectAttributes redirectAttr) {
        try {
            int affectedRows = repository.updateClassroom(classroom);
            if (affectedRows > 0) {
                redirectAttr.addFlashAttribute("message", "Classroom updated successfully.");
            } else {
                redirectAttr.addFlashAttribute("errorMessage", "Could not update fields.");
            }
        } catch (DataAccessException ex) {
            redirectAttr.addFlashAttribute("errorMessage", "Could not update classroom because of internal problem");
            System.out.println("Exception updating classroom: " + ex.getMessage());
        }
        return "redirect:/resources/classrooms/edit";
    }

    @RequestMapping(value = "/groups/edit", method = GET)
    public String showGroupsEditPage(Model model) {
        setGroupsIntoModel(model);
        return "editGroups";
    }

    @RequestMapping(value = "/groups/edit", method = POST)
    public String processGroupsEditForm(@ModelAttribute("group") Group group, RedirectAttributes redirectAttr) {
        try {
            int affectedRows = repository.updateGroup(group);
            if (affectedRows > 0) {
                redirectAttr.addFlashAttribute("message", "Group updated successfully.");
            } else {
                redirectAttr.addFlashAttribute("errorMessage", "Could not update fields.");
            }
        } catch (DataAccessException ex) {
            redirectAttr.addFlashAttribute("errorMessage", "Could not update group because of internal problem");
            System.out.println("Exception updating group: " + ex.getMessage());
        }
        return "redirect:/resources/groups/edit";
    }

    private void setTeachersIntoModel(Model model) {
        try {
            List<Teacher> listOfTeacher = repository.getListOfAllTeachers();
            model.addAttribute(listOfTeacher);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of teachers.");
        }
    }

    private void setModulesIntoModel(Model model) {
        try {
            List<Module> listOfModules = repository.getListOfAllModules();
            model.addAttribute(listOfModules);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of modules.");
        }
    }

    private void setClassroomsIntoModel(Model model) {
        try {
            List<Classroom> listOfClassrooms = repository.getListOfAllClassrooms();
            model.addAttribute(listOfClassrooms);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of classrooms.");
        }
    }

    private void setGroupsIntoModel(Model model) {
        try {
            List<Group> listOfGroups = repository.getListOfAllGroups();
            model.addAttribute(listOfGroups);
        } catch (EmptyResultDataAccessException ex) {
            model.addAttribute("errorMessage", "Something went wrong while fetching list of groups.");
        }
    }

    private void setClassTypes(Module module, HttpServletRequest request) {
        double lectureHour = (request.getParameter("LectureHours") == null) ? 0 : Double.parseDouble(request.getParameter("LectureHours"));
        double tutorialHour = (request.getParameter("TutorialHours") == null) ? 0 : Double.parseDouble(request.getParameter("TutorialHours"));
        double labHour = (request.getParameter("LabHours") == null) ? 0 : Double.parseDouble(request.getParameter("LabHours"));
        double workshopHour = (request.getParameter("WorkshopHours") == null) ? 0 : Double.parseDouble(request.getParameter("WorkshopHours"));

        System.out.println(lectureHour + ", " + tutorialHour + ", " + labHour + ", " + workshopHour);
        
        if(lectureHour > 0){
            module.getTypeOfClasses().add(new ClassType(1, lectureHour));
        }
        
        if(tutorialHour > 0){
            module.getTypeOfClasses().add(new ClassType(2, tutorialHour));
        }
        
        if(labHour > 0){
            module.getTypeOfClasses().add(new ClassType(3, labHour));
        }
        
        if(workshopHour > 0){
            module.getTypeOfClasses().add(new ClassType(4, workshopHour));
        }
    }
}
