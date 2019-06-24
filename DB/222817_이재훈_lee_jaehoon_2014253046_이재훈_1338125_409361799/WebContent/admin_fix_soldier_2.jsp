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
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String hometown = request.getParameter("hometown");
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int hp = Integer.parseInt(request.getParameter("hp"));
	int mp = Integer.parseInt(request.getParameter("mp"));
	int strenght = Integer.parseInt(request.getParameter("strenght"));
	int intelligence = Integer.parseInt(request.getParameter("intelligence"));
	String race = request.getParameter("race");
	String skillname = request.getParameter("skillname");
	String alive = request.getParameter("alive");

	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql = "update 용사 set id=?, password=?, 이름=?, 나이=?, 출생지=?, 공격력=?, 방어력=?, 체력=?, 마력=?, 힘=?, 지능=?, 종족이름=?, 스킬이름=?, 생존여부=? where id = ?";
	int n=0; 
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,id);
		pstmt.setString(2,password);
		pstmt.setString(3,name);
		pstmt.setInt(4,age);	
		pstmt.setString(5,hometown);
		pstmt.setInt(6,attack);
		pstmt.setInt(7,defence);
		pstmt.setInt(8,hp);
		pstmt.setInt(9,mp);
		pstmt.setInt(10,strenght);
		pstmt.setInt(11,intelligence);
		pstmt.setString(12,race);
		pstmt.setString(13,skillname);
		pstmt.setString(14,alive);
		pstmt.setString(15,id);
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