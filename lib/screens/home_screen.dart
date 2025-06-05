import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gemini_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeminiProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    _scrollToBottom();

    final isDark = themeProvider.isDarkTheme;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final primary = Theme.of(context).primaryColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: AppBar(
    elevation: 0,
    backgroundColor: isDark ? primary.withOpacity(0.8) : Colors.white,
    centerTitle: true,
    title: const Text(
      'Coco.ai',
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.add_circle_outline),
        onPressed: () {},
      )
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: Colors.grey.shade300,
        height: 1.0,
      ),
    ),
  ),
),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).primaryColor,
                ]),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text("CocoAI Settings",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeProvider.isDarkTheme,
              onChanged: (_) => themeProvider.toggleTheme(),
              secondary: const Icon(Icons.dark_mode),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.messages.length) {
                  return const Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator()));
                }

                final msg = provider.messages[index];
                final isUser = msg.isUser;

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
      ? (isDark
          ? const Color(0xFF3A3A47) // Gray bubble for user in dark mode
          : const Color(0xFF8C6E54)) // Soft brown for user in light mode
      : cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isUser ? 16 : 4),
                        topRight: Radius.circular(isUser ? 4 : 16),
                        bottomLeft: const Radius.circular(16),
                        bottomRight: const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Row(
  children: [
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2E2E3E)
              : const Color(0xFFF3EFEA), // light soft beige
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? const Color(0xFF444455) : Colors.grey.shade300,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _controller,
          style: TextStyle(color: textColor),
          cursorColor: primary,
          decoration: const InputDecoration(
            hintText: "How are you feeling today?",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          textInputAction: TextInputAction.send,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              provider.sendMessage(value.trim());
              _controller.clear();
            }
          },
        ),
      ),
    ),
    const SizedBox(width: 10),
    Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primary,
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.send, color: Colors.white),
        onPressed: () {
          if (_controller.text.trim().isNotEmpty) {
            provider.sendMessage(_controller.text.trim());
            _controller.clear();
          }
        },
      ),
    )
  ],
),

      ),],        
      ),
    );
  }
}
