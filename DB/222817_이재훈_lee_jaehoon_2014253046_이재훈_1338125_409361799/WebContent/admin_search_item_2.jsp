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
<script>
function mySubmit(index){
	if(index==1){
		document.myForm.action='admin_fix_item_1.jsp';}
	if(index==2){
		document.myForm.action='admin_delete_item.jsp';}	
	document.myForm.submit();
}
</script>
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
	
			sql = "select 아이템이름,종류,공격력증가,방어력증가,힘증가,지능증가,사용용사 from 아이템 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("아이템이름");
	          String kind  = rs.getString("종류");
	       	  int attack = rs.getInt("공격력증가");
	          int defence = rs.getInt("방어력증가");
	          int strenght = rs.getInt("힘증가");
	          int intelligence = rs.getInt("지능증가");
	          String who  = rs.getString("사용용사");		

	          %>
	          <h2>Here's a very simple table</h2>
<form name='myForm' method='post'>


<input type="hidden" name="name" value="<%=name%>" />  
<input type="hidden" name="kind" value="<%=kind%>" />  
<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="strenght" value="<%=strenght %>" /> 
<input type="hidden" name="intelligence" value="<%=intelligence %>" />
<input type="hidden" name="who" value="<%=who %>" />    

<table class="type11">
<tr>
<td width=150>아이템이름</td>
<td width=150>종류</td>
<td width=150>공격력증가</td>
<td width=150>방어력증가</td>
<td width=150>힘증가</td>
<td width=150>지능증가</td>
<td width=150>사용용사</td>
<td width=150>수정하기</td>
<td width=150>삭제하기</td>
</tr>
<tr>

<td width=150><%= name %></td>
<td width=150><%= kind %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= strenght %></td>
<td width=150><%= intelligence %></td>
<td width=150><%= who %></td>
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