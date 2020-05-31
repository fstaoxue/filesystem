var map;

function LocalMapType() {}

LocalMapType.prototype.tileSize = new google.maps.Size(256, 256);
LocalMapType.prototype.maxZoom = GMapConfig.maxZoom;   //地图显示最大级别
LocalMapType.prototype.minZoom = GMapConfig.minZoom;    //地图显示最小级别
LocalMapType.prototype.name = "本地地图";
LocalMapType.prototype.alt = "显示本地地图数据";
LocalMapType.prototype.getTile = function(coord, zoom, ownerDocument) {
    var img = ownerDocument.createElement("img");
    img.style.width = this.tileSize.width + "px";
    img.style.height = this.tileSize.height + "px";
    var strURL = GMapConfig.mapHost+"&x=" + coord.x+ "&y=" + coord.y+ "&z="+zoom;
    img.src = strURL;
    return img;
};

function pad(num,n){
    n = n || 6;
    var len = num.toString().length;
    while (len < n) {
        num = "0" + num;
        len++;
    }
    return num;
}

var localMapType = new LocalMapType();

function initialize() {
    var center = new google.maps.LatLng(GMapConfig.lat, GMapConfig.lng);
    var mapOptions = {
        zoom: GMapConfig.zoom,
        center: center,
        mapTypeControlOptions: {
            mapTypeIds: [
                google.maps.MapTypeId.ROADMAP,
                google.maps.MapTypeId.HYBRID,
                google.maps.MapTypeId.SATELLITE,
                google.maps.MapTypeId.TERRAIN,
                'localMap' ]  //定义地图类型
        },
        panControl: false,
        zoomControl: false,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: false
    }


    map = new google.maps.Map(document.getElementById(GMapConfig.mapDomId), mapOptions);
    map.mapTypes.set('localMap', localMapType);   //绑定本地地图类型
    map.setMapTypeId('localMap');    //指定显示本地地图
    map.setOptions({draggable: true});

}