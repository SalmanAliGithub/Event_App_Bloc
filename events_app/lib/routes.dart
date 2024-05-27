// routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:events_app/presentation/screens/splash_screen.dart';
import 'package:events_app/presentation/screens/sign_in_screen.dart';
import 'package:events_app/presentation/screens/sign_up_screen.dart';
import 'package:events_app/presentation/screens/admin_homepage_screen.dart';
import 'package:events_app/presentation/screens/events_screen.dart';

import 'package:events_app/presentation/screens/event_detail_screen.dart';
import 'package:events_app/api/event_api.dart';
import 'package:events_app/models/event_model.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminHomePage(),
    ),
    GoRoute(
      path: '/events',
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: '/event_detail/:id',
      builder: (context, state) {
        final eventId = int.parse(state.pathParameters['id']!);
        return FutureBuilder<Map<String, dynamic>>(
          future: EventApi.getEvent(eventId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text('Error loading event')),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Scaffold(
                body: Center(child: Text('Event not found')),
              );
            }

            final eventData = snapshot.data!;
            final event = Event.fromJson(eventData);

            return EventDetailScreen(event: event);
          },
        );
      },
    ),
  ],
);
