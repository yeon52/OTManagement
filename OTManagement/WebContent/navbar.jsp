<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&display=swap" rel="stylesheet">
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/5719f078e8.js"></script>
<script src="main.js" defer></script>
</head>
<body>
<%@ include file="db_connect.jsp"%>
<nav class="navbar">
        <div class="navbar__logo">
            <i class="fas fa-apple-alt"></i>
            <a href="index.jsp">OT판매점 관리 시스템</a>
        </div>
        
        <ul class="navbar__menu">
            <li><a href="customer.jsp">고객관리</a></li>
            <li><a href="product_management.jsp">제품관리</a></li>
            <li><a href="inventories.jsp">재고관리</a></li>
            <li><a href="contact_information.jsp">비상연락망</a></li>
        </ul>

		<div class="navbar__login">
		<%
		PreparedStatement stmt_ = conn.prepareStatement("select first_name, last_name from employees where employee_id=?");
		stmt_.setString(1,user_id);
		ResultSet rs_ = stmt_.executeQuery();
		while(rs_.next()){
		user = rs_.getString("first_name") +" "+rs_.getString("last_name");}
		if(user_id==null){%>
				<a href="login.jsp">로그인</a> <br><%} 
        else{%> <span style="color:#6799FF"><%=user %>님 </span> <a href="logout.jsp" style="padding-left:10px">로그아웃</a><br><% }%>
		</div>
        <a href="#" class="navbar__toggleBtn">
            <i class="fas fa-bars"></i>
        </a>
 </nav>
</body>
</html>