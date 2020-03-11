package com.dx.ssm.client.model;

import java.io.Serializable;

public class UserInfo implements Serializable {
    private String uid;
    private String province;
    private String sex;
    private int fans;
    private TranDO tran;

    @Override
    public String toString() {
        return "UserInfo{" +
                "uid='" + uid + '\'' +
                ", province='" + province + '\'' +
                ", sex='" + sex + '\'' +
                ", fans=" + fans +
                '}';
    }

    public TranDO getTran() {
        return tran;
    }

    public void setTran(TranDO tran) {
        this.tran = tran;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getFans() {
        return fans;
    }

    public void setFans(int fans) {
        this.fans = fans;
    }
}
