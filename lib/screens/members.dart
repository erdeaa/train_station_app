import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 74, 155),
        centerTitle: true,
        title: const Text(
          'KELOMPOK 6',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: buildDrawer(context),
      body: ListView(
        children: const [
          MemberCard(
            id: '124210026',
            name: 'Fathia Nur Rahmah',
            imageAssets: 'assets/images/profile1.png',
          ),
          MemberCard(
            id: '124210046',
            name: 'Rahmawati Dwi Augustin',
            imageAssets: 'assets/images/profile2.png',
          ),
          // Add more MemberCard widgets for additional members
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String id;
  final String name;
  final String imageAssets;

  const MemberCard({
    Key? key,
    required this.id,
    required this.name,
    required this.imageAssets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Member Image
          Container(
            height: 250.0, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAssets),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Member Name
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3.0),
            child: Text(
              name,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Member ID
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
            child: Text(
              id,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
