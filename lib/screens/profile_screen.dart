import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(title: const Text('Profile')),
      body: const ProfileCard(
        name: 'Hafidz',
        imageUrl: 'https://i.imgur.com/n5bXf86.jpeg',
      ),
    );
  }
}
