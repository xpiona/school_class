<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import = "test.DBConnection" %>

<%

Connection conn = null;                                        // null로 초기화 한다.
String url = "jdbc:oracle:thin:@localhost:1521:orcl";        // 사용하려는 데이터베이스명을 포함한 URL 기술
String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver"; 
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String redirectUrl = "form.jsp";

try{
conn = DBConnection.getconn(id,pw);
System.out.println("연결완료");
session.setAttribute("signedUser", id); // 인증되었음 세션에 남김
conn.close();
redirectUrl = "user_welcome.jsp"; // 인증 성공 시 재요청 url
}

catch(Exception e){
	   e.printStackTrace();
	}

response.sendRedirect(redirectUrl);

%>