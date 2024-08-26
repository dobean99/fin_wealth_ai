import 'package:fin_wealth/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  final String avatarUrl =
      'https://example.com/avatar.png'; // Replace with actual avatar URL

  void _logout(BuildContext context) {
    // Implement your logout logic here, e.g., clearing user session, navigating to the login screen, etc.
    Navigator.of(context)
        .pushReplacementNamed('/login'); // Example: Navigate to login screen
  }

  const ProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // Convert the point to an integer for expiry calculation
    final int points = userData['point']?.toInt() ?? 0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(avatarUrl),
                    backgroundColor: Colors.black12,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userData['username'] ?? 'Unknown User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ngày hết hạn: ${DateFormatter.formatExpiryDate(points)}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
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
                child: const Text(
                  'Đăng xuất',
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
