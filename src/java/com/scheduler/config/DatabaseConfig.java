/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scheduler.config;

import javax.sql.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

/**
 *
 * @author Nikesh
 */
@Configuration
public class DatabaseConfig {

    @Bean
    public DataSource getDataSource() {
        DriverManagerDataSource source = new DriverManagerDataSource("jdbc:mysql://localhost:3306/scheduler", "root", "");
        source.setDriverClassName("com.mysql.jdbc.Driver");
        
        return source;
    }
    
    @Bean
    public JdbcOperations getJdbcTemplate(DataSource source){
        return new JdbcTemplate(source);
    }

}
