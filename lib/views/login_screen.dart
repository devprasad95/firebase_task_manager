import 'package:firebase_task_manager/service/auth_service.dart';
import 'package:firebase_task_manager/views/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 10,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const Spacer(),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().signIn(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim());
                if (mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                }
                _emailController.clear();
                _passwordController.clear();
              },
              child: const Text('Login'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text('Create a new account'),
            ),
            const Spacer(
              flex: 10,
            )
          ],
        ),
      ),
    );
  }
}
