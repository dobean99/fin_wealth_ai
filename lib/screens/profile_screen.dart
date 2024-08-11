import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String avatarUrl =
      'https://example.com/avatar.png'; // Replace with actual avatar URL
  final String username = 'Do Do';
  final String status = 'Active';
  void _logout(BuildContext context) {
    // Implement your logout logic here, e.g., clearing user session, navigating to the login screen, etc.
    Navigator.of(context)
        .pushReplacementNamed('/login'); // Example: Navigate to login screen
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
