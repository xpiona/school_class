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
</head>
<body>

<%
	String name = request.getParameter("name");
	int many = Integer.parseInt(request.getParameter("many"));
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int move = Integer.parseInt(request.getParameter("move"));
	int morale = Integer.parseInt(request.getParameter("morale"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "update 군단 set 군단이름=?, 병력수=?, 총공격력=?, 총방어력=?, 이동력=?, 사기=? where 군단이름 = ?";
	int n=0; 
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,name);
		pstmt.setInt(2,many);	
		pstmt.setInt(3,attack);
		pstmt.setInt(4,defence);
		pstmt.setInt(5,move);
		pstmt.setInt(6,morale);
		pstmt.setString(7,name);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		String redirectUrl = "admin_welcome.jsp";
		response.sendRedirect(redirectUrl);
		
	}catch(SQLException se){
		System.out.println(se.getMessage());
	}finally{
		try{
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}catch(SQLException se){
			System.out.println(se.getMessage());
		}
	}%>

</body>
</html>