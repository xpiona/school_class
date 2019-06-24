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
String id =request.getParameter("id");

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 아이템이름,종류,공격력증가,방어력증가,힘증가,지능증가 from 아이템 where 사용용사 = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("아이템이름");
	          String kind  = rs.getString("종류");
	       	  int attack = rs.getInt("공격력증가");
	          int defence = rs.getInt("방어력증가");
	          int strenght = rs.getInt("힘증가");
	          int intelligence = rs.getInt("지능증가");	
	          %>
	          <h2>Here's a very simple table</h2>


<table class="type11">
<tr>
<td width=150>아이템이름</td>
<td width=150>종류</td>
<td width=150>공격력증가</td>
<td width=150>방어력증가</td>
<td width=150>힘증가</td>
<td width=150>지능증가</td>
</tr>
<tr>

<td width=150><%= name %></td>
<td width=150><%= kind %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= strenght %></td>
<td width=150><%= intelligence %></td>
</tr>
</table>
	          
<%
}
rs.close();
pstmt.close();
conn.close();
}
catch(SQLException se){
	System.out.println(se.getMessage());
	rs.close();
	pstmt.close();
	conn.close();
}
%>


</body>
</html>