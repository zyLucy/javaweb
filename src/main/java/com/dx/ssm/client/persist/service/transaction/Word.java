package com.dx.ssm.client.persist.service.transaction;

public class Word {
    private String name;
    private int value;

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

    public Word(String name, int value) {
        this.name = name;
        this.value = value;
    }
}
