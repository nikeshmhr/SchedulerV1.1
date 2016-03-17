package com.scheduler.data;

import com.scheduler.model.Teacher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Nikesh
 */
@Repository
public class AddResourcesRepositoryImpl implements AddResourcesRepository {

    @Autowired
    private JdbcOperations jdbc;

    /**
     *
     * @return @throws EmptyResultDataAccessException
     */
    @Override
    public List<Teacher> getListOfAllTeachers() throws EmptyResultDataAccessException {
        List<Teacher> teachers;

        teachers = jdbc.query(
                "SELECT * FROM teachers ORDER BY teacherName",
                new RowMapper<Teacher>() {

                    @Override
                    public Teacher mapRow(ResultSet rs, int i) throws SQLException {
                        return new Teacher(rs.getString("teacherId"), rs.getString("teacherName"));
                    }
                }
        );

        return teachers;
    }

    /**
     *
     * @param teacher
     * @return
     * @throws EmptyResultDataAccessException
     */
    @Override
    public int addTeacher(Teacher teacher) throws EmptyResultDataAccessException {
        int affectedRows;

        int count = 1;
        String id;
        do {
            id = "TH" + count;
            count++;
        } while (!isIdAvailable(id));
        
        teacher.setTeacherId(id);
        
        affectedRows = jdbc.update(
                "INSERT INTO teachers VALUES(?, ?)",
                teacher.getTeacherId(),
                teacher.getTeacherName()
        );

        return affectedRows;
    }

    /**
     *  Checks where the provided id for a teacher already exists in database or not.
     * @param id The id of the teacher to check against in a database.
     * @return True if id is not already in database otherwise false.
     */
    private boolean isIdAvailable(String id) {
        boolean status;

        try {
            Teacher t;
            t = jdbc.queryForObject(
                    "SELECT * FROM teachers WHERE teacherId=?",
                    new RowMapper<Teacher>() {

                        @Override
                        public Teacher mapRow(ResultSet rs, int i) throws SQLException {
                            return new Teacher(rs.getString("teacherId"), rs.getString("teacherName"));
                        }
                    },
                    id
            );
            status = false;
        } catch (EmptyResultDataAccessException ex) {
            status = true;
        }

        return status;
    }

}
