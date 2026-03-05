import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_app_bar.dart';
import '../../../subgenres/domain/entities/subgenre.dart';
import '../providers/chat_provider.dart';
import '../../domain/entities/message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Subgenre subgenre;

  const ChatScreen({super.key, required this.subgenre});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _controller.clear();
      
      // Send the message using the repository
      await ref.read(chatRepositoryProvider).sendMessage(widget.subgenre.id, text);
      
      // Invalidate the future provider to refresh the chat history
      ref.invalidate(chatProvider(widget.subgenre.id));
      
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatProvider(widget.subgenre.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(
        title: 'CHANNEL_CONNECTION: ACTIVE',
        showBackButton: true,
      ),
      body: Container(
        color: AppColors.backgroundDark,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
            _buildSystemStatus(),
            Expanded(
              child: messagesAsync.when(
                data: (messages) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: AppColors.neonCyan.withValues(alpha: 0.1)),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return _MessageBubble(message: msg);
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.neonCyan)),
                error: (error, _) => Center(child: Text('SYS_ERR: $error', style: AppTextStyles.codeStyle)),
              ),
            ),
            _buildTerminalInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatus() {
    return Container(
      width: double.infinity,
      color: Colors.white.withValues(alpha: 0.05),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SYS_LOG: LINK_ESTABLISHED', style: AppTextStyles.metaStyle),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.neonCyan, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text('LATENCY: 12ms', style: AppTextStyles.codeStyle.copyWith(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: AppColors.neonCyan.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          Text('>', style: AppTextStyles.codeStyle.copyWith(color: AppColors.neonCyan, fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              style: AppTextStyles.codeStyle.copyWith(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'INPUT_COMMAND...',
                hintStyle: AppTextStyles.codeStyle.copyWith(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.neonCyan),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == 'current_user' || message.senderId == 'user_my';

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Header (USER & TIMESTAMP)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isMe ? 'OPERATOR' : message.senderId.toUpperCase(),
                style: AppTextStyles.metaStyle.copyWith(
                  color: isMe ? AppColors.neonCyan : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _formatTime(message.timestamp),
                style: AppTextStyles.metaStyle,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Message Content
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe ? AppColors.neonCyan.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
              border: Border(
                left: BorderSide(
                  color: isMe ? AppColors.neonCyan : AppColors.primary,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              message.text,
              style: AppTextStyles.codeStyle.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
}
