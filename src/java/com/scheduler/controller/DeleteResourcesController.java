package com.scheduler.controller;

import com.scheduler.data.DeleteResourcesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Nikesh
 */
@Controller
@RequestMapping(value = "/resources")
public class DeleteResourcesController {

    @Autowired
    private DeleteResourcesRepository deleteResources;

    @RequestMapping(value = "/teachers/delete/{teacherId}", method = GET)
    public String deleteTeacher(@PathVariable String teacherId, RedirectAttributes redirectAttr) {
        int affectedRows = deleteResources.deleteTeacher(teacherId);
        if (affectedRows > 0) {
            redirectAttr.addFlashAttribute("message", "Teacher's record deleted successfully.");
        } else {
            redirectAttr.addFlashAttribute("errorMessage", "Failed to delete teacher with id " + teacherId);
        }
        return "redirect:/resources/teachers";
    }

    @RequestMapping(value = "/modules/delete/{moduleCode}", method = GET)
    public String deleteModule(@PathVariable String moduleCode, RedirectAttributes redirectAttr) {
        int affectedRows = deleteResources.deleteModule(moduleCode);
        if (affectedRows > 0) {
            redirectAttr.addFlashAttribute("message", "Module's record deleted successfully.");
        } else {
            redirectAttr.addFlashAttribute("errorMessage", "Failed to delete module with module code " + moduleCode);
        }

        return "redirect:/resources/modules";
    }

    @RequestMapping(value = "/classrooms/delete/{roomCode}", method = GET)
    public String deleteClassroom(@PathVariable String roomCode, RedirectAttributes redirectAttr) {
        int affectedRows = deleteResources.deleteClassroom(roomCode);
        if (affectedRows > 0) {
            redirectAttr.addFlashAttribute("message", "Classroom's record deleted successfully.");
        } else {
            redirectAttr.addFlashAttribute("errorMessage", "Failed to delete classroom with room code " + roomCode);
        }

        return "redirect:/resources/classrooms";
    }

    @RequestMapping(value = "/groups/delete/{groupCode}", method = GET)
    public String deleteGroup(@PathVariable String groupCode, RedirectAttributes redirectAttr) {
        int affectedRows = deleteResources.deleteGroup(groupCode);
        if (affectedRows > 0) {
            redirectAttr.addFlashAttribute("message", "Group's record deleted successfully.");
        } else {
            redirectAttr.addFlashAttribute("errorMessage", "Failed to delete group with group code " + groupCode);
        }
        
        return "redirect:/resources/groups";
    }

}
