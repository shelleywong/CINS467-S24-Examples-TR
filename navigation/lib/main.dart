import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'first.dart';
import 'second.dart';

void main() {
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'First Route'),
    ),
    GoRoute(
      path: '/page2',
      builder: (context, state) => const SecondRoute(),
    ),
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
      //home: const MyHomePage(title: 'First Route'),
    );
  }
}
