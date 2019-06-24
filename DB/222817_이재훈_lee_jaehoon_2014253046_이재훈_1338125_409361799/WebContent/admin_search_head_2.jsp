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
		document.myForm.action='admin_fix_head_1.jsp';}
	if(index==2){
		document.myForm.action='admin_delete_head.jsp';}	
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
	
			sql = "select 장군이름,장군나이,군단공격력보정,군단방어력보정,군단이동력보정,군단사기보정,천적종족 from 장군 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("장군이름");
	          int age = rs.getInt("장군나이");
	       	  int attack = rs.getInt("군단공격력보정");
	          int defence = rs.getInt("군단방어력보정");
	          int move = rs.getInt("군단이동력보정");
	          int morale = rs.getInt("군단사기보정");
	          String race  = rs.getString("천적종족");		
	          %>
	          <h2>Here's a very simple table</h2>
<form name='myForm' method='post'>


<input type="hidden" name="name" value="<%=name%>" />     
<input type="hidden" name="age" value="<%=age%>" />
<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="hp" value="<%=move%>" />     
<input type="hidden" name="mp" value="<%=morale%>" />
<input type="hidden" name="race" value="<%=race %>" />    


<table class="type11">
<tr>
<td width=150>장군이름</td>
<td width=150>장군나이</td>
<td width=150>군단공격력보정</td>
<td width=150>군단방어력보정</td>
<td width=150>군단이동력보정</td>
<td width=150>군단사기보정</td>
<td width=150>천적종족</td>
<td width=150>수정하기</td>
<td width=150>삭제하기</td>
</tr>
<tr>
<td width=150><%= name %></td>
<td width=150><%= age %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= move %></td>
<td width=150><%= morale %></td>
<td width=150><%= race %></td>
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


</body>
</html>