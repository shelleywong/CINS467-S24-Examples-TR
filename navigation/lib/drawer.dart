import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('CINS 467'),
        ),
        ListTile(
          leading: const Icon(Icons.arrow_forward),
          title: const Text('Second Route'),
          onTap: () {
            // Update the state of the app.
            context.go('/page2');
          },
        ),
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: const Text('First Route'),
          onTap: () {
            // Update the state of the app.
            context.go('/');
          },
        ),
      ],
    ),
  );
}
