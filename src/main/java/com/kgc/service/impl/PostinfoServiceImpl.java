package com.kgc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.dao.PostinfoMapper;
import com.kgc.entity.Postinfo;
import com.kgc.entity.PostinfoExample;
import com.kgc.service.PostinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class PostinfoServiceImpl implements PostinfoService {
    @Autowired
    PostinfoMapper postinfoMapper;

    public int deleteByPrimaryKey(Integer id) {
        return postinfoMapper.deleteByPrimaryKey(id);
    }

    public int insertSelective(Postinfo record) {
        return postinfoMapper.insertSelective(record);
    }

    public Postinfo selectByPrimaryKey(Integer id) {
        return postinfoMapper.selectByPrimaryKey(id);
    }

    public PageInfo<Postinfo> selfindAll(Integer page, Integer pageSize, Postinfo record) {
        PageHelper.startPage(page,pageSize);
        PostinfoExample postinfoExample = new PostinfoExample();
        if (record!=null){
            PostinfoExample.Criteria criteria = postinfoExample.createCriteria();
            if (!StringUtils.isEmpty(record.getTitle())){
                criteria.andTitleLike("%"+record.getTitle()+"%");
            }
            if (!StringUtils.isEmpty(record.getContent())){
                criteria.andTitleLike("%"+record.getContent()+"%");
            }
        }

        return new PageInfo<Postinfo>(postinfoMapper.selectByExample(postinfoExample));
    }

    public int updateByPrimaryKeySelective(Postinfo record) {
        return postinfoMapper.updateByPrimaryKeySelective(record);
    }
}
