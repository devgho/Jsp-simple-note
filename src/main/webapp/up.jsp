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
if (request.getMethod().equals("POST")){
    if (request.getParameter("title")!=null){
        String title = new String((request.getParameter("title")).getBytes("ISO-8859-1"),"UTF-8");
        String content = new String((request.getParameter("content")).getBytes("ISO-8859-1"),"UTF-8");
        String title_old = new String((request.getParameter("title_old")).getBytes("ISO-8859-1"),"UTF-8");
        String sql = "update note set title = '"+title+"',content = '"+content+"' where title = '"+title_old+"'";
        int rs = stmt.executeUpdate(sql);
        if (rs!=0)
            out.print("<script>alert('保存成功"+rs+"');window.location='index.jsp';</script>");
        else
            out.print("<script>alert('标题已经存在"+rs+"');window.location='index.jsp';</script>");
    }else{
        out.print("<script>alert('没有任何请求');window.location='index.jsp';</script>");
    }
}else{
    out.print("<script>alert('请使用POST方法');window.location='index.jsp';");
}
%>