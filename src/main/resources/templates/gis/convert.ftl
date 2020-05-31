<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>经纬度转换</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="layui/layui.js" ></script>
    <script type="text/javascript" src="gmap/js/GeoUtil.js" ></script>
    <script type="text/javascript">
        function convertLatLng(type){
            if(type==0){
                var str=$("#area84").val();
                var points=parseTextArea(str);
                if(points&&Array.isArray(points)){
                    for(var i in points){
                        var result=GeoUtil.wgs2GCJ(points[i].lat,points[i].lng);
                        points[i].lat=Number(result[0]).toFixed(5);
                        points[i].lng=Number(result[1]).toFixed(5);
                    }
                }
                var str="";
                for(var i in points){
                    var point=points[i];
                    if(point&&point.lat&&point.lng){
                        str+=point.lat;
                        str+=",";
                        str+=point.lng;
                    }
                    if(point.time){
                        str+=",";
                        str+=point.time;
                    }
                    str+="\n";
                }
                $("#area02").val(str);
            }else{
                var str=$("#area02").val();
                var points=parseTextArea(str);
                if(points&&Array.isArray(points)){
                    for(var i in points){
                        var result=GeoUtil.gcj2WGS(points[i].lat,points[i].lng);
                        points[i].lat=Number(result[0]).toFixed(5);
                        points[i].lng=Number(result[1]).toFixed(5);
                    }
                }
                var str="";
                for(var i in points){
                    var point=points[i];
                    if(point&&point.lat&&point.lng){
                        str+=point.lat;
                        str+=",";
                        str+=point.lng;
                    }
                    if(point.time){
                        str+=",";
                        str+=point.time;
                    }
                    str+="\n";
                }
                $("#area84").val(str);
            }
        }

        function parseTextArea(pointsText){
            var points=[];
            var pointsList=pointsText.split("\n");
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
            return points;
        }
    </script>
</head>
<body>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-lg-offset1 layui-col-lg4">
            <div style="margin:20px 0 20px 100px;color:#009688;font-size:20px;">84坐标系</div>
            <textarea id="area84" rows="30" cols="40"></textarea>
        </div>
        <div class="layui-col-lg2" style="color:#009688;margin-top:250px;">
            <div style="margin: 0 0 40px 30px">
                <i title="84转02" style="font-size: 36px;cursor: pointer;" onclick="convertLatLng(0)" class="layui-icon layui-icon-next"></i>
            </div>
            <div style="margin:30px 0 0 30px">
                <i title="02转84" style="font-size: 36px;cursor: pointer;" onclick="convertLatLng(1)" class="layui-icon layui-icon-prev"></i>
            </div>
        </div>
        <div class="layui-col-lg4">
            <div style="margin:20px 0 20px 100px;color:#009688;font-size:20px;">02坐标系</div>
            <textarea id="area02" rows="30" cols="40"></textarea>
        </div>
    </div>
</div>

<script>

    layui.use('layer', function(){
        var layer = layui.layer;
    });
</script>
</body>
</html>