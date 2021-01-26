package test;


import com.github.pagehelper.PageInfo;
import com.kgc.entity.Postinfo;
import com.kgc.service.PostinfoService;
import com.kgc.service.TopicService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class tests {





    //定义applicationContext对象
    private ApplicationContext applicationContext;

    //定义员工业务层对象
    private PostinfoService empService;
    private TopicService bookTypeService;

    //测试之前读取spring-config.xml配置文件
    @Before
    public void before(){
        applicationContext = new ClassPathXmlApplicationContext("spring/applicationContext*.xml");

        //获取员工业务层对象
        empService = applicationContext.getBean(PostinfoService.class);
        bookTypeService = applicationContext.getBean(TopicService.class);
    }

    @Test
    public void tesr(){
        try {
            PageInfo<Postinfo> posti = empService.selfindAll(1, 5, new Postinfo());

            for (Postinfo postinfo : posti.getList()) {
                System.out.println(postinfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
