package com.sts.fble.Model;

import com.sts.fble.Common.APIConsts;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.Serializable;

public class DeviceModel implements Serializable {
    public String name = "";
    public String address = "";

    public DeviceModel(String name, String address) {
        this.name = name;
        this.address = address;
    }

    public DeviceModel(JSONObject json) {
        try {
            name = json.getString(APIConsts.name);
            address = json.getString(APIConsts.address);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public JSONObject toJSON(){
        JSONObject object = new JSONObject();
        try {
            object.put(APIConsts.name, name);
            object.put(APIConsts.address, address);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return  object;
    }
}
