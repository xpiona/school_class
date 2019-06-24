<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
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
String col = request.getParameter("col");
String word = request.getParameter("word");
System.out.print(col);
System.out.print("\n");
System.out.print(word);

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 스킬이름,체력증가,마력증가,스킬사용여부 from 스킬 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String skillname  = rs.getString("스킬이름");
	          int skill_hp = rs.getInt("체력증가");
	          int skill_mp = rs.getInt("마력증가");
	          String using  = rs.getString("스킬사용여부");	
	          %>
	          
	          <h2>Here's a very simple table</h2>
<table class="type11">
<tr>
<td width=150>스킬이름</td>
<td width=150>체력증가</td>
<td width=150>마력증가</td>
<td width=150>스킬사용여부</td>
</tr>
<tr>
<td width=150><%= skillname %></td>
<td width=150><%= skill_hp %></td>
<td width=150><%= skill_mp %></td>
<td width=150><%= using %></td>
</tr>
</table>
<a href="user_welcome.jsp">뒤로가기</a>   
<%
}
rs.close();
pstmt.close();
conn.close();
}
catch(SQLException se){
	System.out.println(se.getMessage());

	pstmt.close();
	conn.close();
}
%>
















</body>
</html>