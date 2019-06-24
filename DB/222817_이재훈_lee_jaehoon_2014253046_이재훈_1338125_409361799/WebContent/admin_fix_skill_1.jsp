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
	String skillname = request.getParameter("skillname");
	int hp = Integer.parseInt(request.getParameter("hp"));
	int mp = Integer.parseInt(request.getParameter("mp"));
	String using = request.getParameter("using");
%>

 <form method="post" action="admin_fix_skill_2.jsp">
스킬이름:<input type="text" name="skillname" value=<%=skillname%> /><br>
체력증가:<input type="text" name="hp" value=<%=hp%> /><br>
마력증가:<input type="text" name="mp" value=<%=mp%> /><br>
스킬사용여부:<input type="text" name="using" value=<%=using%> /><br>
<input type="submit" value="수정하기"/> 
<input type="button" value="취소"/>
</form>



<a href="logout.jsp">로그아웃</a>
</body>
</html>