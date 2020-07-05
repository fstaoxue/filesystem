<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文件上传</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="layui/layui.js"></script>
</head>
<body>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-lg6">
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">文件名</label>
                    <div class="layui-input-block">
                        <input id="inputFileName" type="text" name="title" required  placeholder="请输入文件名" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">文件</label>
                    <div class="layui-input-inline">
                        <button type="button" class="layui-btn" id="uploadFileBtn"><i class="layui-icon"></i>上传文件</button>
                    </div>
                    <div class="layui-form-mid layui-word-aux" id="uploadFilename"></div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">文件类型</label>
                    <div class="layui-input-block">
                        <select name="city">
                            <option value=""></option>
                            <option value="0">word文档</option>
                            <option value="1">xls表格</option>
                            <option value="2">ppt演示</option>
                            <option value="3">zip压缩包</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">描述</label>
                    <div class="layui-input-block">
                        <textarea name="desc" placeholder="请输入。。。" class="layui-textarea"></textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button id="commit" class="layui-btn" lay-submit lay-filter="formDemo">上传</button>
                        <button type="reset" class="layui-btn layui-btn-primary">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>


<script>
    //Demo
    layui.use('layer', function(){
        var layer = layui.layer;
    });

    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return false;
        });
    });
    layui.use('upload', function() {
        var $ = layui.jquery
                , upload = layui.upload;
        upload.render({ //允许上传的文件后缀
            elem: '#uploadFileBtn'
            ,url: '${request.contextPath}/uploadForLocal'
            ,auto:false
            ,accept: 'file' //普通文件
            ,size:2048000
            ,bindAction: '#commit'
            ,done: function(data){
                if(data&&data.code=="200"){
                    layer.msg("上传成功");
                    $("#uploadFilename").text(data.data.filename);
                    $("#inputFileName").val(data.data.filename);
                }else{
                    layer.msg("上传失败");
                }

            }
        });
    });
</script>

</body>
</html>