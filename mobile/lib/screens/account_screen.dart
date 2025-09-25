import 'package:flutter/material.dart';

class AccountRoot extends StatelessWidget {
  const AccountRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Account Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
