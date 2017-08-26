<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/mojuk?characterEncoding=utf8&amp;useSSL=false&amp;autoReconnection=true";
	String id = "root";
	String pass = "1234";
	String name = "";
	String password = "";
	String title = "";
	String memo = "";
	int idx = Integer.parseInt(request.getParameter("idx"));

	try {

		Connection conn = DriverManager.getConnection(url, id, pass);
		Statement stmt = conn.createStatement();

		String sql = "SELECT USERNAME, PASSWORD, TITLE, MEMO FROM notice WHERE ID=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		if (rs.next()) {

			name = rs.getString(1);
			password = rs.getString(2);
			title = rs.getString(3);
			memo = rs.getString(4);
		}

		rs.close();
		stmt.close();
		conn.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="../css/main.css" />
</head>
<body>
	<div style="width: 0px; margin: auto;">
		<div id="container">
			<!-- 상단 -->
			<%@include file="../include/top.jsp"%>
			<div class="bar"></div>
			<!-- 상단 메뉴 -->
			<div id="menu">
				<div class="logo">
					<a href="../main.jsp"><img src="../img/logo.png" width="160"
						height="60"></a>
				</div>
				<div class="menu" style="margin-left: 345px;">
					<h3>
						<a href="../mojuk.jsp"
							style="text-decoration: none !important; color: black;">모죽</a>
					</h3>
				</div>
				<div class="menu">
					<h3>
						<a href="../notice.jsp"
							style="text-decoration: none !important; color: black;">공지사항</a>
					</h3>
				</div>
				<div class="menu">
					<h3>
						<a href="../project.jsp"
							style="text-decoration: none !important; color: black;">프로젝트</a>
					</h3>
				</div>
				<div class="menu">
					<h3>
						<a href="../board.jsp"
							style="text-decoration: none !important; color: black;">자유게시판</a>
					</h3>
				</div>
				<div class="menu">
					<h3>
						<a href="../gall.jsp"
							style="text-decoration: none !important; color: black;">갤러리</a>
					</h3>
				</div>
			</div>
			<!-- 메인 이미지 -->
			<div id="main_img">
				<img src="../img/main_img.png">
			</div>
			<!-- 하단(본문) -->
			<div id="main_ground">
				<div id="main"></div>
			</div>
			<!-- main ground_end -->
		</div>
		<!-- container_end -->
	</div>
	<center>
		<table>
			<tr>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr
							style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
							<td width="5"><img src="img/table_left.gif" width="5"
								height="30" /></td>
							<td>수정</td>
							<td width="5"><img src="img/table_right.gif" width="5"
								height="30" /></td>
						</tr>
					</table>
					<form name=modifyform method=post
						action="Board_Modify_Action.jsp?idx=<%=idx%>">
						<table>
							<tr>
								<td>&nbsp;</td>
								<td align="center">제목</td>
								<td><input type=text name=title size=50 maxlength=50
									value="<%=title%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">이름</td>
								<td><%=name%><input type=hidden name=name size=50
									maxlength=50 value="<%=name%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀번호</td>
								<td><input type=password name="password" id="pass" size=50
									maxlength=50></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">내용</td>
								<td><textarea name=memo cols=50 rows=13><%=memo%></textarea></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4"></td>
							</tr>
							<tr align="center">
								<td>&nbsp;</td>
								<td colspan="2"><input type="button" value="수정"
									OnClick="javascript:modifyCheck();"> <input type=button
									value="취소" OnClick="javascript:history.back(-1)">
								<td>&nbsp;</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
	</center>
	<script language="javascript">
		// 자바 스크립트 시작

		function modifyCheck() {
			var form = document.modifyform;

			if (!form.password.value) {
				alert("비밀번호를 적어주세요");
				form.password.focus();
				return;
			}

			if (!form.title.value) {
				alert("제목을 적어주세요");
				form.title.focus();
				return;
			}

			if (!form.memo.value) {
				alert("내용을 적어주세요");
				form.memo.focus();
				return;
			}
			form.submit();
		}
	</script>
</body>
</html>