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
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
int count_soldier=0;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select count(id) from 용사";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	           count_soldier  = rs.getInt("count(id)");
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


String[] id = new String[count_soldier];
String[] name = new String[count_soldier];
int j=0;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select id,이름 from 용사";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  	for(j=0;rs.next();j++){
		  		id[j]  = rs.getString("ID");
		  		name[j]  = rs.getString("이름");
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

<form method="post" action="ana_simulation_result.jsp">
연세 왕국의 용사<br>
<% 
	for(j=0;j<count_soldier;j++){
%>
   <input type='checkbox' name='checkbox1' value=<%=id[j]%>/><%=name[j]%><br>
<%  }
%>
  <br>


<%

int count_legion=0;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select count(군단이름) from 군단";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  while(rs.next()){
	           count_legion  = rs.getInt("count(군단이름)");
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


String[] legion_name = new String[count_legion];
int t=0;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 군단이름 from 군단";
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();

		  	for(t=0;rs.next();t++){
		  		legion_name[t]  = rs.getString("군단이름");
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

마물 군단의 용사<br>
<% 
	for(j=0;j<count_legion;j++){
	
%>
  <input type='checkbox' name='checkbox2' value=<%=legion_name[j]%>/><%=legion_name[j]%><br>
  
<%  }
%>
  <br>
  <input type='hidden' name='count_soldier' value=<%=count_soldier%>>
  <input type='hidden' name='count_legion' value=<%=count_legion%>>

  <input type="submit">
</form>


</body>
</html>