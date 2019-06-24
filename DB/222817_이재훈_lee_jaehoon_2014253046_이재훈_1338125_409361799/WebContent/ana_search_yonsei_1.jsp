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
int count=0;
Connection conn = null;
PreparedStatement pstmt = null;
String sql =null;
ResultSet rs =null;
try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select count(id) from 용사";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()){
count  = rs.getInt("count(id)");
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


/*===================================================================================================================================*/

int race_number=0;
int b=0;
try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select count(종족이름) from 용사 group by 종족이름";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()){
			race_number = rs.getInt("count(종족이름)");
			b++;

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

/*===================================================================================================================================*/
int i=0;
String[] race_name = new String[b];
int[] race_count = new int[b];
try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select 종족이름,count(id) from 용사 group by 종족이름";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
for(i=0;rs.next();i++){
	race_name[i] 	= rs.getString("종족이름");
   	race_count[i]  	= rs.getInt("count(id)");
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


/*===================================================================================================================================*/
int y_attack=0;
int y_defence=0;
int i_attack=0;
int i_defence=0;

try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select sum(공격력),sum(방어력) from 용사";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()){
          y_attack  = rs.getInt("sum(공격력)");
          y_defence  = rs.getInt("sum(방어력)");
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
/*==================================================================================================================================*/
try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select sum(공격력증가),sum(방어력증가) from 아이템 where 사용용사 is not null";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()){
          i_attack  = rs.getInt("sum(공격력증가)");
          i_defence  = rs.getInt("sum(방어력증가)");
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


/*==================================================================================================================================*/
int[] race_attack = new int[10];
int[] race_defence = new int[10];
try{
conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "Dlwogns95");
sql = "select 공격력보정,방어력보정 from 종족";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
	
	for(i=0;rs.next();i++){
		 race_attack[i]  = rs.getInt("공격력보정");
         race_defence[i] = rs.getInt("방어력보정");
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

int[] mid_attack = new int[b];
int[] mid_defence = new int[b];

for(i=0;i==b;i++){
	mid_attack[i] = race_attack[i] * race_count[i];
	mid_defence[i] = race_defence[i] * race_count[i];
}
int m_attack=0;
int m_defence=0;
for(i=0;i==b;i++){
	m_attack = mid_attack[i] + m_attack;
	m_defence = mid_defence[i] + m_defence;
}


int sum_attack = y_attack + m_attack + i_attack;
int sum_defence = y_defence + m_defence + i_defence;
%>


<table class="type11">
<tr>
<td width=150>연세왕국 총 용사 수</td>
<td width=150><%=count %></td>
</tr>
<%for(i=0;i<b;i++){%>
<tr>
<td width=150><%= race_name[i] %></td>
<td width=150><%= race_count[i] %></td>
</tr>
<% }%>
<tr>
<td width=150>연세왕국 총 공격력</td>
<td width=150><%=sum_attack %></td>
</tr>
<tr>
<td width=150>연세왕국 총 방어력</td>
<td width=150><%=sum_defence %></td>
</tr>




</table>


</body>
</html>