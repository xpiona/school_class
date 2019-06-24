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
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String hometown = request.getParameter("hometown");
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int hp = Integer.parseInt(request.getParameter("hp"));
	int mp = Integer.parseInt(request.getParameter("mp"));
	int strenght = Integer.parseInt(request.getParameter("strenght"));
	int intelligence = Integer.parseInt(request.getParameter("intelligence"));
	String race = request.getParameter("race");
	String skillname = request.getParameter("skillname");
	String alive = request.getParameter("alive");
%>

 <form method="post" action="admin_fix_soldier_2.jsp">
id:<input type="text" name="id" value=<%=id%> /><br>
password:<input type="text" name="password" value=<%=password%> /><br>
이름:<input type="text" name="name" value=<%=name%> /><br>
나이:<input type="text" name="age" value=<%=age%> /><br>
출생지:<input type="text" name="hometown" value=<%=hometown%> /><br>

공격력:<input type="text" name="attack" value=<%=attack%> /><br>
방어력:<input type="text" name="defence" value=<%=defence%> /><br>
체력:<input type="text" name="hp" value=<%=hp%> /><br>
마력:<input type="text" name="mp" value=<%=mp%> /><br>
힘:<input type="text" name="strenght" value=<%=strenght%> /><br>

지능:<input type="text" name="intelligence" value=<%=intelligence%> /><br>
종족:<input type="text" name="race" value=<%=race%> /><br>
스킬이름:<input type="text" name="skillname" value=<%=skillname%> /><br>
생존여부:<input type="text" name="alive" value=<%=alive%> /><br>

<input type="submit" value="수정하기"/> 
<input type="button" value="취소"/>
</form>



<a href="logout.jsp">로그아웃</a>
</body>
</html>