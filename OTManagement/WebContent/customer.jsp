<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="EUC-KR">
<title>고객 정보 보기</title>
</head>
<%@ include file="navbar.jsp"%>

<h1>고객 정보</h1>
<body>
	<%
	String search_name = request.getParameter("search-name");
	String col = request.getParameter("column");
	String num_select = "";
	String amount_select = "";
	if (search_name == null) search_name = "";
	if (col==null) col="number";
	if (col.equals("number"))
		num_select = "selected";
	else if (col.equals("amount"))
		amount_select = "selected";
	%>
	<div>
		<form>
			<fieldset>
				<label>정렬</label> <select name="column"
					onchange="this.form.submit()">
					<option value="number" <%=num_select%>>구매횟수순</option>
					<option value="amount" <%=amount_select%>>총 사용금액순</option>
				</select> <br> <label>고객(회사)명 : </label> <input type="text"
					name="search-name" placeholder="검색어 입력" value="<%=search_name%>">
				<!-- 검색 후 검색어 유지를 위함 -->
				<input type="submit" value="검색">
			</fieldset>
		</form>
	</div>
	<br>
	<button onclick="location.href='customer_update.jsp?edit=add'">추가</button>
	<table class="customer__table">
		<tr>
		<th>순번
			<th>회사명
			<th>주소
			<th>홈페이지
			<th>신용한계
			<th>대표
			<th>이메일
			<th>연락처
			<th>구매 정보
			<th>구매 횟수
			<th>총액($)
			<th>수정
		</tr>

		<%
		String sqlStr = "select c.customer_id as id, sum(unit_price), count(*), name from (customers c left outer join orders o on c.customer_id=o.customer_id)left outer join order_items oi on o.order_id=oi.order_id group by c.customer_id, name";
		String sql = "select * from (";
		ResultSet rs;
		PreparedStatement stmt;
		if (search_name == "") { //디폴트 : 모든회사 나열
			if (col.equals("number")) {
				sqlStr += " order by count(*) desc";
			} else if (col.equals("amount")) {
				sqlStr += " order by sum(unit_price) desc nulls last";
			}

			stmt = conn.prepareStatement(sqlStr);
			rs = stmt.executeQuery();
			
		}
	
		else { //회사명 검색 시 
			search_name = search_name.toLowerCase();
			search_name = "'%" + search_name + "%'";

			if (col.equals("number")) {
				sqlStr += " order by count(*) desc";
			} else if (col.equals("amount")) {
				sqlStr += " order by sum(unit_price) desc nulls last";
			}

			sqlStr = sql + sqlStr + ")where lower(name) like " + search_name;

			stmt = conn.prepareStatement(sqlStr);
			rs = stmt.executeQuery();
			
		}

		while (rs.next()) {
			int i = rs.getRow();
			String company = rs.getString("name");
			String id = rs.getString("id");
			String count = rs.getString("count(*)");
			count = String.valueOf(Integer.parseInt(count)-1);
			String sum = rs.getString("sum(unit_price)");
			
			if(count.equals("0")) sum="0";
			PreparedStatement stmt2 = conn.prepareStatement("select *from customers natural join contacts where customer_id = ?");
			stmt2.setString(1,id);
			ResultSet rs2 = stmt2.executeQuery();
			
			while(rs2.next()){
			String address = rs2.getString("address");
			String website = rs2.getString("website");
			String credit = rs2.getString("credit_limit");
			String email = rs2.getString("email");
			String phone = rs2.getString("phone");
			String first_name = rs2.getString("first_name");
			String last_name = rs2.getString("last_name");
			String master =  first_name + " " + last_name;
		%>
		<tr>
			<td><%=i %>
			<td><%=company%>
			<td><%=address%>
			<td><%=website%>
			<td><%=credit%>
			<td><%=master%>
			<td><%=email%>
			<td><%=phone%>
			<td><a class="link" href="purchase.jsp?company=<%=company%>">조회</a>
			<td><%=count%>
			<td><%=sum%>
			<td>
			<form action="customer_update.jsp" method="POST">
				<input type="hidden" name="customer_id" value="<%=id%>">
				<input type="hidden" name="company" value="<%=company%>">
				<input type="hidden" name="address" value="<%=address%>">
				<input type="hidden" name="website" value="<%=website%>">
				<input type="hidden" name="credit" value="<%=credit%>">
				<input type="hidden" name="email" value="<%=email%>">
				<input type="hidden" name="phone" value="<%=phone%>">
				<input type="hidden" name="first_name" value="<%=first_name%>">
				<input type="hidden" name="last_name" value="<%=last_name%>">
				<input type="hidden" name="edit" value="update">
				<input type="submit" value="수정">
			</form>
			
			<form action="db_update.jsp" method="POST">
				<input type="hidden" name="customer_id" value="<%=id%>">
				<input type="hidden" name="edit" value="delete">
				<input type="submit" value="삭제">
			</form>
		</tr>
		<%
		}
		rs2.close();
		stmt2.close();}
		rs.close();
		stmt.close();
		conn.close();
		%>
	</table>
</body>
</html>