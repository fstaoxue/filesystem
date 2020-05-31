<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>欢迎页</title>
    <link href="layui/css/layui.css" rel="stylesheet"/>
</head>
<body>
<pre class="layui-code">
    //文件上传功能使用案例
    //前端页面
    <div class="modal-body">
        <form enctype="multipart/form-data" id="uploadForm">
            <input type="file" accept=".txt,.doc,.zip,.xls,.xlsx,.docx,.ppt,.pptx" class="form-control" name="uploadFile">
        </form>

    </div>
    //前端js
    function init_event(){
        $("#uploadbtn").click(function(){
            var form=document.getElementById("uploadForm");
            var formData=new FormData(form);
            var url="http://162.168.1.117:8190/filesystem/uploadForRemote";
            $.ajax({
                url:url,
                type:'post',
                data:formData,
                async:false,
                contentType:false,
                processData:false,
                dataType:'json',
                success:function(data){
                    if(data&&data.code=="200"&&data.data){
                        data=data.data;
                        var html="<a href="+data.url+">"+data.filename+"(点击下载)</a>";
                        $("body").append(html);
                    }
                    $("#uploadModal").modal("hide");
                },
                error:function(){
                    console.log("上传失败！");
                    $("#uploadModal").modal("hide");
                }
            })
        })
    }
    //文件限制
    通过获取file的各种属性，自定义限制
    var uploadFile=document.getElementById("uploadFile").files;
    //文件大小
    var size=uploadFile[0].size;
    //修改时间
    var time=uploadFile[0].lastModified;
    //文件名称
    var name=ploadFile[0].name;

</pre>
<script src="layui/layui.js" type="text/javascript"></script>
<script src="js/jquery-1.9.1.js" type="text/javascript"></script>
<script type="text/javascript">
    layui.use('code', function(){ //加载code模块
        layui.code({
            title: '上传功能使用说明',
            //skin: 'notepad', //如果要默认风格，不用设定该key。
            encode:true,
            about:false
        });

    });

</script>
</body>
</html>