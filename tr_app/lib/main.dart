import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'storage.dart';
//import 'sqlstorage.dart';
import 'firestorage.dart';
import 'firebase_options.dart';
import 'photos.dart';
import 'home.dart';
import 'createuser.dart';
import 'profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if(kIsWeb){
  //   runApp(const MyApp(myAppTitle: 'Web CINS467'));
  // } else if(Platform.isAndroid){
  //   runApp(const MyApp(myAppTitle: 'Android CINS467'));
  // } else {
  //   runApp(const MyApp(myAppTitle: 'CINS467'));
  // }
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        if(FirebaseAuth.instance.currentUser == null){
          return const AuthPage(title: 'CINS467 Auth Page');
        } else {
          return const MyHomePage(title: 'Hello CINS467!');
        }
      }
    ),
    GoRoute(
      path: '/photos',
      builder: (context, state) => const MyPhotoPage(title: 'CINS467 Photos!'),
    ),
    GoRoute(
      path: '/createuser',
      builder: (context, state) => const CreateUser(title: 'Create Account'),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        if(FirebaseAuth.instance.currentUser == null){
          return const AuthPage(title: 'CINS467 Auth Page');
        } else {
          return const ProfilePage(title: 'Profile');
        }
      }
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routerConfig: _router,
      //home: const MyHomePage(title: 'Hello CINS467!'),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.photo),
        //     onPressed: () => context.go('/photos'),
        //   )
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/createuser'),
              child: const Text('Create an Account'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Login'),
            )
          ]
        ),
      )
    );
    
  }
}
