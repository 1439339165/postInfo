<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/1/19
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>

    <script type="text/javascript">
        layui.use(['layer','table','form','upload'],function () {
            var layer=layui.layer;
            var table=layui.table;
            var form=layui.form;
            var upload = layui.upload;
            //1.显示表格内容
            var tabins=table.render({
                elem:'#usersTable',//usersTable对应的元素转换layui的table对象
               // height:300,
                url:'/user/name',//这个表格由user/list来提供数据  ajax请求
                page:true,//启用分页功能
                limit:5,
                //limits:[3,6,9,12],
                cols:[[
                    {checkbox:true}
                    ,{field: 'id', title: '编号', sort: true}
                    ,{field: 'title', title: '标题'}
                    ,{field: 'posttime', title: '发帖时间',  sort: true, templet:"<div>{{layui.util.toDateString(d.posttime, 'yyyy-MM-dd')}}</div>"}
                    ,{field: 'clicknum', title: '点击数',sort: true}
                    ,{field: 'content', title: '帖子内容',  sort: true, totalRow: true}
                    ,{field: 'topicid', title: ' 帖子编号'}
                    ,{field: 'pic', title:"图片"}
                    ,{title:"操作",toolbar:'#toolbar1',width:150}
                ]]

            });
            //2.增加用户btn  click事件
            $("#addUserBtn").click(function () {
                //3.清空表单内容
                $("#updateUserForm")[0].reset();
                //1.打开一个对框
                layer.open({
                    type:1,
                    title:'增加用户',
                    area:['475px','500px'],
                    content:$("#updateUserDiv")
                });
            });

            //4.表格的工具栏事件  修改删除
            //监听表单提交事件
            table.on('tool(userTableFilter)',function (data) {
                //删除
                if(data.event=='del'){
                    console.log(data.event);
                    //1.取用户id，将用户用户发给服务器，后台来删除
                    var id=data.data.id;
                    //user/delete/59
                    $.get("/user/delete/"+id,{},function (resp) {
                        //2.如果删除成功，删除表格这一行[将这个表格reload()]
                        //data.tr.remove();
                        //刷新表格
                        tabins.reload();
                        layer.msg(resp.msg);
                    });
                }else{//修改

                    //1.使用用户编号到后台查询了这个用户信息
                    var id=data.data.id;
                    //传 49   找到编号为49这个User  再User转换成json对象返回
                    $.get("/user/find/"+id,{},function (resp) {
                        //2.将要修改的数据回显在窗口中   data.data.id  data.data.name data.data.pwd  age  addr
                        form.val("updateUserFormFilter", {
                            "id": resp.id,
                            "title": resp.title,
                            "posttime": date(resp.posttime),
                            "clicknum": resp.clicknum,
                            "content": resp.content,
                            "topicid": resp.topicid,
                            "pic":resp.pic
                        });
                    });
                    //3.打开一个窗口
                    layer.open({
                        type:1,
                        title:'修改用户',
                        area:['475px','500px'],
                        content:$("#updateUserDiv")
                    });

                }
            });
            function date(d){
                return layui.util.toDateString(d,'yyyy-MM-dd');
            }



            //  6.监听修改的提交按钮
            form.on('submit(updateUserFilter)',function (data) {

                //提交表单中的数据
                $.ajax({
                    type:"get",
                    url:"/user/update",
                    data:$("#updateUserForm").serialize(),
                    success:function (res) {
                        //4.显示修改成功信息
                        layer.msg(res.msg)
                        console.log(res.msg)
                        //刷新表格
                        tabins.reload();
                        //2.关闭对话框架
                        layer.closeAll();
                        //3.清空表单内容
                        $("#updateUserForm")[0].reset();
                        //4.显示修改成功信息
                        layer.msg(res.msg)
                        console.log(res.msg)
                    }
                });
            })

            //5.多行删除
            $("#delUserBtn").click(function () {
                var uid=[];//定义一个数组，用于存储要删除的用户编号
                //1.取出要删除的行上的用户编号
                var checkStatus = table.checkStatus('usersTable'); //idTest 即为基础参数 id 对应的值
                //console.log(checkStatus.data)
                $.each(checkStatus.data,function (index,item) {
                    uid.push(item.id);
                });
                if(uid.length>0){
                    $.get("/user/dels?uid="+uid,{},function (resp) {
                        //2.将多个用户编号使用ajax发后台，后台来删除
                        tabins.reload();
                        layer.msg(resp.msg);
                        //3.将这个表格reload()
                    });
                }else{
                    layer.msg("请先选择要删除的行!")
                }

            });

            //7.响应查询按键
            form.on('submit(queryUserFilter)',function (data) {
               // console.log(data.field.name+data.field.addr);
                //url  "user/list"
                //调用多表查询
                tabins.reload({
                    where :{
                        //name请求参数名称  请求参数的值
                        title:data.field.title,
                        content:data.field.content,
                    },
                    method:'post',
                    page:{
                        curr:1
                    }
                });
                return false;
            });


            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1'
                ,url: '/update' //改成您自己的上传接口
                ,before: function(obj){
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result){
                        $('#demo1').attr('src', result); //图片链接（base64）
                    });
                }
                ,done: function(res){
                 //获取文件id
                    form.val("updateUserFormFilter", {
                        "pic":res.path,
                        // "pic":resp.pic
                    });
                    //   $("#pic").attr("value",res.path)
                    layer.msg("文件上传成功");
                    //上传成功
                }
                ,error: function(){

                }
            });

        });
    </script>
    <style>
     *{
         text-align: center;
     }


    </style>
</head>
<body>
<form class="layui-form" id="queryUserForm" style="text-align: center">
    <div class="layui-form-item" style="margin-top: 30px">
        <div class="layui-inline">
            <input type="text" name="title" placeholder="查询标题!" class="layui-input">
        </div>
        <div   class="layui-inline">
          <input type="text" name="content" placeholder="查询内容!" class="layui-input">
        </div>
        <div class="layui-inline" >
            <div class="layui-input-block" style="margin-left: 0px">
                <button class="layui-btn" lay-submit lay-filter="queryUserFilter">立即查询</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
        </div>

</form>

<div class="layui-container">

        <!--查询条件表单begin -->


    <div class="layui-row display-flex justify-content-end">
        <button class="layui-btn layui-btn-radius  layui-btn-warm" id="addUserBtn">增加用户</button>
        <button class="layui-btn layui-btn-radius  layui-btn-warm" id="delUserBtn">删除用户</button>
    </div>

    <div >
        <input type="file" name="file" class="layui-upload-file">
    </div>
        <table id="usersTable" lay-filter="userTableFilter">
        </table>




</div>


<!-- table中的工具条  修改与删除  begin-->
<script type="text/html" id="toolbar1">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<!--修改用户表单  开始 -->
<div class="layui-container" style="display: none;width: 500px" id="updateUserDiv" >
    <h2 style="text-align: center" class="layui-btn" >添加修改数据</h2>
    <form class="layui-form" id="updateUserForm" lay-filter="updateUserFormFilter" > <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
<%--        影藏标签id--%>
        <input type="hidden" name="id" >

        <div class="layui-form-item">
            <label class="layui-form-label">标题:</label>
            <input type="text" name="title" placeholder="请输入标题内容!" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发帖时间:</label>
            <input type="date" name="posttime"  class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">点赞数:</label>
            <input type="number" name="clicknum"  class="layui-input">
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">文本内容:</label>
            <div class="layui-input-block">
                <textarea name="content" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">选择框</label>
            <div class="layui-input-block">
                <select name="topicid" lay-verify="required">
                    <option value=""></option>
                    <option value="10">学习</option>
                    <option value="20">游戏</option>
                </select>
            </div>
        </div>

        <div class="layui-upload">
            <button type="button" class="layui-btn" id="test1">上传图片</button>
            <div class="layui-upload-list">
                <img class="layui-upload-img" id="demo1">
                <p id="demoText"></p>
            </div>
        </div>


            <input type="hidden" name="pic"  id="#pic">




        <div class="layui-form-item">
                <button class="layui-btn" lay-submit lay-filter="updateUserFilter">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<!--修改用户表单结束 -->
</body>
</html>
