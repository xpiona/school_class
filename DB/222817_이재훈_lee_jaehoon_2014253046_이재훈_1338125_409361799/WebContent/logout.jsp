<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<html>
<body>

</body>
</html>

<%
  	session.invalidate();
    response.sendRedirect("form.jsp");
%>