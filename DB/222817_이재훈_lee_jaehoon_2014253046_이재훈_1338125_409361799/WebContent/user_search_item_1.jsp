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


<form method="post" action="user_search_item_2.jsp">
 
      <SELECT name='col'> <!-- 검색 컬럼 -->
		<OPTION value='아이템이름'>이름</OPTION>
		<OPTION value='종류'>종류</OPTION>
		
		<OPTION value='공격력증가'>공격력증가</OPTION>
		<OPTION value='방어력증가'>방어력증가</OPTION>

		<OPTION value='힘증가'>힘증가</OPTION>
		<OPTION value='지능증가'>지능증가</OPTION>
		<OPTION value='사용용사'>사용용사</OPTION>
      </SELECT>
      
      <input type='text' name='word' value='' placeholder="특수문자는 사용할수 없습니다.">
      <button type='submit'>검색</button> 
  </FORM>




</body>
</html>