package com.scheduler.data;

import com.scheduler.model.Module;
import com.scheduler.model.Teacher;
import com.scheduler.model.Classroom;
import java.util.List;

/**
 *
 * @author Nikesh
 */
public interface AddResourcesRepository {

    List<Teacher> getListOfAllTeachers();

    int addTeacher(Teacher teacher);
    
    List<Module> getListOfAllModules();
    
    int addModule(Module module);
    
    List<Classroom> getListOfAllClassrooms();
    
    int addClassroom(Classroom classroom);
    
}
