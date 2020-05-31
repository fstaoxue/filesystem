<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>上传控件</title>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/echarts-all.js"></script>
    <script type="text/javascript">
        $(function(){
            init_event();
            $.ajax({
                url:"${request.contextPath}/getTime",
                type:'post',
                data:{},
                success:function(data){
                    console.log(data);
                },
                error:function(){

                }
            })
        })
        function init_event(){
            $("#uploadbtn").click(function(){
                var form=document.getElementById("uploadForm");
                var formData=new FormData(form);
                var url="${request.contextPath}/uploadForLocal";
                $.ajax({
                    url:url,
                    type:'post',
                    data:formData,
                    processData:false,
                    contentType:false,
                    success:function(data){
                        console.log(data);
                        if(data&&data.status=="success"){
                            console.log("上传成功！");
                            var html="<a href="+data.url+">"+data.filename+"(点击下载)</a>";
                            $("body").append(html);
                        }
                        $("#uploadModal").modal("hide");
                    },
                    error:function(){
                        console.log("上传失败！");
                    }
                })
            })
        }
    </script>
</head>
<body>
<h2>上传模块</h2>
<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal"
        data-target="#uploadModal">
    上传${request.contextPath}
</button>

<!-- 模态框（Modal） -->
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
     aria-labelledby="uploadModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="uploadModalLabel">
                    上传
                </h4>
            </div>
            <div class="modal-body">
                <h4>仅支持zip,doc,txt,xls</h4>
                <form enctype="multipart/form-data" id="uploadForm">
                    <input type="file" accept=".doc,.zip,.xls,.ppt,.docx,.xlsx,.pptx" class="form-control" name="uploadFile">
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">取消
                </button>
                <button type="button" class="btn btn-primary" id="uploadbtn">
                    确定
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</body>
</html>
