package com.kgc.controller;




import com.github.pagehelper.PageInfo;
import com.kgc.entity.Postinfo;
import com.kgc.entity.Topic;
import com.kgc.service.PostinfoService;
import com.kgc.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.util.*;

@Controller
public class Coooooo {

    @Autowired
    PostinfoService postinfoService;
    @Autowired
    TopicService topicService;

    @Autowired
    private ServletContext servletContext;
    // TODO: 2021/1/12   修改数据
    @RequestMapping("/update" )
    @ResponseBody
    public Map uploadFile(MultipartFile file ) throws Exception{
        String path=servletContext.getRealPath("upload");//oos
        File dir=new File(path);
        if(!dir.exists())dir.mkdir();
        String fileName=getFileName(file.getOriginalFilename());
        String str=path+"/"+fileName;//上传文件的原始名称
        file.transferTo(new File(str));
        System.out.println(fileName);
        Map map=new HashMap();
        map.put("msg","文件上传成功!");
        map.put("path",fileName);
       return map;
    }
    // TODO: 2021/1/12随机生一个新的文件名+老的文件名的缀
    private String getFileName(String fileName){
        String extName=fileName.substring(fileName.lastIndexOf("."));
        return UUID.randomUUID()+""+new Random().nextInt(1000)+extName;
    }
    // TODO: 2021/1/12 查询所有数据
    @RequestMapping("/user/name")
    @ResponseBody
    public Map usewr(
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
            @RequestParam(value = "pageSize", required = false, defaultValue = "5") Integer pageSize,
            Postinfo info
           ){
            System.out.println(info);
        PageInfo<Postinfo> pageInfo = postinfoService.selfindAll(page, pageSize, info);
        for (Postinfo postinfo : pageInfo.getList()) {
            System.out.println(postinfo);
        }
            Map map=new HashMap();
            map.put("code",0);
            map.put("msg","查询成功!");
            map.put("count",pageInfo.getTotal());//总记录数
            map.put("data",pageInfo.getList());
        return map;
    }

    // TODO: 2021/1/20 跳跳虎
    @RequestMapping("user/{page}")
    public String toList(@PathVariable("page")String page){
        return page;
    }


    // TODO: 2021/1/12 删除数据
    //value = "user",method = RequestMethod.POST
    @RequestMapping("/user/delete/{id}")
    @ResponseBody
    public Map user(@PathVariable("id")Integer id) {
       Map map=new HashMap();
        System.out.println(id);
            Integer integer = postinfoService.deleteByPrimaryKey(id);
        map.put("msg","删除成功!");
        return map;
    }

    // TODO: 2021/1/12 批量删除
    @RequestMapping("/user/dels")
    @ResponseBody
    public Map methodos(Integer[] uid) {
        Integer mun=0;
        for (Integer integer : uid) {
            System.out.println(integer);
           mun+=postinfoService.deleteByPrimaryKey(integer);
        }
       Map map=new HashMap();
            map.put("msg","删除成功!");//{"msg":"删除成功!"}
            return map;
    }


    // TODO: 2021/1/12 获取修改信息
    @RequestMapping("/user/find/{id}")
    @ResponseBody
    public  Postinfo toUpdEmp(@PathVariable("id")Integer id) {

        Postinfo info = postinfoService.selectByPrimaryKey(id);
        System.out.println(info);

            System.out.println(info);
            List<Topic> types = topicService.findAll();


        return info;
    }


    // TODO: 2021/1/12   添加修改数据
    @RequestMapping("/user/update" )
    @ResponseBody
    public Map toUpdEmp(Postinfo info) throws Exception {
        Map map=new HashMap();
        if (info.getId()!=null){
            System.out.println("修改数据");
            System.out.println(info);
            Integer integer = postinfoService.updateByPrimaryKeySelective(info);
            map.put("msg","修改用户成功");
            //map.put("data",info);//id
            return map;
        }
        System.out.println("添加数据");
        Integer integer = postinfoService.insertSelective(info);
        map.put("msg","增加用户成功");
        return map;
    }







}




