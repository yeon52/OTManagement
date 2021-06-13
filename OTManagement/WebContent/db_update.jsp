<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%@ include file="db_connect.jsp"%>
<%
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
	String edit = request.getParameter("edit");
	if (edit == null) edit = "";
	String customer_id = request.getParameter("customer_id");
	if (customer_id == null) customer_id = "";
	
	if(edit.equals("add")){
		
		PreparedStatement stmt = conn.prepareStatement("select * from customers order by customer_id",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
		if(rs.isLast()){
		int id = Integer.parseInt(rs.getString("customer_id"));
		System.out.println(id);
		PreparedStatement stmt2 = conn.prepareStatement("Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (?,?,?,?,?)");
		stmt2.setInt(1,id+1);
		stmt2.setString(2,company);
		stmt2.setString(3,address);
		stmt2.setInt(4,Integer.parseInt(credit));
		stmt2.setString(5,website);
		stmt2.executeUpdate();
		
		PreparedStatement stmt3 = conn.prepareStatement("Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (?,?,?,?,?,?)");
		stmt3.setInt(1,id+1);
		stmt3.setString(2,first_name);
		stmt3.setString(3,last_name);
		stmt3.setString(4,email);
		stmt3.setString(5,phone);
		stmt3.setInt(6,id+1);
		stmt3.executeUpdate();
		%>
			<script>
			alert("추가되었습니다.");
			location.href="customer.jsp";
			</script>
		<%
		stmt2.close(); stmt3.close();}
		}
		conn.commit();
		rs.close();
		stmt.close(); 
		conn.close();
	}
	else if(edit.equals("delete")){
		PreparedStatement stmt = conn.prepareStatement("delete customers where customer_id = ?");
		stmt.setString(1,customer_id);
		stmt.executeUpdate();
		
		PreparedStatement stmt2 = conn.prepareStatement("delete contacts where customer_id = ?");
		stmt2.setString(1,customer_id);
		stmt2.executeUpdate();
		
		%>
		<script>
		alert("삭제되었습니다.");
		location.href="customer.jsp";
		</script>
	<%
	stmt.close();
	stmt2.close();
	conn.close();
	}
	else if(edit.equals("update")){
	      PreparedStatement stmt = conn.prepareStatement("update customers set name=?, address=?, credit_limit=?, website=? where customer_id=?");
	      stmt.setString(1,company);
	      stmt.setString(2,address);
	      stmt.setString(3,credit);
	      stmt.setString(4,website);
	      stmt.setString(5,customer_id);
	      stmt.executeUpdate();
	      
	      PreparedStatement stmt2 = conn.prepareStatement("update contacts set first_name=?, last_name=?, email=?, phone=? where customer_id=?");
	      stmt2.setString(1,first_name);
	      stmt2.setString(2,last_name);
	      stmt2.setString(3,email);
	      stmt2.setString(4,phone);
	      stmt2.setString(5,customer_id);
	      stmt2.executeUpdate();
	      
	      %>
	      <script>
	      alert("수정이 완료되었습니다.");
	      location.href = "customer.jsp";
	      </script>
	      <%
	    stmt.close();
	  	stmt2.close();
		conn.close();
	   }
%>
</body>
</html>