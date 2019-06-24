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
<%
	String skillname = request.getParameter("skillname");
	int hp = Integer.parseInt(request.getParameter("hp"));
	int mp = Integer.parseInt(request.getParameter("mp"));
	String using = request.getParameter("using");

	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "insert into 스킬 values(?,?,?,?)";
	int n=0; 
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,skillname);
		pstmt.setInt(2,hp);
		pstmt.setInt(3,mp);
		pstmt.setString(4,using);
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