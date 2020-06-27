<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=yes" />
    <title>地图页面</title>
    <meta charset="UTF-8">
    <base href="${request.contextPath}/gmap/">
    <script type="text/javascript" src="${request.contextPath}/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/api.js"></script>
    <script type="text/javascript" src="js/config.js"></script>
    <script type="text/javascript" src="js/GMap.js"></script>
    <script type="text/javascript" src="js/function.js"></script>
    <script type="text/javascript">
        $(function(){
            initialize();
            console.log(map);
        })

        function showPoints(points){
            if(points.length<=0){
                return;
            }
            for(var i in points){
                addMarker(points[i],parseInt(i)+1);
            }
            var len=points.length-1;
            var lat=points[len].lat;
            var lng=points[len].lng;
            mapPan(lat,lng);
        }

        function clearPoints(){
            for(var i in overlayMarkers){
                overlayMarkers[i].setMap(null);
            }
            overlayMarkers.splice(0,overlayMarkers.length);
        }

    </script>
</head>

<body>
<div id="gmap" style="left:0;top:0;width:100%;height:100%;position:absolute;">

</div>
</body>

</html>