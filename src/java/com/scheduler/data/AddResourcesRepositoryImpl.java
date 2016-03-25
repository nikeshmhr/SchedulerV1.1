package com.scheduler.data;

import com.scheduler.model.ClassType;
import com.scheduler.model.Classroom;
import com.scheduler.model.Module;
import com.scheduler.model.Teacher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
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
     * Checks where the provided id for a teacher already exists in database or
     * not.
     *
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

    @Override
    public List<Module> getListOfAllModules() throws EmptyResultDataAccessException {
        List<Module> listOfModules;

        listOfModules = jdbc.query(
                "SELECT * FROM modules ORDER BY year, semester",
                new RowMapper<Module>() {

                    @Override
                    public Module mapRow(ResultSet rs, int i) throws SQLException {
                        return new Module(rs.getString("moduleCode"), rs.getString("moduleName"), new ArrayList<ClassType>(), rs.getInt("year"), rs.getInt("semester"));
                    }
                }
        );

        for (Module module : listOfModules) {
            String moduleCode = module.getModuleCode();
            List<ClassType> classTypes;
            classTypes = jdbc.query(
                    "SELECT * FROM module_classes WHERE moduleCode=?",
                    new RowMapper<ClassType>() {

                        @Override
                        public ClassType mapRow(ResultSet rs, int i) throws SQLException {
                            return new ClassType(rs.getInt("typeId"), rs.getDouble("classHours"));
                        }
                    },
                    moduleCode
            );

            module.setTypeOfClasses(classTypes);
        }

        return listOfModules;
    }

    /**
     *
     * @param module
     * @return
     */
    @Override
    public int addModule(Module module) throws DataAccessException {
        int affectedRows;

        affectedRows = jdbc.update(
                "INSERT INTO modules VALUES(?, ?, ?, ?)",
                module.getModuleCode(),
                module.getModuleName(),
                module.getYear(),
                module.getSem()
        );

        if (affectedRows > 0) {
            List<ClassType> classTypes = module.getTypeOfClasses();
            for (ClassType classType : classTypes) {
                jdbc.update(
                        "INSERT INTO module_classes VALUES(?, ?, ?)",
                        classType.getTypeId(),
                        module.getModuleCode(),
                        classType.getHours()
                );
            }
        }

        return affectedRows;
    }

    /**
     *
     * @return
     */
    @Override
    public List<Classroom> getListOfAllClassrooms() throws EmptyResultDataAccessException {
        List<Classroom> listOfClassrooms;

        listOfClassrooms = jdbc.query(
                "SELECT * FROM classrooms ORDER BY typeId, roomCapacity DESC",
                new RowMapper<Classroom>() {

                    @Override
                    public Classroom mapRow(ResultSet rs, int i) throws SQLException {
                        return new Classroom(rs.getString("roomCode"), rs.getString("roomName"), rs.getInt("typeId"), rs.getInt("roomCapacity"));
                    }
                }
        );

        return listOfClassrooms;
    }

    @Override
    public int addClassroom(Classroom classroom) throws DataAccessException {
        int affectedRows;
        
        affectedRows = jdbc.update(
                "INSERT INTO classrooms VALUES(?, ?, ?, ?)", 
                classroom.getRoomCode(),
                classroom.getRoomName(),
                classroom.getCapacity(),
                classroom.getRoomType()
        );
        
        return affectedRows;
    }

}
