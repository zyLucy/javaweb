package com.dx.ssm.client.persist.service.transaction;

public class SexInfo {
    private String name;
    private int value;

    public SexInfo(int value,String name) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
