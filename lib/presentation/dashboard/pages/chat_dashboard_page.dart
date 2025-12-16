import 'package:flutter/material.dart';
import 'package:characters/characters.dart';
import 'package:lang/data/services/apichatgpt.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isTyping = false;
  bool isLoading = false;
  String currentTypingText = '';

  String? selectedUnit;

  final List<Map<String, String>> units = [
    {"name": "Basic Daily", "image": "assets/images/started1.jpg"},
    {"name": "Number and Counting", "image": "assets/images/started4.jpg"},
    {"name": "Everyday Objects", "image": "assets/images/module4.jpg"},
    {"name": "Daily Activities", "image": "assets/images/module3.jpg"},
    {"name": "Family and Friends", "image": "assets/images/school.jpg"},
  ];

  double _scale = 1.0;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _simulateTyping(String text) async {
    currentTypingText = '';
    isTyping = true;
    if (mounted) setState(() {});
    _scrollToBottom();

    final chars = text.characters;
    int charIndex = 0;
    const batchSize = 3; // Update every 3 characters instead of every character
    
    while (charIndex < chars.length) {
      await Future.delayed(const Duration(milliseconds: 50)); // Slightly slower but smoother
      
      // Add multiple characters at once
      final endIndex = (charIndex + batchSize < chars.length) 
          ? charIndex + batchSize 
          : chars.length;
      currentTypingText += chars.getRange(charIndex, endIndex).toString();
      charIndex = endIndex;
      
      if (mounted) setState(() {});
      _scrollToBottom();
    }

    messages.add({'isUser': false, 'text': currentTypingText});
    currentTypingText = '';
    isTyping = false;
    if (mounted) setState(() {});
    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (mounted) {
      setState(() {
        messages.add({'isUser': true, 'text': text});
        _controller.clear();
        isLoading = true;
      });
    }
    _scrollToBottom();

    final aiResponse = await getAIResponse(text);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    await _simulateTyping(aiResponse);
  }

  void _selectUnit(String unit) {
    if (mounted) {
      setState(() {
        selectedUnit = unit;
        messages.add({'isUser': true, 'text': unit});
      });
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _simulateTyping(
          "Great! You selected \"$unit\". Let's start practicing. 😊",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 245, 245, 245)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Graolang Assistant Chat",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeInBack,
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: selectedUnit == null
                      ? _buildUnitSelection()
                      : _buildChatMessages(),
                ),
              ),
              if (selectedUnit != null) _buildInputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitSelection() {
    return Padding(
      key: const ValueKey('unit_selection'),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Which unit would you like to practice? with GraolangAI🤔",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: units.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                final unit = units[index];
                return GestureDetector(
                  onTapDown: (_) {
                    if (mounted) setState(() {
                      _scale = 0.95;
                    });
                  },
                  onTapUp: (_) {
                    if (mounted) setState(() {
                      _scale = 1.0;
                    });
                    _selectUnit(unit['name']!);
                  },
                  onTapCancel: () {
                    if (mounted) setState(() {
                      _scale = 1.0;
                    });
                  },
                  child: AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black26,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              unit['image']!,
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(0.3),
                              colorBlendMode: BlendMode.darken,
                              cacheWidth: 300, // Cache images for better performance
                              cacheHeight: 200,
                            ),
                          ),
                          Center(
                            child: Text(
                              unit['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      key: const ValueKey('chat_messages'),
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messages.length + (isTyping || isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (isLoading && index == messages.length) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 8,
                      height: 8,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "AI is typing...",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (isTyping && index == messages.length) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  currentTypingText,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          );
        }

        final message = messages[index];
        final isUser = message['isUser'] as bool;

        return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  isUser ? "You" : "AI Tutor",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: isUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isUser)
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(
                          'assets/images/started1.jpg',
                        ),
                      ),
                    if (!isUser) const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color.fromARGB(255, 64, 140, 255)
                              : const Color.fromARGB(255, 238, 238, 238),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            fontSize: 15,
                            color: isUser ? Colors.white : Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    if (isUser) const SizedBox(width: 8),
                    if (isUser)
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(
                          'assets/images/started3.jpg',
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const Icon(Icons.attach_file_outlined, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: _controller.text.trim().isEmpty
                  ? const Color.fromARGB(255, 13, 51, 203)
                  : const Color.fromARGB(255, 64, 140, 255),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
