<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
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
		document.myForm.action='admin_fix_admin_1.jsp';}
	if(index==2){
		document.myForm.action='admin_delete_admin.jsp';}	
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

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 아이디,비밀번호 from 관리자 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String id  = rs.getString("아이디");
	          String password  = rs.getString("비밀번호");
	          %>
	          <h2>Here's a very simple table</h2>
	          
<form name='myForm' method='post'>
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="password" value="<%=password%>" />  

<table class="type11">
<tr>
<td width=150>ID</td>
<td width=150>PASSWORD</td>
<td width=150>수정하기</td>
<td width=150>삭제하기</td>
</tr>
<tr>
<td width=150><%= id %></td>
<td width=150>****</td>
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
	pstmt.close();
	conn.close();
}
%>
















</body>
</html>