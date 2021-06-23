<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login</title>
</head>
<body>
<%@ include file="navbar.jsp" %><br>
	<h2>로그인</h2><br>
<% 
	String userID = request.getRemoteUser();
	if(userID!=null){
%>
	<script>
		alert("환영합니다 !");
		location.href="index.jsp";
	</script>
	<%} %>
	<div class="login">
		<form action="j_security_check" method=POST><br>
		<p>ID : <input type="text" name="j_username"/></p>
		<p>PWD : <input type="password" name="j_password"/></p><br>
		<p style="text-align:center; margin-left:100px"><input type="submit" value="로그인"/></p>
	
		</form>
	</div>
</body>
</html>