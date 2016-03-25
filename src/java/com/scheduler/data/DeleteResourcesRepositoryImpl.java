package com.scheduler.data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Nikesh
 */
@Repository
public class DeleteResourcesRepositoryImpl implements DeleteResourcesRepository {

    @Autowired
    private JdbcOperations jdbc;

    /**
     *
     * @param teacherId
     * @return
     */
    @Override
    public int deleteTeacher(String teacherId) {
        int affectedRows = jdbc.update(
                "DELETE FROM teachers WHERE teacherId=?",
                teacherId
        );

        return affectedRows;
    }

    @Override
    public int deleteModule(String moduleCode) {
        int affectedRows = jdbc.update(
                "DELETE FROM modules WHERE moduleCode=?",
                moduleCode
        );
        
        return affectedRows;
    }

    @Override
    public int deleteClassroom(String roomCode) {
        int affectedRows = jdbc.update(
                "DELETE FROM classrooms WHERE roomCode=?",
                roomCode
        );
        
        return affectedRows;
    }

    @Override
    public int deleteGroup(String groupCode) {
        int affectedRows = jdbc.update(
                "DELETE FROM groups WHERE groupCode=?",
                groupCode
        );
        
        return affectedRows;
    }

}
