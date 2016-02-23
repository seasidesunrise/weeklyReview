<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tnt.weeklyreview.model.Task" %>
<%@ page import="org.springframework.util.CollectionUtils" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<body>
<%
    List<Integer> dateIntList = (List<Integer>) request.getAttribute("dateIntList");
    String uid = (String) request.getAttribute("uid");

    int part1Percent = 58;
    int part2Percent = 17;
    int part3Percent = 15;
    int part4Percent = 10;
%>

<div>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="format-detection" content="telephone=no" />
<h1>小码日报</h1><a href="/user/logout.htmls">退出(<%=uid%>)</a>
</div>

<head>
<script src="/js/jquery.min.js"></script>
<script src="/js/jRate.js"></script>
<script src="/js/user_index.js"></script>
<script type="text/javascript">var uid=<%=uid%>;</script>

<style type="text/css">
    table{ background-color:#aaa; line-height:25px;}
    th{ background-color:#fff;}
    td{ background-color:#fff; }
</style>
</head>
<%
for (int j = dateIntList.size() - 1; j >= 0; j--) {
    Integer dateInt = dateIntList.get(j);
    String todayDate = (String) request.getAttribute(dateInt+"-todayDate");

    List<Task> vipTasks = (List<Task>) request.getAttribute(dateInt+"-vipTasks");
    Integer vipNum = 1;
    if (!CollectionUtils.isEmpty(vipTasks)) {
        vipNum = vipTasks.size();
    }

    List<Task> otherTasks = (List<Task>) request.getAttribute(dateInt+"-otherTasks");
    Integer otherNum = 1;
    if (!CollectionUtils.isEmpty(otherTasks)) {
        otherNum = otherTasks.size();
    }

    List<Task> nextWeekTasks = (List<Task>) request.getAttribute(dateInt+"-nextWeekTasks");
    Integer nextWeekNum = 1;
    if (!CollectionUtils.isEmpty(nextWeekTasks)) {
        nextWeekNum = nextWeekTasks.size();
    }

    List<Task> myThinkTasks = (List<Task>) request.getAttribute(dateInt+"-myThinkTasks");
    Integer myThinkNum = 1;
    if (!CollectionUtils.isEmpty(myThinkTasks)) {
        myThinkNum = myThinkTasks.size();
    }

    System.out.println(todayDate);
    System.out.println(vipTasks);
    %>
    <script type="text/javascript">
        $(function () {
            var vipNum = <%=vipNum%>;
            var otherNum = <%=otherNum%>;
            var nextWeekNum = <%=nextWeekNum%>;
            var myThinkNum = <%=myThinkNum%>;

            $('#<%=dateInt%>-vip-addTaskBtn').on('click', function () {
                addTaskFunc("<%=dateInt%>-vip", vipNum++);
            });
            $('#<%=dateInt%>-other-addTaskBtn').on('click', function () {
                addTaskFunc("<%=dateInt%>-other", otherNum++);
            });
            $('#<%=dateInt%>-nextWeek-addTaskBtn').on('click', function () {
                addTaskFunc("<%=dateInt%>-nextWeek", nextWeekNum++);
            });
            $('#<%=dateInt%>-myThink-addTaskBtn').on('click', function () {
                addMyThinkTaskFunc("<%=dateInt%>-myThink", myThinkNum++);
            });

            $('#<%=dateInt%>-finish').on('click', function () {
                finishOnClicked(uid, <%=dateInt%>, vipNum, otherNum, nextWeekNum, myThinkNum);
            });
        });
    </script>
    <table border="0" cellpadding="0" cellspacing="1">
        <caption><h3><%=todayDate%>日报</h3></caption>
        <%String prefix = dateInt + "-vip";%>
        <tr>
            <td colspan="4">
                <div>
                    <span style="vertical-align: middle">1, 今日重点工作</span>
                    <img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
                </div>
            </td>
        </tr>

        <%
            int k = 1;
            Task task = null;
            String content = "";
            float rateValue = 0;
            Long taskId = 0L;
            Integer priority = 0;
            Integer totalCount = 0;
            do {
                if (!CollectionUtils.isEmpty(vipTasks)) {
                    totalCount = vipTasks.size();
                    task = vipTasks.get(k - 1);
                    content = task.getTask();
                    rateValue = task.getRate();
                    taskId = task.getId();
                    priority = task.getPriority();
                }

                String trId = prefix + "-tr" + k;
                String rateId = prefix + "-jRate" + k;
                String starId = prefix + "-star" + k;
                String resetButtonId = prefix + "-btn-reset" + k;
                String hiddenTid = prefix + "-id" + k;
                String editButtonId = prefix + "-editId" + k;
                String deleteButtonId = prefix + "-deleteId" + k;
                String textId = prefix + "-text" + k;
                String upBtnId = prefix + "-upBtn" + k;
                String downBtnId = prefix + "-downBtn" + k;
                 String hiddenTidValue = "";
                if (taskId != null && taskId != 0L) {
                    hiddenTidValue = Long.toString(taskId);
                }
                String priorityId = prefix + "-priority" + k;

                String upImgUrl = "/img/up1.png";
                String downImgUrl = "/img/down1.png";
//                if (k - 1 == 0) {
//                    upImgUrl = "/img/up2.png";
//                }
//                if (k == totalCount) {
//                    downImgUrl = "/img/down2.png";
//                }
        %>
        <tr id="<%=trId%>">
            <td style="width: <%=part1Percent%>%">
                <input id="<%=textId%>" type="text" size="80" value="<%=content%>" style="margin-left: 10px;"/>
            </td>
            <td style="width: <%=part2Percent%>%; height: 30px;" align="center">
                <div id="<%=rateId%>" style="height:20px;width: 100px;float:left"></div>
                <button id="<%=resetButtonId%>" style="margin-left: 3px;margin-top: 2px">重置</button>
                <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
                <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                <input id="<%=priorityId%>" type="hidden" value="<%=priority%>"/>
            </td>
            <td style="width: <%=part3Percent%>%" align="center">
                <button id="<%=editButtonId%>" style="margin-left: 5px">选项</button>
                <button id="<%=deleteButtonId%>" style="margin-left: 10px; margin-right: 5px">删除</button>
            </td>
            <td style="width: <%=part4Percent%>%" align="center">
                <img id="<%=upBtnId%>" src="<%=upImgUrl%>" alt="移动到下面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
                <img id="<%=downBtnId%>" src="<%=downImgUrl%>" alt="移动到上面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </td>

            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                        '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');

                $('#<%=upBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var previousPriorityId = $tr.prev().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var previousPriority = $('#' + previousPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', previousPriority);
                        $('#' + previousPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.prev().before($tr);

                        // TODO 监测是否到了第一行

                    }
                });

                $('#<%=downBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var nextPriorityId = $tr.next().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var nextPriority = $('#' + nextPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', nextPriority);
                        $('#' + nextPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.next().after($tr);
                    }
                });
            </script>
        </tr>


        <%
            } while (++k <= vipTasks.size());%>



        <% prefix = dateInt + "-other"; %>
        <tr>
            <td colspan="4">2, 今日其它工作<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
        </tr>
        <%
            k = 1;
            task = null;
            content = "";
            rateValue = 0;
            taskId = 0L;
            priority = 0;
            do {
                if (!CollectionUtils.isEmpty(otherTasks)) {
                    task = otherTasks.get(k - 1);
                    content = task.getTask();
                    rateValue = task.getRate();
                    taskId = task.getId();
                    priority = task.getPriority();
                }

                String trId = prefix + "-tr" + k;
                String rateId = prefix + "-jRate" + k;
                String starId = prefix + "-star" + k;
                String resetButtonId = prefix + "-btn-reset" + k;
                String hiddenTid = prefix + "-id" + k;
                String editButtonId = prefix + "-editId" + k;
                String deleteButtonId = prefix + "-deleteId" + k;
                String textId = prefix + "-text" + k;
                String hiddenTidValue = "";
                String upBtnId = prefix + "-upBtn" + k;
                String downBtnId = prefix + "-downBtn" + k;
                if (taskId != null && taskId != 0L) {
                    hiddenTidValue = Long.toString(taskId);
                }
                String priorityId = prefix + "-priority" + k;

                String upImgUrl = "/img/up1.png";
                String downImgUrl = "/img/down1.png";
        %>
        <tr id="<%=trId%>">
            <td style="width: <%=part1Percent%>%">
                <input id="<%=textId%>" type="text" size="80" value="<%=content%>" style="margin-left: 10px;"/>
            </td>
            <td style="width: <%=part2Percent%>%; height: 30px;" align="center">
                <div id="<%=rateId%>" style="height:20px;width: 100px;float:left"></div>
                <button id="<%=resetButtonId%>" style="margin-left: 3px;margin-top: 2px">重置</button>
                <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
                <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                <input id="<%=priorityId%>" type="hidden" value="<%=priority%>"/>
            </td>
            <td style="width: <%=part3Percent%>%" align="center">
                <button id="<%=editButtonId%>" style="margin-left: 5px">编辑</button>
                <button id="<%=deleteButtonId%>" style="margin-left: 10px; margin-right: 5px">删除</button>
            </td>
            <td style="width: <%=part4Percent%>%" align="center">
                <img id="<%=upBtnId%>" src="<%=upImgUrl%>" alt="移动到下面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
                <img id="<%=downBtnId%>" src="<%=downImgUrl%>" alt="移动到上面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </td>

            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                        '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');


                $('#<%=upBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var previousPriorityId = $tr.prev().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var previousPriority = $('#' + previousPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', previousPriority);
                        $('#' + previousPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.prev().before($tr);

                        // TODO 监测是否到了第一行

                    }
                });

                $('#<%=downBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var nextPriorityId = $tr.next().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var nextPriority = $('#' + nextPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', nextPriority);
                        $('#' + nextPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.next().after($tr);
                    }
                });
            </script>
        </tr>


        <%
            } while (++k <= otherTasks.size());%>



        <% prefix = dateInt + "-nextWeek"; %>
        <tr>
            <td colspan="4">3, 下周工作计划<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
        </tr>
        <%
            k = 1;
            task = null;
            content = "";
            rateValue = 0;
            taskId = 0L;
            priority = 0;
            do {
                if (!CollectionUtils.isEmpty(nextWeekTasks)) {
                    task = nextWeekTasks.get(k - 1);
                    content = task.getTask();
                    rateValue = task.getRate();
                    taskId = task.getId();
                    priority = task.getPriority();
                }

                String trId = prefix + "-tr" + k;
                String rateId = prefix + "-jRate" + k;
                String starId = prefix + "-star" + k;
                String resetButtonId = prefix + "-btn-reset" + k;
                String hiddenTid = prefix + "-id" + k;
                String editButtonId = prefix + "-editId" + k;
                String deleteButtonId = prefix + "-deleteId" + k;
                String textId = prefix + "-text" + k;
                String hiddenTidValue = "";
                String upBtnId = prefix + "-upBtn" + k;
                String downBtnId = prefix + "-downBtn" + k;
                if (taskId != null && taskId != 0L) {
                    hiddenTidValue = Long.toString(taskId);
                }
                String priorityId = prefix + "-priority" + k;

                String upImgUrl = "/img/up1.png";
                String downImgUrl = "/img/down1.png";
        %>
        <tr id="<%=trId%>">
            <td style="width: <%=part1Percent%>%">
                <input id="<%=textId%>" type="text" size="80" value="<%=content%>" style="margin-left: 10px;"/>
            </td>
            <td style="width: <%=part2Percent%>%; height: 30px;" align="center">
                <div id="<%=rateId%>" style="height:20px;width: 100px;float:left"></div>
                <button id="<%=resetButtonId%>" style="margin-left: 3px;margin-top: 2px">重置</button>
                <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
                <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                <input id="<%=priorityId%>" type="hidden" value="<%=priority%>"/>
            </td>
            <td style="width: <%=part3Percent%>%;" align="center">
                <button id="<%=editButtonId%>" style="margin-left: 5px">编辑</button>
                <button id="<%=deleteButtonId%>" style="margin-left: 10px; margin-right: 5px">删除</button>
            </td>
            <td style="width: <%=part4Percent%>%" align="center">
                <img id="<%=upBtnId%>" src="<%=upImgUrl%>" alt="移动到下面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
                <img id="<%=downBtnId%>" src="<%=downImgUrl%>" alt="移动到上面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </td>

            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                        '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');


                $('#<%=upBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var previousPriorityId = $tr.prev().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var previousPriority = $('#' + previousPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', previousPriority);
                        $('#' + previousPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.prev().before($tr);

                        // TODO 监测是否到了第一行

                    }
                });

                $('#<%=downBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var nextPriorityId = $tr.next().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var nextPriority = $('#' + nextPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', nextPriority);
                        $('#' + nextPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.next().after($tr);
                    }
                });
            </script>
        </tr>


        <%
            } while (++k <= nextWeekTasks.size());%>



        <% prefix = dateInt + "-myThink"; %>
        <tr>
            <td colspan="4">4, 我的思考<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项"
                                        style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </td>
        </tr>



        <%
            k = 1;
            task = null;
            content = "";
            taskId = 0L;
            priority = 0;
            do {
                if (!CollectionUtils.isEmpty(myThinkTasks)) {
                    task = myThinkTasks.get(k - 1);
                    content = task.getTask();
                    taskId = task.getId();
                    priority = task.getPriority();
                }

                String trId = prefix + "-tr" + k;
                String vipRateId = prefix + "-jRate" + k;
                String vipStarId = prefix + "-star" + k;
                String vipButtonId = prefix + "-btn-click" + k;
                String hiddenTidValue = "";
                String hiddenInputTid = prefix + "-id" + k;
                String deleteId = prefix + "-deleteId" + k;
                if (taskId != null && taskId != 0L) {
                    hiddenTidValue = Long.toString(taskId);
                }
                String priorityId = prefix + "-priority" + k;

                String textAreaId = prefix + "-text" + k;
                String upBtnId = prefix + "-upBtn" + k;
                String downBtnId = prefix + "-downBtn" + k;
        %>
        <tr id="<%=trId%>">
            <td colspan="2">
                <textarea id="<%=textAreaId%>" rows="4" cols="92" style="margin: 5px 0px 5px 10px; width: 678px;"><%=content%></textarea>
            </td>
            <td>
                <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
                <input id="<%=hiddenInputTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                <input id="<%=priorityId%>" type="hidden" value="<%=priority%>"/>
            </td>
            <td>
                <img id="<%=upBtnId%>" src="/img/up1.png" alt="移动到下面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
                <img id="<%=downBtnId%>" src="/img/down1.png" alt="移动到上面" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </td>

            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=vipRateId%>', 0, '<%=vipStarId%>',
                        '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');


                $('#<%=upBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var previousPriorityId = $tr.prev().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var previousPriority = $('#' + previousPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', previousPriority);
                        $('#' + previousPriorityId).attr('value', currentPriority);

//                        $tr.fadeOut().fadeIn();
                        $tr.prev().before($tr);

                        // TODO 监测是否到了第一行

                    }
                });

                $('#<%=downBtnId%>').on('click', function() {
                    var $tr = $(this).parents("tr");
                    if ($tr.index() != 0) {
                        var currentPriorityId = $tr.attr('id').replace('tr', 'priority');
                        var nextPriorityId = $tr.next().attr('id').replace('tr', 'priority');
                        var currentPriority = $('#' + currentPriorityId).attr('value');
                        var nextPriority = $('#' + nextPriorityId).attr('value');
                        $('#' + currentPriorityId).attr('value', nextPriority);
                        $('#' + nextPriorityId).attr('value', currentPriority);
//                        $tr.fadeOut().fadeIn();
                        $tr.next().after($tr);
                    }
                });
            </script>
        </tr>

        <%
            } while (++k <= myThinkTasks.size());
        %>

        <tr>
            <td colspan="4" align="right" style="height: 40px;"><button id="<%=dateInt%>-finish" style="height: 35px;width: 76px;margin-right: 5px;">保存</button></td>
        </tr>
    </table>
    <%
}
%>

</body>
</html>
