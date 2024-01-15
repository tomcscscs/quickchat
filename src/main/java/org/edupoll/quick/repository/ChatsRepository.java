package org.edupoll.quick.repository;

import java.util.List;
import java.util.Map;

import org.edupoll.quick.model.ChatMessage;

public interface ChatsRepository {
	public int saveChatMessage(ChatMessage chatMessage);
	public List<ChatMessage> findChatMessageByRoomId(String roomId);
	public List<ChatMessage> findAfterChatMessageByRoomId(Map<String, Object> criteria);
	public int countUncheckedMessageByRoomId(Map<String, Object> criteria);
	public int updateCheckAtByRoomId(Map<String, Object> criteria);
}
