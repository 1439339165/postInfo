package com.kgc.dao;

import com.kgc.entity.Postinfo;
import com.kgc.entity.PostinfoExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PostinfoMapper {
    long countByExample(PostinfoExample example);

    int deleteByExample(PostinfoExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Postinfo record);

    int insertSelective(Postinfo record);

    List<Postinfo> selectByExample(PostinfoExample example);

    Postinfo selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Postinfo record, @Param("example") PostinfoExample example);

    int updateByExample(@Param("record") Postinfo record, @Param("example") PostinfoExample example);

    int updateByPrimaryKeySelective(Postinfo record);

    int updateByPrimaryKey(Postinfo record);
}