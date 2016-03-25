package com.scheduler.model;

/**
 *
 * @author Nikesh
 */
public class Classroom {

    private String roomCode;
    private String roomName;
    private int roomType;
    private int capacity;

    public Classroom() {

    }

    public Classroom(String roomId, String roomName, int roomType, int capacity) {
        this.roomCode = roomId;
        this.roomName = roomName;
        this.roomType = roomType;
        this.capacity = capacity;
    }

    public String getRoomCode() {
        return roomCode;
    }

    public void setRoomCode(String roomCode) {
        this.roomCode = roomCode;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getRoomType() {
        return roomType;
    }

    public void setRoomType(int roomType) {
        this.roomType = roomType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    @Override
    public boolean equals(Object obj) {
        if(!(obj instanceof Classroom)){
            return false;
        }
        Classroom room = (Classroom) obj;
        return this.roomCode.equals(room.roomCode);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 23 * hash + (this.roomCode != null ? this.roomCode.hashCode() : 0);
        return hash;
    }

}
