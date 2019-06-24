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
		document.myForm.action='admin_fix_legion_1.jsp';}
	if(index==2){
		document.myForm.action='admin_delete_legion.jsp';}	
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
	
			sql = "select 군단이름,병력수,총공격력,총방어력,이동력,사기 from 군단 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("군단이름");
	       	  String many  = rs.getString("병력수");	
	       	  
	       	  int attack = rs.getInt("총공격력");
	          int defence = rs.getInt("총방어력");
	          int move = rs.getInt("이동력");
	          int morale = rs.getInt("사기");
	          
	          %>
	          <h2>Here's a very simple table</h2>
<form name='myForm' method='post'>

<input type="hidden" name="name" value="<%=name%>" />     
<input type="hidden" name="many" value="<%=many%>" />   
<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="move" value="<%=move%>" />     
<input type="hidden" name="morale" value="<%=morale%>" />


<table class="type11">
<tr>
<td width=150>군단이름</td>
<td width=150>병력수</td>
<td width=150>총공격력</td>
<td width=150>총방어력</td>
<td width=150>이동력</td>
<td width=150>사기</td>
<td width=150>수정하기</td>
<td width=150>삭제하기</td>
</tr>
<tr>
<td width=150><%= name %></td>
<td width=150><%= many %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= move %></td>
<td width=150><%= morale %></td>
<td width=150> <input type="button" value="수정" onclick='mySubmit(1)' /> </td>
<td width=150> <input type="button" value="삭제" onclick='mySubmit(2)' /> </td>
</tr>
</table>
</form>		          
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













<a href="logout.jsp">로그아웃</a>


</body>
</html>