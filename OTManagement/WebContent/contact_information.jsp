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
<title>비상연락망</title>
</head>
<body>
<h1> 비상연락망</h1>

<%
	String search_name = request.getParameter("search-name");
	if(search_name==null) search_name="";

%>
	<div>
		<form>
			<fieldset>
				<label> 직급 : </label> <input type="text"
					name="search-name" placeholder="검색어 입력" value="<%=search_name%>">
				<!-- 검색 후 검색어 유지를 위함 -->
				<input type="submit" value="검색">
			</fieldset>
		</form>
	</div>
<br>
<table>
<tr><th> 순번 <th> 이름 <th> 이메일 <th> 휴대폰 번호 <th> 직급 </tr>

<% 
	String col = "" + request.getParameter("column");
	ResultSet rs;
	PreparedStatement stmt;
	if(search_name == ""){ 		//디폴트 : 모든 직원 나열

	stmt = conn.prepareStatement("select * from EMPLOYEES order by employee_id");
	rs = stmt.executeQuery();
	}


	else { // 직급 검색 시 
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