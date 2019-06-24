<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>  
<%
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>
                  <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색!</title>
        <style>
table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table.type11 th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #ce4869 ;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}
body{
        background-image: url("dbtrip.jpg");
        background-size:cover;	
        }</style>
</head>
<body>
<a href="admin_search_admin_1.jsp">관리자테이블검색</a><br>
<a href="admin_search_soldier_1.jsp">용사검색</a><br>
<a href="admin_search_skill_1.jsp">스킬검색</a><br>
<a href="admin_search_race_1.jsp">종족검색</a><br>
<a href="admin_search_item_1.jsp">아이템검색</a><br>
<a href="admin_search_legion_1.jsp">군단검색</a><br>
<a href="admin_search_head_1.jsp">장군검색</a><br>
<a href="logout.jsp">로그아웃</a>
</body>
</html>