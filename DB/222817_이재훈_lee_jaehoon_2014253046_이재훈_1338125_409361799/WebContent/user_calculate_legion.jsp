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
<script>
function mySubmit(index){
	if(index==1){
		document.myForm.action='user_foreign_head.jsp';}	
	document.myForm.submit();
}
</script>
</head>
<body>
<%
	int d=0,i=0;
	String name = request.getParameter("name");
	String many = request.getParameter("many");
	int attack = Integer.parseInt(request.getParameter("attack"));
	int defence = Integer.parseInt(request.getParameter("defence"));
	int move = Integer.parseInt(request.getParameter("move"));
	int morale = Integer.parseInt(request.getParameter("morale"));

	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql =null;
	ResultSet rs =null;
	
	int l_attack=0;
	int l_defence=0;
	int l_move=0;
	int l_morale=0;

	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		
				sql = "select 총공격력,총방어력,이동력,사기 from 군단 where 군단이름 = ? ";
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,name);
			  	rs = pstmt.executeQuery();
			  
			  while(rs.next()){ 
		          	l_attack  = rs.getInt("총공격력");
		          	l_defence  = rs.getInt("총방어력");
		          	l_move  = rs.getInt("이동력");
		          	l_morale  = rs.getInt("사기");
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
String legion_name;
String head_name=null;

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select count(장군이름) from 장군군단 where 군단이름 = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,name);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          	d  = rs.getInt("count(장군이름)");
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

	String[] name1 = new String[d];

	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		
				sql = "select 장군이름,군단이름 from 장군군단 where 군단이름 = ? ";
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,name);
			  	rs = pstmt.executeQuery();
			  	
			  for(i=0; rs.next(); i++){
				  	name1[i]  		= rs.getString("장군이름");
	          		legion_name  	= rs.getString("군단이름");
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

int[] h_attack = new int[d];
int[] h_defence = new int[d];
int[] h_move = new int[d];
int[] h_morale = new int[d];
int al=0;
do{
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		System.out.println("장군 능력치검사");	
				sql = "select 군단공격력보정,군단방어력보정,군단이동력보정,군단사기보정 from 장군 where 장군이름 = ? ";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,name1[al]);
			  	rs = pstmt.executeQuery();
			  while(rs.next()){
				  
				  	h_attack[al]  	= rs.getInt("군단공격력보정");
		          	h_defence[al]  	= rs.getInt("군단방어력보정");
		          	h_move[al]		= rs.getInt("군단이동력보정");
		          	h_morale[al]		= rs.getInt("군단사기보정");
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
	al++;
}while(al<d);

	
%>

<form name='myForm' method='post'>

<%
String[] h_name = new String[d];
int w=0;
do{
%>
	<input type="hidden" name="h_name[w]" value="<%=name1[w]%>" />
<%
w++;	
}while(w<d);
%>




<table class="type11">
<tr>
<td width=150>	</td>
<td width=150>이름</td>
<td width=150>병력수</td>
<td width=150>총공격력</td>
<td width=150>총방어력</td>
<td width=150>이동력</td>
<td width=150>사기</td>
</tr>
<tr>
<td width=150>초기보정치</td>
<td width=150><%= name %></td>
<td width=150><%= many %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= move %></td>
<td width=150><%= morale %></td>
</tr>
<%
int f_attack =0;
int f_defence=0;
int f_move=0;
int f_morale=0;
int q=0;
do{
	f_attack = f_attack + h_attack[q];
	f_defence = f_defence + h_defence[q];
	f_move = f_move + h_move[q];
	f_morale = f_morale + h_morale[q];
	System.out.println("포문실행중");
	%>
<tr>
<td width=150><input type="button" value=<%=name1[q]%> onclick='mySubmit(1)' /></td>
<td width=150></td>
<td width=150></td>
<td width=150><%= h_attack[q] %></td>
<td width=150><%= h_defence[q] %></td>
<td width=150><%= h_move[q] %></td>
<td width=150><%= h_morale[q] %></td>
</tr>
<%
q++;
}while(q<d);
f_attack 	= f_attack + attack;
f_defence 	= f_defence + defence;
f_move 		= f_move + move;
f_morale 	= f_morale + morale;

%>




<tr>
<td width=150>최종보정치</td>
<td width=150></td>
<td width=150></td>
<td width=150><%= f_attack %></td>
<td width=150><%= f_defence %></td>
<td width=150><%=f_move%></td>
<td width=150><%=f_morale%></td>
</tr>
</table>
</form>
</body>
</html>