package com.kgc.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class Postinfo {
    private Integer id;

    private String title;
    @DateTimeFormat(pattern="yyyy-MM-dd")//页面写入数据库时格式化
    private Date posttime;

    private Integer clicknum;

    private String content;

    private Integer topicid;

    private String pic;

    public Postinfo(Integer id, String title, Date posttime, Integer clicknum, String content, Integer topicid, String pic) {
        this.id = id;
        this.title = title;
        this.posttime = posttime;
        this.clicknum = clicknum;
        this.content = content;
        this.topicid = topicid;
        this.pic = pic;
    }

    public Postinfo(List<Postinfo> postinfos) {
        super();
    }

    public Postinfo() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Date getPosttime() {
        return posttime;
    }

    public void setPosttime(Date posttime) {
        this.posttime = posttime;
    }

    public Integer getClicknum() {
        return clicknum;
    }

    public void setClicknum(Integer clicknum) {
        this.clicknum = clicknum;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Integer getTopicid() {
        return topicid;
    }

    @Override
    public String toString() {
        return "Postinfo{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", posttime=" + posttime +
                ", clicknum=" + clicknum +
                ", content='" + content + '\'' +
                ", topicid=" + topicid +
                ", pic='" + pic + '\'' +
                '}';
    }

    public void setTopicid(Integer topicid) {
        this.topicid = topicid;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }
}