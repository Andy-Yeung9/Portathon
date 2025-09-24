import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _register() {
    if (_formKey.currentState!.validate()) {
      // ✅ All fields are valid
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),centerTitle:true),
      body: SingleChildScrollView( // prevents overflow with keyboard
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email
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

              // Password
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
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Must contain at least one number';
                  }
                  if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Must contain at least one special character';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Emergency Contact (Optional)
              TextFormField(
                controller: _emergencyContactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Emergency Contact (Optional)",
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Register Button
              ElevatedButton(
                onPressed: _register,
                child: const Text("Register"),
              ),
              const SizedBox(height: 16),

              // Register with Google
              OutlinedButton(
                onPressed: () {
                  // TODO: Implement Google Sign-In
                },
                child: const Text("Register with Google"),
              ),
              const SizedBox(height: 16),

              // Back to Login
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
