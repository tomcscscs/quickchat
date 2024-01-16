package org.edupoll.quick.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.edupoll.quick.model.Account;
import org.edupoll.quick.model.ChatMessage;
import org.edupoll.quick.repository.ChatsRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.google.gson.Gson;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController {
	private final ChatsRepository chatsRepository;

	@GetMapping("/chatroom")
	public String chatRoom(Model model) {

		return "chat/room";

	}

	// 메시지 등록 처리하는 핸들러
	@ResponseBody
	@PostMapping("/room/{roomId}/message")
	public String proceedAddChatMessage(@SessionAttribute Account logonAccount, @PathVariable String roomId,
			@RequestParam String content) {

		ChatMessage messages = ChatMessage.builder() //
				.chatRoomId(roomId).talkerId(logonAccount.getId()).content(content).build();

		chatsRepository.saveChatMessage(messages);

		Gson gson = new Gson();
		Map<String, Object> response = new HashMap<>();
		response.put("result", "success");

		return gson.toJson(response);
	}

	// 특정 시점이후의 메시지 목록을 전송하는 핸들러

	@GetMapping(path = "/room/{roomId}/latest", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String proceedFindLatestMessage(@PathVariable String roomId, @RequestParam int lastMessageId,
			@SessionAttribute Account logonAccount) {
		Map<String, Object> criteria = new HashMap<>();
		criteria.put("roomId", roomId);
		criteria.put("lastMessageId", lastMessageId);
		List<ChatMessage> list = chatsRepository.findAfterChatMessageByRoomId(criteria);

		criteria.clear();
		criteria.put("roomId", roomId);
		criteria.put("logonAccountId", logonAccount.getId());
		chatsRepository.updateCheckAtByRoomId(criteria);

		Map<String, Object> response = new HashMap<>();
		response.put("result", "success");
		response.put("messages", list);
		Gson gson = new Gson();
		return gson.toJson(response);
	}

}
