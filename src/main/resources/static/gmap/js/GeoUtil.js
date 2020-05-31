/**
 * Created by 1001234 on 2018/12/19.
 * 坐标系转换，获取两点之间距离
 */

var GeoUtil=(function(){
    return {
        //84坐标系转02坐标系
        wgs2GCJ:function(wgLat,  wgLon){
            var latlon = [];
            if (this.outOfChina(wgLat, wgLon)) {
                latlon[0] = wgLat;
                latlon[1] = wgLon;
                return latlon;
            } else {
                var deltaD = this.delta(wgLat, wgLon);
                latlon[0] = wgLat + deltaD[0];
                latlon[1] = wgLon + deltaD[1];
                return latlon;
            }
        },
        //02坐标系转84坐标系
        gcj2WGS:function(glat,  glon){
            var latlon = [];
            if (this.outOfChina(glat, glon)) {
                latlon[0] = glat;
                latlon[1] = glon;
                return latlon;
            } else {
                var deltaD = this.delta(glat, glon);
                latlon[0] = glat - deltaD[0];
                latlon[1] = glon - deltaD[1];
                return latlon;
            }
        },
        //两个经纬度之间的距离
        distance:function(latA,  logA,  latB,  logB){
            var earthR = 6371000;
            var x = Math.cos(latA * 3.141592653589793 / 180.0) * Math.cos(latB * 3.141592653589793 / 180.0) * Math.cos((logA - logB) * 3.141592653589793 / 180.0);
            var y = Math.sin(latA * 3.141592653589793 / 180.0) * Math.sin(latB * 3.141592653589793 / 180.0);
            var s = x + y;
            if (s > 1.0) {
                s = 1.0;
            }

            if (s < -1.0) {
                s = -1.0;
            }

            var alpha = Math.acos(s);
            var distance = alpha * Number(earthR);
            return distance;
        },
        transformLat:function( x,  y){
            var ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
            ret += (20.0 * Math.sin(6.0 * x * 3.141592653589793) + 20.0 * Math.sin(2.0 * x * 3.141592653589793)) * 2.0 / 3.0;
            ret += (20.0 * Math.sin(y * 3.141592653589793) + 40.0 * Math.sin(y / 3.0 * 3.141592653589793)) * 2.0 / 3.0;
            ret += (160.0 * Math.sin(y / 12.0 * 3.141592653589793) + 320.0 * Math.sin(y * 3.141592653589793 / 30.0)) * 2.0 / 3.0;
            return ret;
        },
        transformLon:function( x,  y){
            var ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
            ret += (20.0 * Math.sin(6.0 * x * 3.141592653589793) + 20.0 * Math.sin(2.0 * x * 3.141592653589793)) * 2.0 / 3.0;
            ret += (20.0 * Math.sin(x * 3.141592653589793) + 40.0 * Math.sin(x / 3.0 * 3.141592653589793)) * 2.0 / 3.0;
            ret += (150.0 * Math.sin(x / 12.0 * 3.141592653589793) + 300.0 * Math.sin(x / 30.0 * 3.141592653589793)) * 2.0 / 3.0;
            return ret;
        },
        delta:function(wgLat,  wgLon){
            var latlng = [];
            var dLat = this.transformLat(wgLon - 105.0, wgLat - 35.0);
            var dLon = this.transformLon(wgLon - 105.0, wgLat - 35.0);
            var radLat = wgLat / 180.0 * 3.141592653589793;
            var magic = Math.sin(radLat);
            magic = 1.0 - 0.006693421622965943 * magic * magic;
            var sqrtMagic = Math.sqrt(magic);
            dLat = dLat * 180.0 / (6335552.717000426 / (magic * sqrtMagic) * 3.141592653589793);
            dLon = dLon * 180.0 / (6378245.0 / sqrtMagic * Math.cos(radLat) * 3.141592653589793);
            latlng[0] = dLat;
            latlng[1] = dLon;
            return latlng;
        },
        outOfChina:function(lat,  lon){
            if (lon >= 72.004 && lon <= 137.8347) {
                return lat < 0.8293 || lat > 55.8271;
            } else {
                return true;
            }
        }
    }
})();