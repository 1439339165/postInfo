package com.kgc.service;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.Postinfo;

public interface PostinfoService {

    // TODO: 2021/1/24 根据id删除
    int deleteByPrimaryKey(Integer id);


    // TODO: 2021/1/24 根据条件添加数据
    int insertSelective(Postinfo record);

    // TODO: 2021/1/24 根据id查询
    Postinfo selectByPrimaryKey(Integer id);

    // TODO: 2021/1/24 分页模糊查询
    PageInfo<Postinfo> selfindAll(Integer page, Integer pageSize, Postinfo record);
    // TODO: 2021/1/24 根据条件修改
    int updateByPrimaryKeySelective(Postinfo record);


}
