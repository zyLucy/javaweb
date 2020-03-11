package com.dx.ssm.client.model;

import java.io.Serializable;

public class TranDO implements Serializable {
String uid;
String uname;
String fromwho;
String content;
long time;
String article;
String flag;
int level;
int follows;
String timestr;
UserInfo user;

	public UserInfo getUserInfo() {
		return user;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.user = userInfo;
	}

	public String getTimestr() {
		return timestr;
	}

	public void setTimestr(String timestr) {
		this.timestr = timestr;
	}

	public int getFollows() {
		return follows;
	}

	public void setFollows(int follows) {
		this.follows = follows;
	}

	public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}

public long getTime() {
	return time;
}

public void setTime(long time) {
	this.time = time;
}

public String getUid() {
	return uid;
}
public void setUid(String uid) {
	this.uid = uid;
}
public String getUname() {
	return uname;
}
public void setUname(String uname) {
	this.uname = uname;
}
public String getFromwho() {
	return fromwho;
}
public void setFromwho(String fromwho) {
	this.fromwho = fromwho;
}

public String getArticle() {
	return article;
}
public void setArticle(String article) {
	this.article = article;
}
public String getFlag() {
	return flag;
}
public void setFlag(String flag) {
	this.flag = flag;
}
	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Override
	public String toString() {
		return "TranDO{" +
				"uid='" + uid + '\'' +
				", uname='" + uname + '\'' +
				", fromwho='" + fromwho + '\'' +
				", content='" + content + '\'' +
				", time=" + time +
				", article='" + article + '\'' +
				", flag='" + flag + '\'' +
				", level=" + level +
				'}';
	}
}
