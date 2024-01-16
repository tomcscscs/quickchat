<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
</style>
</head>
<body>

	<nav class="navbar bg-body-tertiary sticky-top"
		data-bs-theme="${empty sessionScope.logonAccount ? 'light' : 'dark'}">
		<div class="container-fluid">
			<a class="navbar-brand d-flex align-items-center"
				href="${contextPath}/index"> <i
				class="bi bi-rocket-takeoff-fill"
				style="font-size: 24px; color: white; margin-right: 5px;"></i>
				<h4
					style="font-family: 'Lemon', serif; font-size: 40px; color: white; margin: 0;">QuickChat</h4>
			</a><a class="navbar-toggler border border-0" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<c:choose>
					<c:when test="${empty sessionScope.logonAccount }">
						<span class="bi bi-person-slash"></span>
					</c:when>
					<c:otherwise>
						<span class="bi bi-person-circle"></span>
					</c:otherwise>
				</c:choose>
			</a>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<c:choose>
						<c:when test="${empty sessionScope.logonAccount }">
							<h5 class="offcanvas-title" id="offcanvasNavbarLabel">퀵챗</h5>
						</c:when>
						<c:otherwise>
							<div class="d-flex gap-1 align-items-center">
								<img
									src="${fn:startsWith(sessionScope.logonAccount.profileImageUrl, 'http') ? '': contextPath }${sessionScope.logonAccount.profileImageUrl }"
									width="42" height="42" class="rounded-circle" />
								<h5 class="offcanvas-title" id="offcanvasNavbarLabel">
									${sessionScope.logonAccount.nickname }</h5>
								<span class="badge" style="background-color: #FEE500;">${sessionScope.logonAccount.platform }</span>
							</div>
						</c:otherwise>
					</c:choose>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>

			</div>
		</div>
	</nav>








	<!-- 채팅내용 뿌려지는 영역 -->
	<div class="flex-grow-1 px-1"
		style="overflow: auto; z-index: 1; margin-top: 80px; margin-bottom: 40px;"
		id="chatView">
		<div id="0"></div>
		<c:forEach items="${chatMessages }" var="one" varStatus="status">
			<c:choose>
				<c:when test="${status.first }">
					<fmt:formatDate pattern="yyyy년 MM월 dd일 E요일" value="${one.sentAt }"
						var="now" />
					<div
						class="d-flex justify-content-center my-1 align-items-end gap-1 ">
						<div class="card px-2 py-1 bg-secondary text-white">
							<small>${now }</small>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<fmt:formatDate pattern="yyyy년 MM월 dd일 E요일" value="${one.sentAt }"
						var="next" />
					<c:if test="${now != next }">
						<hr />
						<div
							class="d-flex justify-content-center my-1 align-items-end gap-1">
							<div class="card px-2 py-1 bg-secondary text-white">
								<small>${next }</small>
							</div>
						</div>
					</c:if>
					<c:set var="now" value="${next }" />
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${one.talkerId eq sessionScope.logonAccount.id }">
					<div id="${one.id }"
						class="d-flex justify-content-end my-1 align-items-end gap-1 ">
						<div>
							<c:if test="${one.checkedAt eq null }">
								<div style="font-size: xx-small;">안읽음</div>
							</c:if>
							<div style="font-size: xx-small;">
								<fmt:formatDate pattern="a hh:mm" value="${one.sentAt }" />
							</div>
						</div>
						<div class="card px-2 py-1 " style="background-color: peachpuff">${one.content }</div>
					</div>
				</c:when>
				<c:otherwise>
					<div id="${one.id }"
						class="d-flex justify-content-start  my-1 align-items-end gap-1">
						<div class="card px-2 py-1" style="background-color: aliceblue">${one.content }</div>
						<div>
							<span style="font-size: xx-small;"><fmt:formatDate
									pattern="a hh:mm" value="${one.sentAt }" /></span>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
	<div style="position: absolute; bottom: 0; z-index: 10; width: 100%"
		class="input-group">
		<input type="text" class="form-control form-control-sm" id="msg" />
		<button class="btn btn-outline-secondary" type="button" id="sendBt">
			<i class="bi bi-send"></i>
		</button>
	</div>
	</div>
	<script>
	document.querySelector("#chatView").scrollTop = document.querySelector("#chatView").scrollHeight;
	
	// console.log(document.querySelector("#chatView").scrollHeight);
	// console.log(document.querySelector("#chatView").scrollTop);

	function sendChatMessage() {
		const value = document.querySelector("#msg").value;
		if (value) {
			const xhr = new XMLHttpRequest();
			xhr.open("POST", "${contextPath}/chat/room/${chatRoom.id}/message",
					true);

			xhr.setRequestHeader("content-type",
					"application/x-www-form-urlencoded");
			xhr.send("content=" + value);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					var response = JSON.parse(xhr.responseText);
					// window.alert(response.result);
					document.querySelector("#msg").value = "";
					// getLatestMessage();
				}
			}
		}
	}

	document.querySelector("#sendBt").onclick = sendChatMessage;
	document.querySelector("#msg").onkeyup = function(e) {
		if (e.keyCode == 13) {
			sendChatMessage();
		}
	}
</script>
	<script>
	var logonAccountId = '${sessionScope.logonAccount.id}';
	// 추가된 최신 메시지 얻어오는 AJAX 함수
	
	function getLatestMessage() {
		const id = document.querySelector("#chatView").lastElementChild.id;
		
		
		const xhr = new XMLHttpRequest();
		xhr.open("GET", "${contextPath}/chat/room/${chatRoom.id}/latest?lastMessageId="+id);
		xhr.onreadystatechange=function() {
			if(xhr.readyState==4) {
				var response = JSON.parse(xhr.responseText);
				console.log(response);
				// response 안에 messages 라는 객체배열이 있을꺼임
				for(var msg of response.messages) {
					if(logonAccountId == msg.talkerId ) {
						const div = document.createElement("div");
						div.id = msg.id;
						div.className = "d-flex justify-content-end my-1 align-items-end gap-1 ";
							const inDiv1 = document.createElement("div");
						div.appendChild(inDiv1);
							const inDiv2 = document.createElement("div");
							inDiv2.className="card px-2 py-1 ";
							inDiv2.style.backgroundColor = "peachpuff";
							inDiv2.textContent = msg.content;
						div.appendChild(inDiv2);
						document.querySelector("#chatView").appendChild(div);
					}else {
						const div = document.createElement("div");
						div.id = msg.id;
						div.className = "d-flex justify-content-start  my-1 align-items-end gap-1";
							const inDiv1 = document.createElement("div");
							inDiv1.className="card px-2 py-1 ";
							inDiv1.style.backgroundColor = "aliceblue";
							inDiv1.textContent = msg.content;
						div.appendChild(inDiv1);
							const inDiv2 = document.createElement("div");
							div.appendChild(inDiv2);
						document.querySelector("#chatView").appendChild(div);
					}
				} // end for
				document.querySelector("#chatView").scrollTop = document.querySelector("#chatView").scrollHeight;
			}	
		}
		xhr.send();
	}
	
	setInterval(getLatestMessage, 1000);
	
</script>
	<%@ include file="/WEB-INF/view/component/footer.jspf"%>