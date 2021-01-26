<%--
  Created by IntelliJ IDEA.
  User: hong
  Date: 2021/1/25
  Time: 8:28
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

        layui.use(['form', 'layer', 'upload'], function () {
            $ = layui.jquery;
            var form = layui.form，
layer = layui.layer,
    upload = layui.upload;

            /*上传图片*/
            upload.render({
                elem: '#preview_img'
                , url: 'upload'
                , size: 1024
                , auto: false //不自动上传
                , bindAction: '#upload_img' //上传绑定到隐藏按钮
                , choose: function (obj) {
//预读本地文件
                    obj.preview(function (index, file, result) {
                        $('#fileName').val(file.name); //展示文件名
                    })
                }
                , done: function (res) {
                    $('#credential_hide').val(res.msg); //隐藏输入框赋值
                    $('#submitForm').click(); //上传成功后单击隐藏的提交按钮
                }
                , error: function (index, upload) {
                    layer.msg('上传失败！' + index, {icon: 5});
                }
            });

//确定按钮点击事件
            $('#fake').click(function () {
                $(this).attr({'disabled': 'disabled'});
                $('#upload_img').click();//单击隐藏的上传按钮
            });

            /*监听提交*/
            form.on('submit(add_recharge_submit)', function (data) {
                addRecharge(data.field);
                return false;
            });
        });

    </script>
</head>
<body>
<input id="fileName" type="text" lay-verify="fileName"
       autocomplete="off" class="layui-input" disabled>
<#--隐藏输入框 用来存放上传后图片路径-->
<input id="credential_hide" name="credentialOne" type="hidden" lay-verify="credentialOne"
       autocomplete="off" class="layui-input">
<#--隐藏按钮 上传-->
<button id="upload_img" type="button" hidden></button>
<button class="layui-btn" id="preview_img" type="button">
    上传图片
</button>
<button class="layui-btn layui-btn-normal btn-submit" id="fake">
    确定
</button>
<#---->

</body>
</html>
