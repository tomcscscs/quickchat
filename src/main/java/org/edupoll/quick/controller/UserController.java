package org.edupoll.quick.controller;

import javax.servlet.http.HttpSession;

import org.edupoll.quick.model.Account;
import org.edupoll.quick.repository.AccountsRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor

public class UserController {

	@GetMapping("/logout")
	public String accountLogout(HttpSession session) {
		session.invalidate();

		return "redirect:/index";

	}

}
