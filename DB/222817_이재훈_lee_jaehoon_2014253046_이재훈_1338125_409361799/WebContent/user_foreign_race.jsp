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
String race =request.getParameter("race");

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 종족이름,공격력보정,방어력보정,체력보정,마력보정,힘보정,지능보정,멸망여부 from 종족 where 종족이름 = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, race);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("종족이름");
	       	  int attack = rs.getInt("공격력보정");
	          int defence = rs.getInt("방어력보정");
	          int hp = rs.getInt("체력보정");
	          int mp = rs.getInt("마력보정");
	          int strenght = rs.getInt("힘보정");          
	          int intelligence = rs.getInt("지능보정");
	          String alive  = rs.getString("멸망여부");
	          %>
	          <table class="type11">
<tr>
<td width=150>종족이름</td>
<td width=150>공격력보정</td>
<td width=150>방어력보정</td>
<td width=150>체력보정</td>
<td width=150>마력보정</td>
<td width=150>힘보정</td>
<td width=150>지능보정</td>
<td width=150>멸망여부</td>
</tr>
<tr>

<td width=150><%= name %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= strenght %></td>
<td width=150><%= intelligence %></td>
<td width=150><%= alive %></td>
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