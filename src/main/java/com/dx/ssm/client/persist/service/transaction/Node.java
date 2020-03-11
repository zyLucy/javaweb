package com.dx.ssm.client.persist.service.transaction;

public class Node {
    int category;
    String name;
    int  id;
    int symbolSize;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getCategory() {
        return category;
    }
    public void setCategory(int category) {
        this.category = category;
    }
    public int getSymbolSize() {
        return symbolSize;
    }
    public void setSymbolSize(int symbolSize) {
        this.symbolSize = symbolSize;
    }
}
