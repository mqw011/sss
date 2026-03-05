import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_app_bar.dart';
import '../../../../core/widgets/minimal_input_field.dart';
import '../../../genres/domain/entities/subgenre.dart';
import '../providers/chat_provider.dart';
import '../../domain/entities/message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Subgenre subgenre;

  const ChatScreen({super.key, required this.subgenre});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  Future<void> _sendMessage() async {
    final text = _textController.text;
    if (text.trim().isNotEmpty) {
      final repo = ref.read(chatRepositoryProvider);
      await repo.sendMessage(widget.subgenre.id, text);
      ref.invalidate(chatProvider(widget.subgenre.id));
      _textController.clear();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(chatProvider(widget.subgenre.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: '# ${widget.subgenre.name}',
      ),
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            // Dark elegant background map
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Hero(
                  tag: 'subgenre_${widget.subgenre.id}',
                  child: Image.network(
                    widget.subgenre.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Gradient to fade the image at the bottom
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.8),
                      AppColors.background,
                    ],
                  ),
                ),
              ),
            ),
            
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
                
                Expanded(
                  child: chatAsync.when(
                    data: (messages) {
                      if (messages.isEmpty) {
                        return Center(
                          child: Text(
                            'No messages yet. Start the discussion!',
                            style: AppTextStyles.bodyCaption,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        reverse: false, // Let's keep it simple top-down for the mock
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          return _MessageBubble(message: msg);
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.accentNeonPurple),
                    ),
                    error: (error, _) => Center(
                      child: Text('Error: $error', style: AppTextStyles.bodyChat),
                    ),
                  ),
                ),
                
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 16,
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withValues(alpha: 0.5),
                        border: Border(
                          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                        ),
                      ),
                      child: MinimalInputField(
                        controller: _textController,
                        hintText: 'Message #${widget.subgenre.name}',
                        onSend: _sendMessage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.surfaceLight, AppColors.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: AppColors.accentCyan.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Center(
                child: Text(
                  message.senderName[0].toUpperCase(),
                  style: AppTextStyles.heading3.copyWith(fontSize: 16, color: AppColors.accentCyan),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          
          Flexible(
            child: Column(
              crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMine) ...[
                  Text(
                    message.senderName,
                    style: AppTextStyles.bodyCaption.copyWith(color: AppColors.accentCyan, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: isMine 
                        ? AppColors.accentNeonPurple.withValues(alpha: 0.15) 
                        : AppColors.surfaceLight.withValues(alpha: 0.8),
                    border: Border.all(
                      color: isMine 
                          ? AppColors.accentNeonPurple.withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.05),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: isMine ? const Radius.circular(20) : const Radius.circular(6),
                      bottomRight: isMine ? const Radius.circular(6) : const Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: isMine 
                        ? AppTextStyles.bodyChat.copyWith(color: Colors.white) 
                        : AppTextStyles.bodyChat,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: AppTextStyles.bodyCaption.copyWith(fontSize: 11, color: Colors.white38),
                ),
              ],
            ),
          ),
          
          if (isMine) const SizedBox(width: 36), // Visual balance for avatar width
        ],
      ),
    );
  }
}
