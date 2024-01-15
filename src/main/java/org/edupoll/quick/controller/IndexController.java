package org.edupoll.quick.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.edupoll.quick.model.Account;
import org.edupoll.quick.model.KakaoOAuthToken;
import org.edupoll.quick.model.KakaoUserInfo;
import org.edupoll.quick.repository.AccountsRepository;
import org.edupoll.quick.service.KakaoAPIService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor


public class IndexController {
	
	private final ServletContext application;
	private final KakaoAPIService kakaoAPIService;
	private final AccountsRepository accountsRepository;
	
	
	
	@GetMapping("/index")
	
	public String showIndex(Model model) {
		String kakaoLoginLink = "https://kauth.kakao.com/oauth/authorize?";
		kakaoLoginLink += "client_id=${client_id}&response_type=code";
		kakaoLoginLink += "&redirect_uri=${redirect_uri}";

		String clientId = "7ab771b649c094c990041f78323bcfd1";
		String redirectURI = "http://192.168.1.5:8080${contextPath}/callback/kakao".replace("${contextPath}",
				application.getContextPath());

		kakaoLoginLink = kakaoLoginLink.replace("${client_id}", clientId);
		kakaoLoginLink = kakaoLoginLink.replace("${redirect_uri}", redirectURI);

		model.addAttribute("kakaoLoginLink", kakaoLoginLink);
		
		return "index";
		
	}
	
	@GetMapping("/callback/kakao")
	public String acceptCode(@RequestParam String code, HttpSession session) {
		// System.out.println("code = " + code);
		KakaoOAuthToken oAuthToken = kakaoAPIService.getOAuthToken(code);
		// System.out.println(oAuthToken.getAccess_token());
		KakaoUserInfo kakaoUserInfo = kakaoAPIService.getUserInfo(oAuthToken.getAccess_token());

		// System.out.println(kakaoUserInfo);
		String id ="k" + kakaoUserInfo.getId();
		Account account = accountsRepository.findById(id);
		if (account == null) {
			Account one =
					Account.builder().id(id).nickname(kakaoUserInfo.getProfile().getNickname()).platform("kakao").accessToken(oAuthToken.getAccess_token()).profileImageUrl(kakaoUserInfo.getProfile().getProfileImage()).build();
			accountsRepository.save(one);
			session.setAttribute("logonAccount", one);
		} else {
			account.setAccessToken(oAuthToken.getAccess_token());
//			account.setNickname(kakaoUserInfo.getProfile().getNickname());
//			account.setProfileImageUrl(kakaoUserInfo.getProfile().getProfileImage());
			accountsRepository.update(account);
			session.setAttribute("logonAccount", account);
		}
		
		return "/chat/room";
		
	}
	

	
	

}
