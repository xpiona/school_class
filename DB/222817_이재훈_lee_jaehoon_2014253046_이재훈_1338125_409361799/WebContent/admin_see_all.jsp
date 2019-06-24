<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
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

</head>
<body>

<%
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select id,password,이름,나이,출생지,공격력,방어력,체력,마력,힘,지능,종족이름,스킬이름,생존여부 from 용사";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String id  = rs.getString("ID");
	          String password  = rs.getString("password");
	          String name  = rs.getString("이름");
	          int age = rs.getInt("나이");
	       	  String hometown  = rs.getString("출생지");	
	       	  
	       	  int attack = rs.getInt("공격력");
	          int defence = rs.getInt("방어력");
	          int hp = rs.getInt("체력");
	          int mp = rs.getInt("마력");
	          int strenght = rs.getInt("힘");
	          
	          int intelligence = rs.getInt("지능");
	          String race  = rs.getString("종족이름");		
	          String skillname  = rs.getString("스킬이름");	
	          String alive  = rs.getString("생존여부");	
	          %>
	      
<table class="type11">
<tr>
<td width=150>ID</td>
<td width=150>PASSWORD</td>
<td width=150>이름</td>
<td width=150>나이</td>
<td width=150>출생지</td>

<td width=150>공격력</td>
<td width=150>방어력</td>
<td width=150>체력</td>
<td width=150>마력</td>
<td width=150>힘</td>

<td width=150>지능</td>
<td width=150>종족이름</td>
<td width=150>스킬이름</td>
<td width=150>생존여부</td>

</tr>
<tr>
<td width=150><%= id %></td>
<td width=150><%= password %></td>
<td width=150><%= name %></td>
<td width=150><%= age %></td>
<td width=150><%= hometown %></td>

<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= strenght %></td>

<td width=150><%= intelligence %></td>
<td width=150><%= race %></td>
<td width=150><%= skillname %></td>
<td width=150><%= alive %></td>

</tr>
</table>

	          
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

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 스킬이름,체력증가,마력증가,스킬사용여부 from 스킬 ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){

	          String skillname = rs.getString("스킬이름");
	          int hp = rs.getInt("체력증가");
	          int mp = rs.getInt("마력증가");	
	          String using  = rs.getString("스킬사용여부");	
	          %>

<table class="type11">
<tr>
<td width=150>스킬이름</td>
<td width=150>체력증가</td>
<td width=150>마력증가</td>
<td width=150>스킬사용여부</td>

</tr>
<tr>
<td width=150><%= skillname %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= using %></td>

</tr>
</table>
     
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

<% 
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 종족이름,공격력보정,방어력보정,체력보정,마력보정,힘보정,지능보정,멸망여부 from 종족 ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){

	          String name  = rs.getString("종족이름");
	       	  int attack = rs.getInt("공격력보정");
	          int defence = rs.getInt("방어력보정");
	          int hp = rs.getInt("체력보정");
	          int mp = rs.getInt("마력보정");
	          int strenght = rs.getInt("힘보정");          
	          int intelligence = rs.getInt("지능보정");
	          String alive  = rs.getString("멸망여부");	
	          %>

<form name='myForm' method='post'>


<input type="hidden" name="name" value="<%=name%>" />     

<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="hp" value="<%=hp%>" />     
<input type="hidden" name="mp" value="<%=mp%>" />
<input type="hidden" name="strenght" value="<%=strenght %>" /> 
<input type="hidden" name="intelligence" value="<%=intelligence %>" />
<input type="hidden" name="alive" value="<%=alive %>" />     

<table class="type11">
<tr>
<td width=150>종족이름</td>

<td width=150>공격력보정</td>
<td width=150>방어력보정</td>
<td width=150>체력보정</td>
<td width=150>마력보정</td>
<td width=150>힘보정</td>

<td width=150>지능보정</td>
<td width=150>멸망여부</td>

</tr>
<tr>

<td width=150><%= name %></td>

<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= strenght %></td>

<td width=150><%= intelligence %></td>
<td width=150><%= alive %></td>

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
<%
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 종족이름,공격력보정,방어력보정,체력보정,마력보정,힘보정,지능보정,멸망여부 from 종족 ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){

	          String name  = rs.getString("종족이름");
	       	  int attack = rs.getInt("공격력보정");
	          int defence = rs.getInt("방어력보정");
	          int hp = rs.getInt("체력보정");
	          int mp = rs.getInt("마력보정");
	          int strenght = rs.getInt("힘보정");          
	          int intelligence = rs.getInt("지능보정");
	          String alive  = rs.getString("멸망여부");	
	          %>

<form name='myForm' method='post'>


<input type="hidden" name="name" value="<%=name%>" />     

<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="hp" value="<%=hp%>" />     
<input type="hidden" name="mp" value="<%=mp%>" />
<input type="hidden" name="strenght" value="<%=strenght %>" /> 
<input type="hidden" name="intelligence" value="<%=intelligence %>" />
<input type="hidden" name="alive" value="<%=alive %>" />     

<table class="type11">
<tr>
<td width=150>종족이름</td>

<td width=150>공격력보정</td>
<td width=150>방어력보정</td>
<td width=150>체력보정</td>
<td width=150>마력보정</td>
<td width=150>힘보정</td>

<td width=150>지능보정</td>
<td width=150>멸망여부</td>

</tr>
<tr>

<td width=150><%= name %></td>

<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= hp %></td>
<td width=150><%= mp %></td>
<td width=150><%= strenght %></td>

<td width=150><%= intelligence %></td>
<td width=150><%= alive %></td>

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
<%
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 군단이름,병력수,총공격력,총방어력,이동력,사기 from 군단 where ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String name  = rs.getString("군단이름");
	       	  String many  = rs.getString("병력수");	
	       	  
	       	  int attack = rs.getInt("총공격력");
	          int defence = rs.getInt("총방어력");
	          int move = rs.getInt("이동력");
	          int morale = rs.getInt("사기");
	          
	          %>

<form name='myForm' method='post'>

<input type="hidden" name="name" value="<%=name%>" />     
<input type="hidden" name="many" value="<%=many%>" />   
<input type="hidden" name="attack" value="<%=attack%>" />
<input type="hidden" name="defence" value="<%=defence %>" />
<input type="hidden" name="move" value="<%=move%>" />     
<input type="hidden" name="morale" value="<%=morale%>" />


<table class="type11">
<tr>
<td width=150>군단이름</td>
<td width=150>병력수</td>
<td width=150>총공격력</td>
<td width=150>총방어력</td>
<td width=150>이동력</td>
<td width=150>사기</td>

</tr>
<tr>
<td width=150><%= name %></td>
<td width=150><%= many %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= move %></td>
<td width=150><%= morale %></td>

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
}%>
<%
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 아이템이름,종류,공격력증가,방어력증가,힘증가,지능증가,사용용사 from 아이템 ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
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

</tr>
<tr>

<td width=150><%= name %></td>
<td width=150><%= kind %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= strenght %></td>
<td width=150><%= intelligence %></td>
<td width=150><%= who %></td>

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
<%
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 장군이름,장군나이,군단공격력보정,군단방어력보정,군단이동력보정,군단사기보정,천적종족 from 장군";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
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

</tr>
<tr>
<td width=150><%= name %></td>
<td width=150><%= age %></td>
<td width=150><%= attack %></td>
<td width=150><%= defence %></td>
<td width=150><%= move %></td>
<td width=150><%= morale %></td>
<td width=150><%= race %></td>

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

<%
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select 아이디,비밀번호 from 관리자 where";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          String id  = rs.getString("아이디");
	          String password  = rs.getString("비밀번호");
	          %>

	          
<form name='myForm' method='post'>
<input type="hidden" name="id" value="<%=id%>" />
<input type="hidden" name="password" value="<%=password%>" />  

<table class="type11">
<tr>
<td width=150>ID</td>
<td width=150>PASSWORD</td>

</tr>
<tr>
<td width=150><%= id %></td>
<td width=150>****</td>

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
	pstmt.close();
	conn.close();
}
%>


<a href="logout.jsp">로그아웃</a>	




</body>
</html>