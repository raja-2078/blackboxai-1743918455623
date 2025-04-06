import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'app/home_scaffold.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/core/home_screen.dart';
import 'screens/core/chatbot_screen.dart';
import 'screens/voice_call/voice_call_options_screen.dart';
import 'screens/voice_call/voice_call_screen.dart';
import 'screens/drawer/profile_screen.dart';

/// Application routing configuration defining:
/// - Authentication routes (login/signup)
/// - Main app navigation hierarchy
/// - Protected routes
/// - Route transitions
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScaffold(child: HomeScreen()),
      routes: [
        GoRoute(
          path: 'chatbot',
          builder: (context, state) => const HomeScaffold(child: ChatbotScreen()),
        ),
        GoRoute(
          path: 'voice-call-options',
          builder: (context, state) => const HomeScaffold(child: VoiceCallOptionsScreen()),
        ),
        GoRoute(
          path: 'voice-call',
          builder: (context, state) => const VoiceCallScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const HomeScaffold(child: ProfileScreen()),
        ),
      ],
    ),
  ],
);