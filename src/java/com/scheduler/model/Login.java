package com.scheduler.model;

/**
 * Holds the credentials of user and validates it.
 *
 * @author Nikesh
 */
public class Login {

    private String username, password;
    private int id;

    public Login() {
        this(null, null);
    }

    public Login(String username, String password) {
        this(0, username, password);
    }

    public Login(int id, String username, String password) {
        this.username = username;
        this.password = password;
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

}
