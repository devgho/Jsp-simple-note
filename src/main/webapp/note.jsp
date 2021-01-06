<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %> 
<% 
//加载驱动程序 
String driverName="com.mysql.jdbc.Driver"; 
//数据库信息
String userName="note"; 
//密码 
String userPasswd="note"; 
//数据库名 
String dbName="note"; 
//表名 
String tableName="note"; 
//将数据库信息字符串连接成为一个完整的url（也可以直接写成url，分开写是明了可维护性强） 
String url="jdbc:mysql://127.0.0.1/"+dbName+"?user="+userName+"&password="+userPasswd; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
Connection conn=DriverManager.getConnection(url); 
Statement stmt = conn.createStatement();   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <section class="container">
        <header class="row">
            <h4 align="center">无聊的便签</h4>
        </header>
        <%
        if (request.getParameter("title")!=null){
        String sql="select * from note where title = '"+request.getParameter("title")+"'"; 
        ResultSet rs = stmt.executeQuery(sql); 
        rs.next();
        %>
            <form method="post" action="up.jsp">
                <div class="input-group">
                    <span class="input-group-addon">Title</span>
                    <input name="title" type="text" class="form-control" placeholder="请输入标题" value="<%=rs.getString(1)%>">
                </div>
                <div class="form-group">
                    <textarea name="content" class="form-control" rows="24"><%=rs.getString(2)%></textarea>
                </div>
                <button name="title_old" value="<%=rs.getString(1)%>" class="btn btn-default btn-success" style="width:49%;">保存</button>
                <a href="index.jsp" class="btn btn-default" style="width:49%;">返回</a>
            </form>
        <%}else{%>
            <form method="post" action="add.jsp">
                <div class="input-group">
                    <span class="input-group-addon">Title</span>
                    <input type="text" name="title" class="form-control" placeholder="请输入标题" value="">
                </div>
                <div class="form-group">
                    <textarea class="form-control" name="content" rows="24"></textarea>
                </div>
                <button class="btn btn-default btn-success" style="width:49%;">保存</button>
                <a href="index.jsp" class="btn btn-default" style="width:49%;">返回</a>
            </form>
        <%}%>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>
