package com.scheduler.model;

import java.util.ArrayList;
import java.util.List;

/**
 * The class represents the module that is taught in the college.
 * @author Nikesh
 */
public class Module {

    private String moduleCode;
    private String moduleName;
    private List<ClassType> typeOfClasses;
    private int year, sem;

    public Module(String moduleCode, String moduleName, List<ClassType> typeOfClasses, int year, int sem) {
        this.moduleCode = moduleCode;
        this.moduleName = moduleName;
        this.typeOfClasses = typeOfClasses;
        this.sem = sem;
        this.year = year;
    }

    public Module() {
        this.typeOfClasses = new ArrayList<ClassType>();
    }

    public String getModuleCode() {
        return moduleCode;
    }

    public void setModuleCode(String moduleCode) {
        this.moduleCode = moduleCode;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public List<ClassType> getTypeOfClasses() {
        return typeOfClasses;
    }

    public void setTypeOfClasses(List<ClassType> typeOfClasses) {
        this.typeOfClasses = typeOfClasses;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getSem() {
        return sem;
    }

    public void setSem(int sem) {
        this.sem = sem;
    }   

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 71 * hash + (this.moduleCode != null ? this.moduleCode.hashCode() : 0);
        return hash;
    }
    
    @Override
    public boolean equals(Object obj){
        if(!(obj instanceof Module)){
            return false;
        }
        
        Module m = (Module) obj;
        
        return this.moduleCode.equals(m.getModuleCode());
    }
}
