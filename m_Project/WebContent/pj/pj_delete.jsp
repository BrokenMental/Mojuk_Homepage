<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script language="javascript">
	// 자바 스크립트 시작
	function deleteCheck() {
		var form = document.deleteform;

		if (!form.password.value) {
			alert("비밀번호를 적어주세요");
			form.password.focus();
			return;
		}
		form.submit();
	}
</script>
<%
	int idx = Integer.parseInt(request.getParameter("idx"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 삭제</title>
</head>
<body>
	<table>
		<form name=deleteform method=post action="pj_delete_ok.jsp?idx=<%=idx%>">
		<tr>
			<td>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr
						style="background: url('image/table_mid.gif') repeat-x; text-align: center;">
						<td width="5"><img src="image/table_left.gif" width="5"
										   height="30" /></td>
						<td>삭제</td>
						<td width="5"><img src="image/table_right.gif" width="5"
										   height="30" /></td>
					</tr>
				</table>
				<table>
					<tr>
						<td>&nbsp;</td>
						<td align="center">비밀번호</td>
						<td><input name="password" type="password" size="50"
							maxlength="100"></td>
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
						<td colspan="2"><input type=button value="삭제"
							OnClick="javascript:deleteCheck();"> <input type=button
							value="취소" OnClick="javascript:history.back(-1)">
						<td>&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>