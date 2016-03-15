package com.scheduler.data;

import com.scheduler.model.Login;

/**
 *
 * @author Nikesh
 */
public interface LoginRepository {
    
    /**
     * The helps to validate the login credentials of the supplied login object.
     * @param login The login info. of the user.
     * @return The id of the user if valid otherwise 0.
     */
    int validate(Login login);
    
}
