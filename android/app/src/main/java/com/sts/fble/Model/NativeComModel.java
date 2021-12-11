package com.sts.fble.Model;

import com.sts.fble.Common.APIConsts;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.Serializable;

public class NativeComModel implements Serializable {
    public String command = "";
    public String passValue = "";

    public  NativeComModel(JSONObject json){
        try {
            command = json.getString(APIConsts.command);
            passValue = json.getString(APIConsts.passValue);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
