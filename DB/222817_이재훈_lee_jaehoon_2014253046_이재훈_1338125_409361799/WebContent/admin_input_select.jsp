<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<a href="admin_input_admin_1.jsp">관리자</a><br>
<a href="admin_input_soldier_1.jsp">용사</a><br>
<a href="admin_input_skill_1.jsp">스킬</a><br>
<a href="admin_input_race_1.jsp">종족</a><br>
<a href="admin_input_item_1.jsp">아이템</a><br>
<a href="admin_input_h_l_1.jsp">장군군단</a><br>
<a href="admin_input_legion_1.jsp">군단</a><br>
<a href="admin_input_head_1.jsp">장군</a>   <br>
<a href="logout.jsp">로그아웃</a>
</body>
</html> 