<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>퀵챗</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Lemon&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lemon&family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">



<style>
form-control:focus {
	box-shadow: none;
}

.bordered-button {
	display: inline-block;
	padding: 10px 20px;
	border: 2px solid #000; /* 테두리 스타일 및 색상 설정 */
	border-radius: 5px; /* 테두리 모서리 둥글게 설정 */
	background-color: #fff; /* 배경색 설정 */
	color: #000; /* 텍스트 색상 설정 */
	text-decoration: none; /* 텍스트에 밑줄 제거 */
	font-weight: bold;
	font-size: 16px;
	cursor: pointer;
}

/* 버튼 호버 효과 */
.bordered-button:hover {
	background-color: #000; /* 호버 시 배경색 변경 */
	color: #fff000; /* 호버 시 텍스트 색상 변경 */
}
a {text-decoration: none; color: black;
	
}
</style>

<link rel="icon"
	href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-rocket-takeoff-fill' viewBox='0 0 16 16'%3E%3Cpath d='M12.17 9.53c2.307-2.592 3.278-4.684 3.641-6.218.21-.887.214-1.58.16-2.065a3.6 3.6 0 0 0-.108-.563 2 2 0 0 0-.078-.23V.453c-.073-.164-.168-.234-.352-.295a2 2 0 0 0-.16-.045 4 4 0 0 0-.57-.093c-.49-.044-1.19-.03-2.08.188-1.536.374-3.618 1.343-6.161 3.604l-2.4.238h-.006a2.55 2.55 0 0 0-1.524.734L.15 7.17a.512.512 0 0 0 .433.868l1.896-.271c.28-.04.592.013.955.132.232.076.437.16.655.248l.203.083c.196.816.66 1.58 1.275 2.195.613.614 1.376 1.08 2.191 1.277l.082.202c.089.218.173.424.249.657.118.363.172.676.132.956l-.271 1.9a.512.512 0 0 0 .867.433l2.382-2.386c.41-.41.668-.949.732-1.526zm.11-3.699c-.797.8-1.93.961-2.528.362-.598-.6-.436-1.733.361-2.532.798-.799 1.93-.96 2.528-.361s.437 1.732-.36 2.531Z'/%3E%3Cpath d='M5.205 10.787a7.6 7.6 0 0 0 1.804 1.352c-1.118 1.007-4.929 2.028-5.054 1.903-.126-.127.737-4.189 1.839-5.18.346.69.837 1.35 1.411 1.925'/%3E%3C/svg%3E"
	type="image/svg+xml">


</head>
<body>
	<div
		class="container py-5 d-flex flex-column
		justify-content-center align-items-center">
		<h4 style="font-family: 'Lemon', serif; font-size: 50px;"><a href="${contextPath }/chat/showLoginIndex">QuickChat</a> </h4>

	</div>

	<div style="display: flex; align-items: center; gap: 4px; justify-content: flex-end;">
		<ul>

			<c:forEach var="one" items="${setAllRoomList}">
				<li><p style="margin-top: auto;"> ${one.title }/${one.createdAt }</p></li>
			</c:forEach>

		</ul>
	</div>

	
	
	
	<div>
		<i class="bi bi-plus-square-fill"></i><a
			href="${contextPath}/chat/inputDataPageForChatRoom"
			class="bordered-button" style="text-align: center;"> 방 만들기</a>
	</div>



	<%@ include file="/WEB-INF/view/component/footer.jspf"%>