<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>update customer</title>
</head>
<body>

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

%>
<form action="db_update.jsp" method="POST">
	ȸ��(��)�� : <input type="text" name="company" value="<%=company%>"><br><br>
	�ּ� : <input type="text" name="address" value="<%=address%>"><br><br>
	Ȩ������ : <input type="text" name="website" value="<%=website%>"><br><br>
	�ſ��Ѱ� : <input type="text" name="credit" value="<%=credit%>"><br><br>
	�̸��� : <input type="email" name="email" value="<%=email%>"><br><br>
	����ó : <input type="text" name="phone" value="<%=phone%>"><br><br>
	��ǥ�̸�(first)<input type="text" name="first_name" value="<%=first_name%>"><br><br>
	��ǥ�̸�(last)<input type="text" name="last_name" value="<%=last_name%>"><br><br>
	<input type="hidden" name="edit" value="<%=edit%>">
	<input type="hidden" name="customer_id" value=<%=customer_id %>>
	<input type="submit" value="���">

</form>
</body>
</html>