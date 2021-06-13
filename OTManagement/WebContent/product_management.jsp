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
<title>��ǰ ����</title>
</head>
<%@ include file="navbar.jsp" %>
<body>
<h1>��ǰ ����</h1>
<%
String search_name = request.getParameter("search-name");
String column = "" + request.getParameter("column");
String c_select="";
String item_select="";
if(search_name==null) search_name="";
if (column.equals("categories")) c_select = "selected";
else if(column.equals("item_name")) item_select = "selected";
%>

<div>
      <form>
         <fieldset>
            <label>�˻��з�</label>
            
             <select name="column">
               <option value="categories" <%=c_select %>>ǰ��</option>
               <option value="item_name" <%=item_select %>>��ǰ��</option>
            </select> 
            
            <label>�˻���</label> 
            <input type="text" name="search-name" placeholder="�˻��� �Է�" value="<%=search_name%>">
            <input type="submit" value="�˻�">
         </fieldset>
      </form>
   </div>
<br>
<table>
      <tr> <th> �Ǹż��� <th> ī�װ� <th> ��ǰ�� <th> �� ����<th> ǥ�� ����  <th> ���� <th> �Ǹŷ�</tr>
<%
   String col=""+request.getParameter("column");
   ResultSet rs;

   PreparedStatement stmt2 = conn.prepareStatement("select product_id, sum(quantity) as total_q from products natural join order_items group by product_id order by total_q desc");
   ResultSet rs2 = stmt2.executeQuery();
   
   String sqlStr="select category_name, product_name, description, standard_cost, list_price from products natural join product_categories where product_id = ?";
   search_name = search_name.toLowerCase();
   search_name = "'%"+search_name+"%'";
   if(col.equals("categories")){
   	sqlStr+=" and lower(category_name) like "+search_name;
   }
   else if(col.equals("item_name")){
   	sqlStr+=" and lower(product_name) like "+search_name;
   }
   while(rs2.next()){
	int i = rs2.getRow();
	String productID = rs2.getString("product_id");
	String total_quantity = rs2.getString("total_q");
    
    PreparedStatement stmt = conn.prepareStatement(sqlStr);
    stmt.setString(1,productID);
    rs = stmt.executeQuery();
    while (rs.next()) {
    	String category_name = rs.getString("category_name");
        String product_name = rs.getString("product_name");
        String description = rs.getString("description");
        String standard_cost = rs.getString("standard_cost");
        String list_price = rs.getString("list_price");
  %>
  <tr><td><%=i%><td><%=category_name%><td><%=product_name%><td><%=description%><td><%=standard_cost%><td><%=list_price%><td> <%=total_quantity %></tr>
  <%
   }
    rs.close(); stmt.close();
  }rs2.close(); stmt2.close();conn.close();
%>
</table>
</body>
</html>