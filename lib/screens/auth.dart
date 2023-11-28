import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_station_app/widgets/bottom_nav.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/travel.png',
                height: 100,
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16.0),
            if (!isLogin)
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (isLogin) {
                  // Handle login
                  bool success = await loginUser(username, password);
                  if (success) {
                    // Navigate to the home screen or perform other actions
                    print('Login successful!');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  } else {
                    // Handle login failure
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromARGB(255, 160, 90, 165),
                      content: Text('Login failed. Invalid credentials.'),
                    ));
                  }
                } else {
                  // Handle signup
                  String confirmPassword = _confirmPasswordController.text;
                  if (password == confirmPassword) {
                    bool success = await signupUser(username, password);
                    if (success) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => BottomNav()));
                    } else {
                      // Handle signup failure
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 160, 90, 165),
                        content: Text('Signup failed. User already exists.'),
                      ));
                    }
                  } else {
                    // Passwords don't match
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Color.fromARGB(255, 160, 90, 165),
                      content: Text('Passwords do not match.'),
                    ));
                  }
                }
              },
              child: Text(isLogin ? 'Login' : 'Sign up'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                  isLogin ? 'Not a user? Sign up' : 'Already a user? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> loginUser(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(username);

    if (savedPassword != null && savedPassword == password) {
      return true; // Login successful
    } else {
      return false; // Invalid credentials
    }
  }

  Future<bool> signupUser(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(username);

    if (savedPassword == null) {
      // User doesn't exist, save the password
      prefs.setString(username, password);
      return true; // Signup successful
    } else {
      return false; // User already exists
    }
  }
}
