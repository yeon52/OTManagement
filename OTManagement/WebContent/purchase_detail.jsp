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
<title>주문 상세내역 조회</title>
</head>
<%@ include file="navbar.jsp" %>
<br>
<h2>&nbsp;주문 상세내역 조회</h2>

<%String orderID = request.getParameter("orderID"); %>
<body>
<% 
	PreparedStatement stmt = conn.prepareStatement("select *from orders natural join customers where order_id=?");
    stmt.setString(1,orderID);
    ResultSet rs = stmt.executeQuery();
    while(rs.next()){
    String status = rs.getString("status");
    String orderDate = rs.getString("order_date").split(" ")[0];
    String address = rs.getString("address");
    if(status.equals("Shipped")) status = "배송 완료";
	else if(status.equals("Cancled")) status = "주문 취소";
	else if(status.equals("Pending")) status="보류";
	String salesman_id = rs.getString("salesman_id");
	String salesMan="X";
    if(salesman_id != null){
    	PreparedStatement stmt3 = conn.prepareStatement("select *from employees where employee_id = ?");
        stmt3.setString(1,salesman_id);
        ResultSet rs3 = stmt3.executeQuery();
        while(rs3.next()){
            salesMan=rs3.getString("first_name")+" "+rs3.getString("last_name")+", "+rs3.getString("phone");
        }
        rs3.close();
        stmt3.close();
    }
	%><br>
	<p>주문번호 : <%=orderID%>&nbsp;&nbsp;주문날짜 : <%=orderDate %>&nbsp;&nbsp;주문상태 : <%=status %> <br>
	배송지 : <%=address %><br>
	판매사원 : <%=salesMan %><br></p> <%
    }
    rs.close();
    stmt.close();
%>
<table>
<tr> <th> 상품 분류 <th> 제품명 <th> 상세 옵션  <th> 원가 <th> 정가 <th> 구매수량 </tr>

<%
	PreparedStatement stmt2 = conn.prepareStatement("select * from (order_items natural join products) natural join product_categories where order_id=?");
    stmt2.setString(1,orderID);
    ResultSet rs2 = stmt2.executeQuery();
    double sum_price = 0;
	while(rs2.next()){
		String category = rs2.getString("category_name");
		String product = rs2.getString("product_name");
		String description = rs2.getString("description");
		String standardCost = rs2.getString("standard_cost");
		double unitPrice = rs2.getDouble("unit_price");
		int quantity = rs2.getInt("quantity");
		sum_price += unitPrice*quantity;
		%> <tr> <td> <%= category %> <td> <%=product%> <td><%=description %><td> <%=standardCost%> <td> <%=unitPrice %> <td> <%=quantity %></tr> <%
	}
	rs2.close(); stmt.close(); conn.close();
%>
</table>
<p style="text-align:center;">주문 금액 합계 : <%=sum_price %>$</p><br>
</body>
</html>
