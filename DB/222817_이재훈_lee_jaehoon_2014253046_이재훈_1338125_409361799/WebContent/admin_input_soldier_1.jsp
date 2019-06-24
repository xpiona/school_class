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
<title>Insert title here</title>
</head>
<body>









 <form method="post" action="admin_input_soldier_2.jsp">
 
id:			<input type="text" name="id"><br>
password:	<input type="password" name="password"><br>
이름:			<input type="text" name="name"><br>
나이:			<input type="text" name="age"><br>
출생지:		<input type="text" name="hometown"><br>

공격력:		<input type="text" name="attack"><br>
방어력:		<input type="text" name="defence"><br>
체력:			<input type="text" name="hp"><br>
마력:			<input type="text" name="mp"><br>
힘:			<input type="text" name="strenght"><br>

지능:			<input type="text" name="intelligence"><br>
종족이름:		<input type="text" name="race"><br>
스킬이름:		<input type="text" name="skillname"><br>
생존여부:		<input type="text" name="alive"><br>

<input type="submit" value="등록"/> 
<input type="button" value="취소"/>
</form>
<a href="logout.jsp">로그아웃</a><br>












<%
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
			sql = "select 종족이름 from 종족 ";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){

	          String name  = rs.getString("종족이름");
	          %>
<table class="type11">
<tr>
<td width=150>사용가능 종족</td>
<td width=150><%= name %></td>
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

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 스킬이름 from 스킬 where 스킬사용여부 = '미사용' ";
			pstmt=conn.prepareStatement(sql);

		  	rs = pstmt.executeQuery();

		  while(rs.next()){
	          String name  = rs.getString("스킬이름");

	          %>
<table class="type11">
<tr>
<td width=150>사용가능 스킬</td>
<td width=150><%= name %></td>
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

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 아이템이름 from 아이템 where 사용용사 is null ";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("아이템이름");
	          %>
<table class="type11">
<tr>
<td width=150>사용가능 아이템</td>
<td width=150><%= name %></td>
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