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
	<h2>�α���</h2><br>
<% 
	String userID = request.getRemoteUser();
	if(userID!=null){
%>
	<script>
		alert("ȯ���մϴ� !");
		location.href="index.jsp";
	</script>
	<%} %>
	<div class="login">
		<form action="j_security_check" method=POST><br>
		<p>ID : <input type="text" name="j_username"/></p>
		<p>PWD : <input type="password" name="j_password"/></p><br>
		<p style="text-align:center; margin-left:100px"><input type="submit" value="�α���"/></p>
	
		</form>
	</div>
</body>
</html>