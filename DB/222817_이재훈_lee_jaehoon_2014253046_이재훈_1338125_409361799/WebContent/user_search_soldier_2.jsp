<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">
    // 팝업오픈하여 폼데이터 Post 전송
    function openPop(){
        var pop_title = "popupOpener" ;
        window.open("", pop_title) ;
        var frmData = document.frmData ;
        frmData.target = pop_title ;
        frmData.action = "user_calculate_soldier.jsp" ;
        frmData.submit() ;
         
    }
</script>
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
String col = request.getParameter("col");
String word = request.getParameter("word");

Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
	
			sql = "select id,password,이름,나이,출생지,공격력,방어력,체력,마력,힘,지능,종족이름,스킬이름,생존여부 from 용사 where " +col+ " = ? ";
			System.out.println(sql);
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, word);
		  	rs = pstmt.executeQuery();
		  
		  while(rs.next()){
	          int id  = rs.getInt("ID");
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
	          <h2>Here's a very simple table</h2>
<form name="frmData" id="frmData" method='post'>

<input type="hidden" name="id" value=<%=id%> />
<input type="hidden" name="password" value=<%=password%> />
<input type="hidden" name="name" value=<%=name%> />     
<input type="hidden" name="age" value=<%=age%> />
<input type="hidden" name="hometown" value=<%=hometown%> />

<input type="hidden" name="attack" value=<%=attack%> />
<input type="hidden" name="defence" value=<%=defence%> />
<input type="hidden" name="hp" value=<%=hp%> />     
<input type="hidden" name="mp" value=<%=mp%> />
<input type="hidden" name="strenght" value=<%=strenght%> /> 

<input type="hidden" name="intelligence" value=<%=intelligence%> />
<input type="hidden" name="race" value=<%=race%> />     
<input type="hidden" name="skillname" value=<%=skillname%> />
<input type="hidden" name="alive" value=<%=alive%> />     
<table class="type11">
<tr>
<td width=150>ID</td>
<td width=150>이름</td>
<td width=150>나이</td>
<td width=150>출생지</td>
<td width=150>종족이름</td>

<td width=150>스킬이름</td>
<td width=150>생존여부</td>
<td width=150>상세정보</td>
</tr>

<tr>
<td width=150><%= id %></td>
<td width=150><%= name %></td>
<td width=150><%= age %></td>
<td width=150><%= hometown %></td>
<td width=150><%= race %></td>
<td width=150><%= skillname %></td>
<td width=150><%= alive %></td>
<td width=150><a href="#" onClick="openPop();">보기</a></td>
</tr>
</table>
</form>
<a href="user_welcome.jsp">뒤로가기</a>   		          
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
















</body>
</html>