<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="EUC-KR">
<title>�� ���� ����</title>
</head>
<%@ include file="navbar.jsp"%>

<h1>�� ����</h1>
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
				<label>����</label> <select name="column"
					onchange="this.form.submit()">
					<option value="number" <%=num_select%>>����Ƚ����</option>
					<option value="amount" <%=amount_select%>>�� ���ݾ׼�</option>
				</select> <br> <label>��(ȸ��)�� : </label> <input type="text"
					name="search-name" placeholder="�˻��� �Է�" value="<%=search_name%>">
				<!-- �˻� �� �˻��� ������ ���� -->
				<input type="submit" value="�˻�">
			</fieldset>
		</form>
	</div>
	<br>
	<button onclick="location.href='customer_update.jsp?edit=add'">�߰�</button>
	<table class="customer__table">
		<tr>
		<th>����
			<th>ȸ���
			<th>�ּ�
			<th>Ȩ������
			<th>�ſ��Ѱ�
			<th>��ǥ
			<th>�̸���
			<th>����ó
			<th>���� ����
			<th>���� Ƚ��
			<th>�Ѿ�($)
			<th>����
		</tr>

		<%
		String sqlStr = "select c.customer_id as id, sum(unit_price), count(*), name from (customers c left outer join orders o on c.customer_id=o.customer_id)left outer join order_items oi on o.order_id=oi.order_id group by c.customer_id, name";
		String sql = "select * from (";
		ResultSet rs;
		PreparedStatement stmt;
		if (search_name == "") { //����Ʈ : ���ȸ�� ����
			if (col.equals("number")) {
				sqlStr += " order by count(*) desc";
			} else if (col.equals("amount")) {
				sqlStr += " order by sum(unit_price) desc nulls last";
			}

			stmt = conn.prepareStatement(sqlStr);
			rs = stmt.executeQuery();
			
		}
	
		else { //ȸ��� �˻� �� 
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
			<td><a class="link" href="purchase.jsp?company=<%=company%>">��ȸ</a>
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
				<input type="submit" value="����">
			</form>
			
			<form action="db_update.jsp" method="POST">
				<input type="hidden" name="customer_id" value="<%=id%>">
				<input type="hidden" name="edit" value="delete">
				<input type="submit" value="����">
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