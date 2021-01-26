package com.kgc.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.entity.Postinfo;
import com.kgc.entity.PostinfoExample;
import com.kgc.entity.Topic;
import org.springframework.util.StringUtils;

import java.util.List;

public interface TopicService {



    List<Topic> findAll();


}
