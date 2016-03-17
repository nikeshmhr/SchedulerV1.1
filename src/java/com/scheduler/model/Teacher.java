package com.scheduler.model;

/**
 *
 * @author Nikesh
 */
public class Teacher {

    private String teacherId;
    private String teacherName;

    public Teacher() {
        this(null, null);
    }

    public Teacher(String id, String name) {
        this.teacherId = id;
        this.teacherName = name;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + (this.teacherId != null ? this.teacherId.hashCode() : 0);
        hash = 29 * hash + (this.teacherName != null ? this.teacherName.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Teacher other = (Teacher) obj;
        if ((this.teacherId == null) ? (other.teacherId != null) : !this.teacherId.equals(other.teacherId)) {
            return false;
        }
        if ((this.teacherName == null) ? (other.teacherName != null) : !this.teacherName.equals(other.teacherName)) {
            return false;
        }
        return true;
    }

}
