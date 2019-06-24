<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

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
       <meta charset="UTF-8">
        <title> DB_Trip </title>

    </head>
   <body >
       <form action="admin_authentication.jsp" method="post">
       
        <h2>관리자 로그인!!</h2>
        
        <table class="type11">
        	<tr>
            	<td width=150>ID: </td>
            	<td width=150><input name="id" type="text"><br></td>
            </tr> 
            <tr>
            	<td width=150>PW: </td>
            	<td width=150><input name="password" type="password"><br></td>
            </tr>
            </table>
            <input type="submit" value="로그인">
         </form>
    
    
        <form action="user_authentication.jsp" method="post">
        <h2>일반사용자 로그인!!</h2>
        <table class="type11" >
        	<tr>
            	<td width=150>ID: </td>
            	<td width=150><input name="id" type="text"><br></td>
            </tr> 
            <tr>
            	<td width=150>PW: </td>
            	<td width=150><input name="pw" type="password"><br></td>
            </tr>
            </table>
            <input type="submit" value="로그인">
         </form>
         
         <form action="ana_welcome.jsp" method="post">
        <h2>전투분석가 로그인!!</h2>
            <input type="submit" value="로그인">
         </form>
         
         
    </body>
</html>
