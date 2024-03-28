import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key, required this.title});

  final String title;

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _exception = '';

  Future<void> _createAccount() async {
    if(_formKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ).then((firebaseUser){
          if(kDebugMode){
            print('User: ${firebaseUser.user!.email} created successfully');
          }
        });
        if(mounted){
          context.go('/');
        }
      } on FirebaseAuthException catch(e) {
        String ex = 'Firebase Authentication Exception: ';
        if(e.code == 'email-already-in-use'){
          ex += 'the account already exists for that email';
        } else if(e.code == 'weak-password'){
          ex += 'the password provided is too weak';
        } else {
          ex += 'make sure you are using a valid email';
        }
        setState((){
          _exception = ex;
        });
      }

    }
  }

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please enter your email address';
                      }
                      return null;
                    }
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Password *',
                      icon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please enter a password';
                      }
                      return null;
                    }
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password *',
                      icon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please re-enter your password';
                      }
                      if(value != _passwordController.text){
                        return 'Passwords do not match. Please try again.';
                      }
                      return null;
                    }
                  ),
                  ElevatedButton(
                    onPressed: _createAccount,
                    child: const Text('Create an Account'),
                  )
                ]
              )
            ),
            _exception.isEmpty
              ? const SizedBox.shrink()
              : Text(
                _exception,
                style: const TextStyle(color: Colors.red),
              ),
          ]
        ),
      )
    );
    
  }
}
