<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
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
int h=0;
int v=0;
String val1[] = request.getParameterValues("checkbox1");
String val2[] = request.getParameterValues("checkbox2");
int count_soldier = 0;
int count_legion = 0;
count_soldier = Integer.parseInt(request.getParameter("count_soldier"));
count_legion = Integer.parseInt(request.getParameter("count_legion"));
String[] value1 = new String[count_soldier];
String[] value2 = new String[count_legion];

	value1[0]=val1[0];
	value1[1]=val1[1];
	value2[0]=val2[0];
	value2[1]=val2[1];

	String newval1_0=value1[0].substring(0,3);
	String newval1_1=value1[1].substring(0,3);
	String newval2_0=value2[0].substring(0,3);
	String newval2_1=value2[1].substring(0,3);
%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;


int attack1=0,attack2=0,attack3=0,attack4=0;
int defence1=0,defence2=0,defence3=0,defence4=0;






try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
			sql = "select 공격력,방어력 from 용사 where id = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, newval1_0);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){
	       	   attack1 = rs.getInt("공격력");
	           defence1 = rs.getInt("방어력");        
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
			sql = "select 공격력,방어력 from 용사 where id = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, newval1_1);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){
	       	   attack2 = rs.getInt("공격력");
	           defence2 = rs.getInt("방어력");        
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
	
			sql = "select 총공격력,총방어력 from 군단 where 군단이름 = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, newval2_0);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){  
	       	   attack3 = rs.getInt("총공격력");
	           defence3 = rs.getInt("총방어력");
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
	
			sql = "select 총공격력,총방어력 from 군단 where 군단이름 = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, newval2_1);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){  
	       	   attack4 = rs.getInt("총공격력");
	           defence4 = rs.getInt("총방어력");
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

int y_attack,y_defence=0;
int l_attack,l_defence=0;
y_attack = attack1 + attack2;
y_defence = defence1 + defence2;
l_attack = attack3 + attack4;
l_defence = defence3 + defence4;




if(y_attack<l_defence&l_attack<y_defence){%>
<h2><a href="ana_simulation_1.jsp">1번결과보기</a></h2>
<%
}

else if(y_attack>l_defence&l_attack>y_defence){%>
<h2><a href="ana_simulation_2.jsp">2번결과보기</a></h2>
<%
}

else if(y_attack>l_defence){%>
<h2><a href="ana_simulation_3.jsp">3번결과보기</a></h2>
<%
}

else if(l_attack>y_defence){%>
<h2><a href="ana_simulation_4.jsp">4번결과보기</a></h2>
<%
}









%>


</body>
</html>