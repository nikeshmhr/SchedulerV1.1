package com.scheduler.model;

/**
 *
 * @author Nikesh
 */
public class Group {

    private String groupCode;
    private int noOfStudents;

    public Group() {

    }

    public Group(String groupCode, int noOfStudents) {
        this.groupCode = groupCode;
        this.noOfStudents = noOfStudents;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }

    public int getNoOfStudents() {
        return noOfStudents;
    }

    public void setNoOfStudents(int noOfStudents) {
        this.noOfStudents = noOfStudents;
    }

    @Override
    public boolean equals(Object obj) {
        if(!(obj instanceof Group)){
            return false;
        }
        
        Group g = (Group) obj;
        
        return this.groupCode.equals(g.getGroupCode());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 59 * hash + (this.groupCode != null ? this.groupCode.hashCode() : 0);
        return hash;
    }

}
