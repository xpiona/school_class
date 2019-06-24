<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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


<form method="post" action="admin_search_race_2.jsp">
 
      <SELECT name='col'> <!-- 검색 컬럼 -->

		<OPTION value='종족이름'>종족이름</OPTION>
		<OPTION value='공격력보정'>공격력보정</OPTION>
		<OPTION value='방어력보정'>방어력보정</OPTION>
		<OPTION value='체력보정'>체력보정</OPTION>
		<OPTION value='마력보정'>마력보정</OPTION>
		<OPTION value='힘보정'>힘보정</OPTION>
		<OPTION value='지능보정'>지능보정</OPTION>
		<OPTION value='멸망여부'>멸망여부</OPTION>

      </SELECT>
      
      <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
      <button type='submit'>검색</button> 
  </FORM>


<a href="logout.jsp">로그아웃</a>
</body>
</html>