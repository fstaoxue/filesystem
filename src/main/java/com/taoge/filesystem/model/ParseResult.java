package com.taoge.filesystem.model;

public class ParseResult {

    private double lat;
    private double lng;
    private long time;
    private String standardTime;
    private int lineGroup;

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public String getStandardTime() {
        return standardTime;
    }

    public void setStandardTime(String standardTime) {
        this.standardTime = standardTime;
    }

    public int getLineGroup() {
        return lineGroup;
    }

    public void setLineGroup(int lineGroup) {
        this.lineGroup = lineGroup;
    }
}
