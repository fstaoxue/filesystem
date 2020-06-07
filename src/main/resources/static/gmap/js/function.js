/**
 * Created by taoxuefeng on 2018/12/18.
 */
function addMarker(config){
    if(!(config.lat&&config.lng)){
        return;
    }
    var latLng=new google.maps.LatLng(config.lat,config.lng);
    var icon="images/phone.png";
    var marker=new google.maps.Marker({
        position:latLng,
        icon:icon,
        draggable:false,
        map:map
    });
    var content=buildMarkerContent(config);
    var info=new google.maps.InfoWindow({
        position:latLng,
        content:content
    })
    google.maps.event.addListener(marker,"click",function(){
        info.open(map,marker);
    });
    overlayMarkers.push(marker);
    return marker;
}

function buildMarkerContent(config){
    var html="";
    html+="<ul>"
        +"<li>经纬度:"+config.lat+","+config.lng+"</li>"
        +"</ul>";
    return html;
}

function mapPan(lat,lng){
    var latLng=new google.maps.LatLng(lat,lng);
    map.panTo(latLng)
}
