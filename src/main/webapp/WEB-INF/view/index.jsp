<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/component/header.jspf"%>

<div
	class="container py-5 d-flex flex-column
		justify-content-center align-items-center">
	<h4 style="font-family:'Lemon', serif ; font-size: 50px;">QuickChat</h4>
	<div class="card mt-3" style="width: 20rem; height: 24rem;">
		<div class="card-body d-flex flex-column justify-content-between">
			<h5 class="card-title " style="word-break: keep-all; font-family:font-family: 'Noto Sans KR', sans-serif;">카카오로 입장하기.</h5>
			<div class="card-text text-center">
				<p
					style="border-radius: 12px; background-color: #FEE500; cursor: pointer;"
					onclick="location.href='${kakaoLoginLink}'">
					<img
						src="${contextPath }/resource/icon/kakaobutton3.png"
						alt="카카오로 로그인하기" />

				</p>
			

			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/view/component/footer.jspf"%>