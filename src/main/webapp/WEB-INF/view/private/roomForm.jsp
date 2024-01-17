<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/component/header.jspf"%>
<div class="container mt-3">
	<h4>방 만들기</h4>
	
	<form action="${contextPath }/chat/saveRoom" method="post">
		<table>

			<tr>
				<th>게시판 이름을 입력하세요.</th>

			</tr>
			<tr>
				<td><input type="text" name="inputTitle">
				<button type="submit"></button>
				</td>
			</tr>

		</table>
	</form>
</div>
<%@ include file="/WEB-INF/view/component/footer.jspf"%>