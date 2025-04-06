import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/drawer/drawer_menu.dart';

class HomeScaffold extends ConsumerWidget {
  final Widget child;
  
  const HomeScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Learning App'),
      ),
      drawer: const DrawerMenu(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Voice Call',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.go('/');
          } else if (index == 1) {
            context.go('/chatbot');
          } else if (index == 2) {
            context.go('/voice-call-options');
          }
        },
      ),
    );
  }
}