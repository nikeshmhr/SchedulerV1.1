package com.scheduler.data;

import com.scheduler.model.Login;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class LoginRepositoryImpl implements LoginRepository {

    @Autowired
    private JdbcOperations jdbc;

    @Override
    public int validate(Login login) {
        int id = 0;
        try {
            id = jdbc.queryForObject("SELECT * FROM login_info WHERE username=? AND password=MD5(?)",
                    new RowMapper<Integer>() {

                        @Override
                        public Integer mapRow(ResultSet rs, int i) throws SQLException {
                            System.out.println("I: " + i);
                            return rs.getInt("id");
                        }
                    }, login.getUsername(), login.getPassword());
        } catch (EmptyResultDataAccessException ex) {
            System.err.println("Error (EmptyResultDataAccessException): " + ex.getMessage());
        }
        return id;
    }

}
