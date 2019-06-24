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
	int many = Integer.parseInt(request.getParameter("many"));
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int move = Integer.parseInt(request.getParameter("move"));
	int morale = Integer.parseInt(request.getParameter("morale"));
%>

 <form method="post" action="admin_fix_legion_2.jsp">
군단이름:<input type="text" name="name" value=<%=name%> /><br>
병력수:<input type="text" name="many" value=<%=many%> /><br>
총공격력:<input type="text" name="attack" value=<%=attack%> /><br>
총방어력:<input type="text" name="defence" value=<%=defence%> /><br>
이동력:<input type="text" name="move" value=<%=move%> /><br>
사기:<input type="text" name="morale" value=<%=morale%> /><br>
<input type="submit" value="수정하기"/> 
<input type="button" value="취소"/>
</form>



<a href="logout.jsp">로그아웃</a>
</body>
</html>