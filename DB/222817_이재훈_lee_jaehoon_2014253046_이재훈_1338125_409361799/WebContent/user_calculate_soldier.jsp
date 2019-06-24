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
<script>
function mySubmit(index){
	if(index==1){
		document.myForm.action='user_foreign_race.jsp';}
	if(index==2){
		document.myForm.action='user_foreign_skill.jsp';}
	if(index==3){
		document.myForm.action='user_foreign_item.jsp';}	
	document.myForm.submit();
}
</script>
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
	System.out.println("넘어온hp");
	System.out.println(hp);
	int mp = Integer.parseInt(request.getParameter("mp"));
	int strenght = Integer.parseInt(request.getParameter("strenght"));
	
	int intelligence = Integer.parseInt(request.getParameter("intelligence"));
	String race = request.getParameter("race");
	String skillname = request.getParameter("skillname");
	String alive = request.getParameter("alive");
	
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql =null;
	ResultSet rs =null;
	int r_attack=0;
	int r_defence=0;
	int r_hp=0;
	int r_mp=0;
	int r_strenght=0;
	int r_intelligence=0;
	int s_hp=0;
	int s_mp=0;
	int i_attack=0;
	int i_defence=0;
	int i_strenght=0;
	int i_intelligence=0;
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
		
				sql = "select 공격력보정,방어력보정,체력보정,마력보정,힘보정,지능보정 from 종족 where 종족이름 = ? ";
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,race);
			  	rs = pstmt.executeQuery();
			  
			  while(rs.next()){
		          	r_attack  = rs.getInt("공격력보정");
		          	r_defence  = rs.getInt("방어력보정");
		          	r_hp  = rs.getInt("체력보정");
		          	System.out.println("종족hp");
		        	System.out.println(r_hp);
		          	r_mp  = rs.getInt("마력보정");
		          	r_strenght  = rs.getInt("힘보정");
		          	r_intelligence  = rs.getInt("지능보정");
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
		
				sql = "select 체력증가,마력증가 from 스킬 where 스킬이름 = ? ";
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,skillname);
			  	rs = pstmt.executeQuery();
			  
			  while(rs.next()){
		          	s_hp  = rs.getInt("체력증가");
		          	System.out.println("스킬hp");
		        	System.out.println(s_hp);
		          	s_mp  = rs.getInt("마력증가");
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
int count=0;
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
				sql = "select count(아이템이름) from 아이템  where 사용용사 = ? ";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,id);
			  	rs = pstmt.executeQuery();
			  	
			  while(rs.next()){
		          	count   = rs.getInt("count(아이템이름)");
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
				sql = "select sum(공격력증가),sum(방어력증가),sum(힘증가),sum(지능증가) from 아이템  where 사용용사 = ? ";
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,id);
			  	rs = pstmt.executeQuery();
			  	
			  while(rs.next()){
		          	i_attack   = rs.getInt("sum(공격력증가)");
		          	i_defence  = rs.getInt("sum(방어력증가)");
		          	i_strenght   = rs.getInt("sum(힘증가)");
		          	i_intelligence  = rs.getInt("sum(지능증가)");
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
<form name='myForm' method='post'>
<input type="hidden" name="race" value="<%=race%>" />
<input type="hidden" name="skillname" value="<%=skillname%>" />
<input type="hidden" name="id" value="<%=id%>" />     


<table class="type11">
<tr>
<td width=150>	</td>
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
<td width=150>초기보정치</td>
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

<tr>
<td width=150><input type="button" value="종족보정치" onclick='mySubmit(1)' /></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150><%= r_attack %></td>
<td width=150><%= r_defence %></td>
<td width=150><%= r_hp %></td>
<td width=150><%= r_mp %></td>
<td width=150><%= r_strenght %></td>
<td width=150><%= r_intelligence %></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
</tr>

<tr>
<td width=150><input type="button" value="스킬보정치" onclick='mySubmit(2)' /></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>

<td width=150></td>
<td width=150></td>
<td width=150><%= s_hp %></td>
<td width=150><%= s_mp %></td>
<td width=150></td>

<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
</tr>

<tr>
<td width=150><input type="button" value="아이템보정치" onclick='mySubmit(3)' /></td>
<td width=150>아이템<%=count%>개 사용</td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>

<td width=150><%= i_attack %></td>
<td width=150><%= i_defence %></td>
<td width=150></td>
<td width=150></td>
<td width=150><%= i_strenght %></td>

<td width=150><%= i_intelligence %></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
</tr>
<%
int f_attack	=attack+r_attack+i_attack;
int f_defence	=defence+r_defence+i_defence;
int f_hp		=hp+r_hp+s_hp;
int f_mp		=mp+r_mp+s_mp;
int f_strenght	=strenght+r_strenght+i_strenght;
int f_intelligence=intelligence+r_intelligence+i_intelligence;
%>
<tr>
<td width=150>최종보정치</td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>

<td width=150><%= f_attack %></td>
<td width=150><%= f_defence %></td>
<td width=150><%= f_hp%></td>
<td width=150><%= f_mp%></td>
<td width=150><%= f_strenght %></td>
<td width=150><%= f_intelligence %></td>
<td width=150></td>
<td width=150></td>
<td width=150></td>
</tr>
</table>
</form>
</body>
</html>