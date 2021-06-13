<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&display=swap" rel="stylesheet">

<link href="style.css" rel="stylesheet" type="text/css">


<meta charset="EUC-KR">
<title>���ų���</title>
</head>
<%@ include file="navbar.jsp" %>
<br>
<body>
<%String company = request.getParameter("company"); %>
<h2><%=company %>�� ���ų���</h2>
<table>
<tr> <th> �ֹ���ȣ <th> �ֹ���¥ <th>���Ż�ǰ <th> �ֹ����� <th> �󼼳��� </tr>

<%
	PreparedStatement stmt = conn.prepareStatement("select *from orders natural join customers where name = ? order by order_date desc");
    stmt.setString(1,company);
    ResultSet rs = stmt.executeQuery();
	
	while(rs.next()){
		String orderID = rs.getString("order_id");
		String orderDate = rs.getString("order_date");
		String status = rs.getString("status");
		String salesMan = rs.getString("salesman_id");
		
		if(status.equals("Shipped")) status = "��� �Ϸ�";
		else if(status.equals("Canceled")) status = "�ֹ� ���";
		else if(status.equals("Pending")) status="����";
		
		PreparedStatement stmt2 = conn.prepareStatement("select * from order_items natural join products where order_id=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    stmt2.setString(1,orderID);
	    ResultSet rs2 = stmt2.executeQuery();
		rs2.last();
		int num = rs2.getRow(); 
		String product = rs2.getString("product_name");
		String product_inform;
		if (num>1) product_inform = "\'" + product + "\'" + "�� "+ Integer.toString(num-1) + "��";
		else product_inform = product;
		%> <tr> <td> <%= orderID %> <td> <%=orderDate%> <td><%=product_inform %><td> <%=status%> <td> <a href="purchase_detail.jsp?orderID=<%=orderID%>" class="link">��ȸ</a> </tr> <%
	rs2.close(); stmt2.close();}
	rs.close(); stmt.close(); conn.close();
%>
</table>
</body>
</html>