<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>打点页面</title>
    <link href="layui/css/layui.css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="layui/layui.js"></script>
    <script type="text/javascript">
        var points=[];
        $(function(){
            $("#showPoints").click(function(){
                var pointsText=$("#pointsArea").val();
                var pointsList=pointsText.split("\n");
                points.splice(0,points.length);
                for(var i in pointsList){
                    var temp=pointsList[i].split(",");
                    var tempPoint={};
                    if(temp[0]){
                        tempPoint.lat=Number((temp[0]+"").trim());
                    }
                    if(temp[1]){
                        tempPoint.lng=Number((temp[1]+"").trim());
                    }
                    if(temp[2]){
                        tempPoint.time=Number((temp[2]+"").trim());
                    }
                    if(tempPoint.lat&&tempPoint.lng){
                        points.push(tempPoint);
                    }
                }
                //绘制points数组中的点
                mapFrame.showPoints(points);
            });
            $("#clearPoints").click(function(){
                $("#pointsArea").val("");
                points.splice(0,points.length);
                //清空地图上的点
                mapFrame.clearPoints();
            });
            $("#pointsArea").val("32.07,118.78\n32.09,118.75");
        })
    </script>
</head>
<body>
<div class="map-wrapper" style="position: absolute;top: 0px;width: 100%;height:100%;padding:25px 30px 25px 30px;overflow: hidden">
    <iframe id="mapFrame" name="mapFrame" scrolling="no" src="${request.contextPath}/gis/map" frameborder="0" border="0" width="100%" height="100%"></iframe>
</div>
<div style="position: fixed;">
    <textarea id="pointsArea" rows="30" cols="30"></textarea>
    <div class="layui-row">
        <button type="button" class="layui-col-lg-offset1 layui-btn layui-btn-normal" id="showPoints">打点</button>
        <button type="button" class="layui-btn layui-btn-normal" id="clearPoints">清除</button>
    </div>

</div>
</body>
</html>