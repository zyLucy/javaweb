package com.dx.ssm.client.persist.service.transaction;

public class Content {
    private String name;
    private String secondTime;
    private String time;
    private String address;

    public Content(String name, String secondTime, String time, String address) {
        this.name = name;
        this.secondTime = secondTime;
        this.time = time;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSecondTime() {
        return secondTime;
    }

    public void setSecondTime(String secondTime) {
        this.secondTime = secondTime;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
