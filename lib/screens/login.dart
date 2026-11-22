import 'package:flutter/material.dart';
import 'dashboard.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isObscure = true;

  void _signIn(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      final String usernameEntered = _username.text.trim();

      _username.clear();
      _password.clear();

      final String? response = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(usernameEntered),
        ),
      );

      if (response != null) {
        debugPrint(response);
      }
    }
  }

  String? _validateUsername(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'Username is Invalid'
        : null;
  }

  String? _validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is Invalid'
        : null;
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 65,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Log In',
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 15),

              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: _username,
                        validator: _validateUsername,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: _password,
                        validator: _validatePassword,
                        obscureText: _isObscure,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _signIn(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                    ),
                    child: const Text('Log In'),
                  ),

                  const SizedBox(width: 25),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {},
                child: const Text('Forget Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}