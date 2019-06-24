<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>

<html>
    <head>
        <meta charset="UTF-8">
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
        <h1><%= session.getAttribute("signedUser") %>님 <small>반갑습니다.</small></h1>
        <a href="logout.jsp">로그아웃</a><br>
        <a href="admin_search_select.jsp">검색</a><br>
        <a href="admin_input_select.jsp">입력</a><br>
        <a href="admin_see_all.jsp">모두보기</a><br>
    </body>
</html>