<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>update customer</title>
</head>
<body>
<%@ include file="navbar.jsp"%>
<%
String edit = request.getParameter("edit");
if (edit == null) edit = "";
String company = request.getParameter("company");
if (company == null) company = "";
String address = request.getParameter("address");
if (address == null) address = "";
String website = request.getParameter("website");
if (website == null) website = "";
String credit = request.getParameter("credit");
if (credit == null) credit = "";
String email = request.getParameter("email");
if (email == null) email = "";
String phone = request.getParameter("phone");
if (phone == null) phone = "";
String first_name = request.getParameter("first_name");
if (first_name == null) first_name = "";
String last_name = request.getParameter("last_name");
if (last_name == null) last_name = "";
String customer_id = request.getParameter("customer_id");
if (customer_id == null) customer_id = "";

if(edit.equals("add"))
	%><h1>고객 추가</h1><%
else if(edit.equals("update"))
	%><h1>고객 정보 수정</h1><%
%>
<div class="form">
<form action="db_update.jsp" method="POST">
	<p>회사(고객)명 : <input type="text" name="company" value="<%=company%>"></p>
	<p>주소 : <input type="text" name="address" value="<%=address%>"></p>
	<p>홈페이지 : <input type="text" name="website" value="<%=website%>"></p>
	<p>신용한계 : <input type="text" name="credit" value="<%=credit%>"></p>
	<p>이메일 : <input type="email" name="email" value="<%=email%>"></p>
	<p>연락처 : <input type="text" name="phone" value="<%=phone%>"></p>
	<p>대표이름(first) : <input type="text" name="first_name" value="<%=first_name%>"></p>
	<p>대표이름(last) : <input type="text" name="last_name" value="<%=last_name%>"></p>
	<input type="hidden" name="edit" value="<%=edit%>">
	<input type="hidden" name="customer_id" value=<%=customer_id %>><br>
	<p style="text-align:center;"><input type="submit" value="등록"></p>
</form>
</div>
</body>
</html>