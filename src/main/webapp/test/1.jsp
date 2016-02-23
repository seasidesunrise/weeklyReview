<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %><%

    Map result = new HashMap();
    Date currentDate = new Date();
    long currentTimeInMillis = currentDate.getTime();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm00");
    int timeInterval = 60000;
    List dataList = new ArrayList();
    for (int i = 0; i < 500; i++) {
        long timeMillis = currentTimeInMillis - (timeInterval) * i;
        Date tmpDate = new Date(timeMillis);
        String time = sdf.format(tmpDate);

        double open = 612.3 + Math.random() * 3;
        double close = 612.3 + Math.random() * 4;
        double max = 612.3 + Math.random() * 5;
        double low = 612.3 + Math.random() * 2;

        max = Math.max(open, max);
        max = Math.max(close, max);
        max = Math.max(low, max);

        low = Math.min(open, low);
        low = Math.min(close, low);
        low = Math.min(max, low);

        Map<String, String> dataMap = new HashMap<String, String>();
        dataMap.put("time", time);
        dataMap.put("close", Double.toString(close));
        dataMap.put("open", Double.toString(open));
        dataMap.put("high", Double.toString(max));
        dataMap.put("low", Double.toString(low));

        dataList.add(dataMap);
    }
    result.put("data", dataList);
    result.put("code", "000");

    String jsonString = JSONObject.toJSONString(result);
    out.println(jsonString);
%>