<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.Arrays" %>
<%
    request.setCharacterEncoding("UTF-8");
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
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
int h_l = 0;

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select count(장군이름) from 장군군단";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){
	          h_l = rs.getInt("count(장군이름)");
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


/*===================================================================================*/

String[] head_name = new String[h_l];
String[] legion_name = new String[h_l];
int i=0;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 장군이름,군단이름 from 장군군단";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  	for(i=0;rs.next();i++){
		  		head_name[i]  = rs.getString("장군이름");
		  		legion_name[i]  = rs.getString("군단이름");
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

/*===================================================================================================================*/
int y=0;
int m_attack1=0;
int m_defence1=0;
int m_attack2=0;
int m_defence2=0;
int n_attack = 0;
int n_defence =0;
do{
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		
				sql = "select 군단공격력보정,군단방어력보정 from 장군 where 장군이름 = ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, head_name[y]);
			  	rs = pstmt.executeQuery();
			  	while(rs.next()){
			          m_attack1  = rs.getInt("군단공격력보정");
			          m_defence1 = rs.getInt("군단방어력보정");
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
		
				sql = "select 총공격력,총방어력 from 군단 where 군단이름 = ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, legion_name[y]);
			  	rs = pstmt.executeQuery();
			  	while(rs.next()){
			          m_attack2  = rs.getInt("총공격력");
			          m_defence2 = rs.getInt("총방어력");
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
	
	
	
	n_attack = m_attack1 + m_attack2 + n_attack;
	n_defence = m_defence1 + m_defence2 + n_defence;
	y++;
}while(y<h_l);
%>
<table class="type11">
<tr>
<td width=150>마물군단의 총 공격력</td>
<td width=150><%=n_attack %></td>
</tr>

<tr>
<td width=150>마물군단의 총 방어력</td>
<td width=150><%=n_defence %></td>
</tr>
</table>

</body>
</html>