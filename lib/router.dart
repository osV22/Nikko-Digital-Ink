import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/screens/home_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Page not found: ${state.error}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.goNamed('onboarding'),
                child: const Text('Go to Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
