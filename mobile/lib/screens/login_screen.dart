import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); //used to validate the form (email & password fields).
  final TextEditingController _emailController = TextEditingController(); //lets us read and manage the text inside text fields.
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true; //Boolean flag to show/hide the password (used with the eye icon).
 
  void _login() { //runs when you tap “Login”.
    if (_formKey.currentState!.validate()) { //runs each field’s validator.
      // On successful validation, navigate to Home
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // allows screen to resize when keyboard appears
      appBar: AppBar(title: const Text("Login"),centerTitle:true),
      body: SafeArea(  //avoids notches/status bar covering your content.
        child: SingleChildScrollView( //makes the screen scrollable when space is small.
          padding: const EdgeInsets.all(16.0),
          child: Form(   //wraps all text fields and connects to _formKey for validation.
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // make buttons full width
              children: [
                const SizedBox(height: 60), // add spacing from top

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    // if (value.length < 8) {
                    //   return 'Password must be at least 8 characters';
                    // }
                    // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    //   return 'Password must contain at least one uppercase letter';
                    // }
                    // if (!RegExp(r'[a-z]').hasMatch(value)) {
                    //   return 'Password must contain at least one lowercase letter';
                    // }
                    // if (!RegExp(r'[0-9]').hasMatch(value)) {
                    //   return 'Password must contain at least one number';
                    // }
                    // if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    //   return 'Password must contain at least one special character';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  child: const Text("Login"),
                ),
                const SizedBox(height: 16),

                // Google Login Button
                OutlinedButton(
                  onPressed: () {
                    // TODO: Implement Google Sign-In
                  },
                  child: const Text("Login with Google"),
                ),
                const SizedBox(height: 16),

                // Register Link
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Don't have an account? Register"),
                ),

                const SizedBox(height: 40), // extra spacing at bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
