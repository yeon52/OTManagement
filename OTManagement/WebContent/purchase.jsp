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
<title>구매내역</title>
</head>
<%@ include file="navbar.jsp" %>
<br>
<body>
<%String company = request.getParameter("company"); %>
<h2><%=company %>의 구매내역</h2>
<table>
<tr> <th> 주문번호 <th> 주문날짜 <th>구매상품 <th> 주문상태 <th> 상세내역 </tr>

<%
	PreparedStatement stmt = conn.prepareStatement("select *from orders natural join customers where name = ? order by order_date desc");
    stmt.setString(1,company);
    ResultSet rs = stmt.executeQuery();
	
	while(rs.next()){
		String orderID = rs.getString("order_id");
		String orderDate = rs.getString("order_date");
		String status = rs.getString("status");
		String salesMan = rs.getString("salesman_id");
		
		if(status.equals("Shipped")) status = "배송 완료";
		else if(status.equals("Canceled")) status = "주문 취소";
		else if(status.equals("Pending")) status="보류";
		
		PreparedStatement stmt2 = conn.prepareStatement("select * from order_items natural join products where order_id=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    stmt2.setString(1,orderID);
	    ResultSet rs2 = stmt2.executeQuery();
		rs2.last();
		int num = rs2.getRow(); 
		String product = rs2.getString("product_name");
		String product_inform;
		if (num>1) product_inform = "\'" + product + "\'" + "외 "+ Integer.toString(num-1) + "건";
		else product_inform = product;
		%> <tr> <td> <%= orderID %> <td> <%=orderDate%> <td><%=product_inform %><td> <%=status%> <td> <a href="purchase_detail.jsp?orderID=<%=orderID%>" class="link">조회</a> </tr> <%
	rs2.close(); stmt2.close();}
	rs.close(); stmt.close(); conn.close();
%>
</table>
</body>
</html>