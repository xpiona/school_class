<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
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
<%
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int move = Integer.parseInt(request.getParameter("move"));
	int morale = Integer.parseInt(request.getParameter("morale"));
	String race = request.getParameter("race");
%>

 <form method="post" action="admin_fix_head_2.jsp">
장군이름:<input type="text" name="name" value=<%=name%> /><br>
장군나이:<input type="text" name="age" value=<%=age%> /><br>
군단공격력보정:<input type="text" name="attack" value=<%=attack%> /><br>
군단방어력보정:<input type="text" name="defence" value=<%=defence%> /><br>
군단이동력보정:<input type="text" name="hp" value=<%=move%> /><br>
군단사기보정:<input type="text" name="mp" value=<%=morale%> /><br>
천적종족:<input type="text" name="race" value=<%=race%> /><br>


<input type="submit" value="수정하기"/> 
<input type="button" value="취소"/>
</form>



<a href="logout.jsp">로그아웃</a>
</body>
</html>