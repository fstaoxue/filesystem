<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>文件管理</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">文件管理</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">文件总览</a></li>
            <li class="layui-nav-item"><a href="">文件上传</a></li>
            <li class="layui-nav-item"><a href="">文件解析</a></li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    admin
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">文件操作</a>
                    <dl class="layui-nav-child">
                        <dd><a class="filesystem_module" name="upload" href="javascript:;">上传</a></dd>
                        <dd><a class="filesystem_module" name="show" href="javascript:;">下载</a></dd>
                        <dd><a class="filesystem_module" name="welcome" href="javascript:;">说明</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">地图操作</a>
                    <dl class="layui-nav-child">
                        <dd><a class="filesystem_module" name="showPoint" href="javascript:;">打点工具</a></dd>
                        <dd><a class="filesystem_module" name="convert" href="javascript:;">经纬度转换</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">文件总览</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">图表</a></dd>
                        <dd><a href="javascript:;">表格</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
            <iframe id="gotoIframe" scrolling="auto" src="${request.contextPath}/welcome" width="100%" height="100%"></iframe>
    </div>

    <div class="layui-footer">
    </div>
</div>
<script src="layui/layui.js"></script>
<script src="js/jquery-1.9.1.js" type="text/javascript"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    $(function(){
        init_event();
    })

    function init_event(){
        $(".filesystem_module").click(function(){
            var name=$(this).attr("name");
            $("#gotoIframe").attr("src","${request.contextPath}/"+name);
            if(name=="welcome"){
                $("#gotoIframe").attr("scrolling","auto");
            }else{
                $("#gotoIframe").attr("scrolling","no");
            }
        })
    }
</script>
</body>
</html>
