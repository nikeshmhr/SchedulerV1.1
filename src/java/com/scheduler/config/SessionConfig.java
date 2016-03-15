package com.scheduler.config;

import java.io.Serializable;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

/**
 * The session for the scheduler. (NOTE: Needs aopalliance.jar)
 * @author Nikesh
 */
@Component
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS, value = "session")
public class SessionConfig implements Serializable {

    private int userId;

    public SessionConfig() {

    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}
