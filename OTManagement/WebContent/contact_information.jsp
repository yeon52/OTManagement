<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql .*"%>
    
<!DOCTYPE html>
<html>
<head>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Baloo+Tammudu+2&display=swap" rel="stylesheet">

<link href="style.css" rel="stylesheet" type="text/css">


<meta charset="EUC-KR">
<%@ include file="navbar.jsp" %>
<title>��󿬶���</title>
</head>
<body>
<h1> ��󿬶���</h1>

<%
	String search_name = request.getParameter("search-name");
	if(search_name==null) search_name="";

%>
	<div>
		<form>
			<fieldset>
				<label> ���� : </label> <input type="text"
					name="search-name" placeholder="�˻��� �Է�" value="<%=search_name%>">
				<!-- �˻� �� �˻��� ������ ���� -->
				<input type="submit" value="�˻�">
			</fieldset>
		</form>
	</div>
<br>
<table>
<tr><th> ���� <th> �̸� <th> �̸��� <th> �޴��� ��ȣ <th> ���� </tr>

<% 
	String col = "" + request.getParameter("column");
	ResultSet rs;
	PreparedStatement stmt;
	if(search_name == ""){ 		//����Ʈ : ��� ���� ����

	stmt = conn.prepareStatement("select * from EMPLOYEES order by employee_id");
	rs = stmt.executeQuery();
	}


	else { // ���� �˻� �� 
		 stmt = conn.prepareStatement("select * from EMPLOYEES where lower(job_title) like ? order by employee_id");
		 	search_name = search_name.toLowerCase(); 
			search_name = '%'+search_name+'%';
		 	stmt.setString(1,search_name);
		    rs = stmt.executeQuery();
	}

	int i=0;
	while(rs.next()){
		String f_name=rs.getString("FIRST_NAME");
	   String l_name=rs.getString("LAST_NAME");
	   String email=rs.getString("EMAIL");
	   String phone=rs.getString("PHONE");
	   String job_title=rs.getString("JOB_TITLE");
	   
	   System.out.format("%s %s %s %s %s\n", f_name, l_name, email, phone,job_title);
	   i++;
	   %>   <tr> <td><%=i%><td><%=f_name%> <%=l_name%><td><%=email%><td> <%=phone%> <td> <%=job_title%></tr> <%
	}

rs.close();
stmt.close();
conn.close();
%>
</table>

</body>
</html>