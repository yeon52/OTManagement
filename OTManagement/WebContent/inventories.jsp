<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="http://code.jquery.com/jquery-3.1.1.js"></script>
<title>������ ��ǰ ��� ��Ȳ</title>
</head>
<%@ include file="navbar.jsp" %>
<body>
	<h1>���� �� ��ǰ ��� ��Ȳ</h1>
	<%
	String selectRegion = request.getParameter("region");
	if (selectRegion == null) selectRegion = "";
	String selectCountry = request.getParameter("country");
	if (selectCountry == null) selectCountry = "";
	String selectWare = request.getParameter("warehouse");
	if (selectWare == null) selectWare = "";
	String search = request.getParameter("search");
	if (search == null) search = "";
	%>
	<!-- ������ÿ� ���� ���� �޴��� �޶����� �����޴����ÿ� ���� ������ �޶��� -->
	
	<fieldset style="display: flex; justify-content: space-between;">
	<span>
	<label for="select-region">���</label>
	<select name="select-region" id="select-region"
		onchange="selectRegion(this.value)">
		<option selected disabled hidden><---���� ���ּ���---></option>
		<%
		PreparedStatement stmt = conn.prepareStatement("select region_id, region_name from ((regions natural join countries) natural join locations) natural join warehouses group by region_id, region_name");
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			String regionID = rs.getString("region_id");
			String region = rs.getString("region_name");
			String select = "";
			if (selectRegion.equals(regionID)) select = "selected";
			%>
		<option value=<%=regionID%> <%=select %>><%=region%></option><%}
		rs.close();
		stmt.close();%>
	</select> &nbsp;
	
	<label for="select-country">����</label>
	<select name="select-country" id="select-country"
		onchange="selectCountry(this.value)">
		<option selected disabled hidden><---���� ���ּ���---></option>
		<%
		if (!selectRegion.equals("")) { //����� ���� �Ǿ�����
			PreparedStatement stmt2 = conn.prepareStatement("select country_id, country_name from (countries natural join locations) natural join warehouses where region_id=? group by country_id, country_name");
			stmt2.setString(1, selectRegion);
			ResultSet rs2 = stmt2.executeQuery();
			while (rs2.next()) {
				String countryID = rs2.getString("country_id");
				String country = rs2.getString("country_name");
				String select = "";
				if (selectCountry.equals(countryID)) select = "selected";
		%>
		<option value=<%=countryID%> <%=select %>><%=country%></option><%
		}
			rs2.close();
			stmt2.close();}
		%>
	</select>&nbsp;
	<label for="select-state">â��</label>
	<select name="select-state" id="select-state" onchange="selectWare(this.value)">
	<option selected disabled hidden><---���� ���ּ���---></option>
		
	<% if (!selectCountry.equals("")) { //������ ���� �Ǿ�����
		PreparedStatement stmt3 = conn.prepareStatement("select * from locations natural join warehouses where country_id=?");
		stmt3.setString(1, selectCountry);
		ResultSet rs3 = stmt3.executeQuery();
	
		while (rs3.next()) {
			String warehouseID = rs3.getString("warehouse_id");
			String warehouse = rs3.getString("warehouse_name");
			String select = "";
			if (selectWare.equals(warehouseID)) select = "selected";
		%>
		<option value=<%=warehouseID%> <%=select %>><%=warehouse%></option>
		<%}
		rs3.close();
		stmt3.close();}%>
	</select></span>
	<% if (!selectWare.equals("")) {%>
	<form method="post" style="display: inline;">
	<input type="text" name="search" placeholder="��ǰ�� �Է�">
	<input type="submit" value="�˻�" >
	</form></fieldset><%
		PreparedStatement stmt5 = conn.prepareStatement("select *from locations natural join warehouses where warehouse_id=?");
		stmt5.setString(1, selectWare);
		ResultSet rs5 = stmt5.executeQuery();
		while (rs5.next()) {
			String warehouseID = rs5.getString("warehouse_id");
			String warehouse = rs5.getString("warehouse_name");
	        String location = rs5.getString("city")+" "+rs5.getString("address");
	        String postcode = rs5.getString("postal_code");
	         %><br>
	 		&nbsp;&nbsp;â���ȣ : <%=warehouseID%><br>
	 		&nbsp;&nbsp;â��� : <%=warehouse%><br>
	 		&nbsp;&nbsp;�ּ� : <%=location %>, �����ȣ : <%=postcode %><br>
		<%} rs5.close();stmt5.close();%>

		<table border=1>
		<tr> <th> ��ǰ��ȣ <th> ��ǰ�з� <th> ��ǰ��  <th> �󼼿ɼ� <th> ��ǰ���� </tr>

		<%
		String sqlStr = "select *from ((warehouses natural join inventories) natural join products) natural join product_categories where warehouse_id=?";
		
		if(!search.equals("")){
			search = search.toLowerCase();
			sqlStr += " and lower(product_name) like "+"'%"+search+"%'";
		}
		sqlStr+= " order by product_id";
		PreparedStatement stmt4 = conn.prepareStatement(sqlStr);
		stmt4.setString(1, selectWare);
		ResultSet rs4 = stmt4.executeQuery();
		while (rs4.next()) {
			String productID = rs4.getString("product_id");
			String product = rs4.getString("product_name");
			String description = rs4.getString("description");
			String category = rs4.getString("category_name");
			String quantity = rs4.getString("quantity"); %>
			<tr> <td> <%=productID %> <td> <%=category %> <td> <%=product %>  <td> <%=description %> <td> <%=quantity %> </tr>
		<%}
		rs4.close();
		stmt4.close();
		}
	conn.close();
	%> 
</table>
<script>
			function selectRegion(val) {
				location.href = "?region=" + val;
			}
			function selectCountry(val) {
				var region = document.location.href.split("&");
				location.href = region[0]+"&country=" + val;
			}
			function selectWare(val) {
				var region = document.location.href.split("&");
				location.href = region[0]+"&"+region[1]+"&warehouse=" + val;
			}
</script>
</body>
</html>