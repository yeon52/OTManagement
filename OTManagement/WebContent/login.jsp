<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login</title>
</head>
<body>
<% 
	String userID = request.getRemoteUser();
	if(userID!=null){
%>
	<script>
		alert("환영합니다 !");
		location.href="index.jsp";
	</script>
	<%} %>
	<%@ include file="navbar.jsp" %><br><br>
	<div style="text-align: center;">
	<h2>로그인</h2>
	<form action="j_security_check" method=POST>
	&nbsp;&nbsp;&nbsp;ID : <input type="text" name="j_username"/><br><br>
	PWD : <input type="password" name="j_password"/><br><br>
	<input type="submit" value="로그인"/>

	</form>
	</div>
</body>
</html>