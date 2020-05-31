<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文件列表</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>

<table class="layui-table layui-table-cell" lay-data="{url:'${request.contextPath}/getAllFiles', page:true,limit:5, id:'test'}" lay-filter="test">
    <thead>
    <tr>
        <th lay-skin="primary" lay-data="{checkbox:true,fixed:'left',width:80}"></th>
        <th lay-data="{field:'username', width:160}">用户名</th>
        <th lay-data="{field:'filename', width:200}">文件名</th>
        <th lay-data="{field:'size', width:160}">大小</th>
        <th lay-data="{field:'time', width:160}">时间</th>
        <th lay-data="{field:'right', width:300,toolbar:'#manageFile'}">文件操作</th>

    </tr>
    </thead>
</table>
<a style="display: none" href="javascript:void(0)" id="canDownload"></a>
<script type="text/html" id="manageFile">
    <a class="layui-btn layui-btn-sm layui-btn-radius" lay-event="download">下载</a>
    <a class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal" lay-event="del">删除</a>
</script>

<script src="layui/layui.js"></script>
<script src="js/jquery-1.9.1.js" type="text/javascript"></script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if(layEvent === 'download'){ //查看
                console.log(data.url);
                $("#canDownload").attr("href",data.url);
                $("#canDownload")[0].click();
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该文件吗', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.ajax({
                        url:"${request.contextPath}/delFileById?fileId="+data.id+"&filename="+data.filename,
                        type:'get',
                        success:function(){
                        }
                    })
                });
            }
        });
    });
    layui.use(['layer', 'form'], function(){
        var layer = layui.layer
                ,form = layui.form;

    });

</script>
</body>
</html>