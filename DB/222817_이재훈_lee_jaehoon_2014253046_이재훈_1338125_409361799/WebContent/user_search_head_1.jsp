<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
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


<form method="post" action="user_search_head_2.jsp">
 
      <SELECT name='col'> <!-- 검색 컬럼 -->
		<OPTION value='장군이름'>장군이름</OPTION>
		<OPTION value='장군나이'>장군나이</OPTION>
		<OPTION value='군단공격력보정'>군단공격력보정</OPTION>
		<OPTION value='군단방어력보정'>군단방어력보정</OPTION>
		<OPTION value='군단이동력보정'>군단이동력보정</OPTION>
		<OPTION value='군단사기보정'>군단사기력보정</OPTION>
		<OPTION value='천적종족'>천적종족</OPTION>
      </SELECT>
      
      <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
      <button type='submit'>검색</button> 
  </FORM>




</body>
</html>