package com.scheduler.data;

/**
 *
 * @author Nikesh
 */
public interface DeleteResourcesRepository {
    
    int deleteTeacher(String teacherId);
    
    int deleteModule(String moduleCode);
    
    int deleteClassroom(String roomCode);
}
