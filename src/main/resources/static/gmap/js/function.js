/**
 * Created by taoxuefeng on 2018/12/18.
 */
function addMarker(config,index){
    if(!(config.lat&&config.lng)){
        return;
    }
    var latLng=new google.maps.LatLng(config.lat,config.lng);
    var marker=new showNumberMarker(latLng,map,index);
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



function showNumberMarker(latlng, map, key) {
    this.setMap(map);
    this.latlng_ = latlng;
    this.key_ = key;
}

showNumberMarker.prototype = new google.maps.OverlayView();

showNumberMarker.prototype.onAdd = function() {

    var div = document.createElement("div");
    div.style.borderStyle = "none";
    div.style.borderWidth = "1px";
    div.style.position = "absolute";
    div.style.borderColor="black";
    div.style.width="24px";
    div.style.height="30px";
    div.style.background="url('images/phone.png')no-repeat";
    div.style.color="white";
    div.style.cursor = "pointer";
    div.innerHTML = "<span style='color:white;margin-left:10px;margin-top:5px;font-size: 16px;'>" + this.key_ + "</span>";

    this.div_ = div;
    var panes = this.getPanes();

    panes.overlayMouseTarget.appendChild(div);
};

showNumberMarker.prototype.draw = function() {

    var projection = this.getProjection();

    var point = projection.fromLatLngToDivPixel(this.latlng_);

    this.div_.style.left = (point.x - 15) + "px";
    this.div_.style.top = (point.y - 20) + "px";
};

showNumberMarker.prototype.onRemove = function() {

    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
};

