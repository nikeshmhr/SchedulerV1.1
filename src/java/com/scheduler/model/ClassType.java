package com.scheduler.model;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

/**
 *
 * @author Nikesh
 */
public class ClassType {

    private int typeId;
    private String typeName;
    private double hours;

    public static final int LECTURE = 1, TUTORIAL = 2, LAB = 3, WORKSHOP = 4;

    public ClassType(int typeId, String typeName, double hours) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.hours = hours;
    }

    public ClassType(int typeId, double hours) {
        this.typeId = typeId;
        this.hours = hours;
        setTypeNameById(typeId);
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public double getHours() {
        return hours;
    }

    public void setHours(double hours) {
        this.hours = hours;
    }

    public void setTypeNameById(int typeId) {
        switch (typeId) {
            case LECTURE:
                typeName = "Lecture";
                break;

            case TUTORIAL:
                typeName = "Tutorial";
                break;

            case LAB:
                typeName = "Lab";
                break;

            case WORKSHOP:
                typeName = "Workshop";
                break;
        }
    }

    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(typeId);
    }

    @Override
    public boolean equals(Object obj) {
        return EqualsBuilder.reflectionEquals(this, obj);
    }

}
