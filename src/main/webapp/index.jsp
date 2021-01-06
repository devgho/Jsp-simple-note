<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page language="java" %> 
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
String sql= "SELECT * FROM "+tableName;
if (request.getParameter("title")!=null)
    sql = "select * from note where title like'%"+request.getParameter("title")+"%'";
ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>欢迎使用在线便签</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <style>
        p{
            overflow:hidden;
            text-overflow:ellipsis; /* 加省略号 */
            white-space:nowrap; /* 强制不换行 */
        }
    </style>
    <script>
        function query(){
            var i = prompt("请输入您需要查询的标题");
            window.location = 'index.jsp?title='+i;
        }
    </script>
</head>
<body>
    <section class="container">
        <header class="row">
            <button onclick="window.location='note.jsp'">新建</button>
            <h4 align="center">无聊的便签</h4>
            <button onclick="query();">查询</button>
        </header>
        <div class="row content">
            <h3>记录你的想法</h3>
            <p>无聊的便签是一款永久免费的轻量级web便签,帮助你记录生活的每个瞬间</p>
            <a class="btn" onclick="alert('不给删')">删除</a>
        </div>
        <%
        while(rs.next()) { 
            %>
            <div class="row content" onclick="window.location='note.jsp?title=<% out.print(rs.getString(1)); %>'">
                <h3><% out.print(rs.getString(1)); %></h3>
                <p><% out.print(rs.getString(2));%></p>
                <a class="btn" href="delete.jsp?title=<% out.print(rs.getString(1)); %>">删除</a>
            </div>
            <%
        }
        %>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>
</html>
<%
rs.close(); 
stmt.close(); 
conn.close(); 
%>