<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
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

<%
String id = request.getParameter("id");
String password = request.getParameter("password");
System.out.print(id);
System.out.print("\n");
System.out.print(password);
System.out.print("\n");

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	int k=0;
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
			session.setAttribute("signedUser", id);
			sql = "select 아이디,비밀번호 from 관리자 where 아이디 =? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){
	          String id_1  = rs.getString("아이디");
	          String password_1  = rs.getString("비밀번호");
	          System.out.println("들어왔음");
	          k=1;
		  }
		  
rs.close();
pstmt.close();
conn.close();
System.out.println("닫음");
if(k==1){
String redirectUrl = "admin_welcome.jsp";
response.sendRedirect(redirectUrl);}
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