<%@ page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>


<%
	final int ROWSIZE = 4;
	final int BLOCK = 5;

	int pg = 1;

	if (request.getParameter("pg") != null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}

	int start = (pg * ROWSIZE) - (ROWSIZE - 1);
	int end = (pg * ROWSIZE);

	int allPage = 0;

	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1;
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mojuk?characterEncoding=utf8&amp;useSSL=false&amp;autoReconnection=true";
		String id = "root";
		String pass = "1234";
		try {
			Connection conn = DriverManager.getConnection(url, id, pass);
			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();

			String sql = "";
			int total = 0;
			String SQL = "select count(*) from notice";
			ResultSet rs = stmt.executeQuery(SQL);

			if (rs.next()) {
				total = rs.getInt(1);
			}

			int sort = 1;
			String sqlSort = "SELECT ID from notice order by ref desc, step asc";
			rs = stmt.executeQuery(sqlSort);

			while (rs.next()) {
				int stepNum = rs.getInt(1);
				sql = "UPDATE notice SET STEP=" + sort + " where ID=" + stepNum;
				stmt1.executeUpdate(sql);
				sort++;
			}

			allPage = (int) Math.ceil(total / (double) ROWSIZE);

			if (endPage > allPage) {
				endPage = allPage;
			}

			out.print("총 게시물 : " + total + "개");

			String sqlList = "SELECT ID, USERNAME, TITLE, TIME, HIT, INDENT from notice where STEP >=" + start
					+ " and STEP <= " + end + " order by step asc";
			rs = stmt.executeQuery(sqlList);
	%>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr height="5">
			<td width="5"></td>
		</tr>
		<tr
			style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
			<td width="5"><img src="img/table_left.gif" width="5"
				height="30" /></td>
			<td width="73">번호</td>
			<td width="379">제목</td>
			<td width="73">작성자</td>
			<td width="163">작성일</td>
			<td width="58">조회수</td>
			<td width="7"><img src="img/table_right.gif" width="5"
				height="30" /></td>
		</tr>

		<%
			if (total == 0) {
		%>
		<tr align="center" bgcolor="#FFFFFF" height="30">
			<td colspan="6">등록된 글이 없습니다.</td>
		</tr>
		<%
			} else {
					while (rs.next()) {
						int idx = rs.getInt(1);
						String name = rs.getString(2);
						String title = rs.getString(3);
						String time = rs.getString(4);
						int hit = rs.getInt(5);
						int indent = rs.getInt(6);

						Date date = new Date();
						SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
						String year = (String) simpleDate.format(date);
						String yea = time.substring(0, 10);
		%>
		<tr height="25" align="center">
			<td>&nbsp;</td>
			<td><%=idx%></td>
			<td align="left">
				<%
					for (int j = 0; j < indent; j++) {
				%> &nbsp;&nbsp;&nbsp;<%
 	}
 				if (indent != 0) {
 %> <img src='img/reply_icon.gif' /> <%
 	}
 %> <a href="notice/Board_View.jsp?idx=<%=idx%>"><%=title%></a> <%
 	if (year.equals(yea)) {
 %> <img src='img/new.jpg' /> <%
 	}
 %>
			</td>
			<td align="center"><%=name%></td>
			<td align="center"><%=time%></td>
			<td align="center"><%=hit%></td>
			<td>&nbsp;</td>
		</tr>

		<tr height="1" bgcolor="#D2D2D2">
			<td colspan="6"></td>
		</tr>
		<%
			}
				}
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				out.print(e.toString());
			}
		%>
		<tr height="1" bgcolor="#82B5DF">
			<td colspan="6" width="752"></td>
		</tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		<td align="center">
			<%
				if (pg > BLOCK) {
			%> [ <a href="notice.jsp?pg=1">◀◀</a>] [ <a
			href="notice.jsp?pg=<%=startPage - 1%>">◀</a>] <%
				}
			%> <%
 	for (int i = startPage; i <= endPage; i++) {
 		if (i == pg) {
 %> <u><b>[<%=i%>]
			</b></u> <%
 	} else {
 %> [ <a href="notice.jsp?pg=<%=i%>"><%=i%></a>] <%
 	}
 	}
 %> <%
 	if (endPage < allPage) {
 %> [ <a href="notice.jsp?pg=<%=endPage + 1%>">▶</a>] [ <a
			href="notice.jsp?pg=<%=allPage%>">▶▶</a>] <%
 	}
 %>
		</td>
		</tr>
		<tr align="center">

			<td><input type=button value="글쓰기"
				OnClick="window.location='notice/Board_Write.jsp'"></td>
		</tr>
	</table>
</body>
</html>


