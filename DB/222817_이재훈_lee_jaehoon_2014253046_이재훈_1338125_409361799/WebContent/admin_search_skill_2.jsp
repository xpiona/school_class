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
<script>
function mySubmit(index){
	if(index==1){
		document.myForm.action='admin_fix_skill_1.jsp';}
	if(index==2){
		document.myForm.action='admin_delete_skill.jsp';}	
	document.myForm.submit();
}
</script>
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

	          String skillname = rs.getString("스킬이름");
	          int hp = rs.getInt("체력증가");
	          int mp = rs.getInt("마력증가");	
	          String using  = rs.getString("스킬사용여부");	
	          %>
	          <h2>Here's a very simple table</h2>
<form name='myForm' method='post'>

<input type="hidden" name="skillname" value="<%=skillname%>" />     
<input type="hidden" name="hp" value="<%=hp%>" />     
<input type="hidden" name="mp" value="<%=mp%>" />
<input type="hidden" name="using" value="<%=using %>" /> 
  

<table class="type11">
<tr>
<td width=150>스킬이름</td>
<td width=150>체력증가</td>
<td width=150>마력증가</td>
<td width=150>스킬사용여부</td>
<td width=150>수정하기</td>
<td width=150>삭제하기</td>
</tr>
<tr>
<td width=150><%= skillname %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= using %></td>
<td width=150> <input type="button" value="수정" onclick='mySubmit(1)' /> </td>
<td width=150> <input type="button" value="삭제" onclick='mySubmit(2)' /> </td>
</tr>
</table>
</form>	
<a href="logout.jsp">로그아웃</a>
	          
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