import 'package:flutter/material.dart';
import 'package:train_station_app/screens/home.dart';
import 'package:train_station_app/screens/main_journey_list.dart';
import 'package:train_station_app/screens/main_packing_list.dart';

import '../screens/members.dart';
import '../screens/stations.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 150,
          child: const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 98, 74, 155),
            ),
            child: Text(
              'KELOMPOK 6',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                )); // Close the drawer
          },
        ),
        ListTile(
          title: const Text('Station Lists'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StationsScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('My Journey List'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainJourney()),
            );
          },
        ),
        ListTile(
          title: const Text('My Packing List'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPacking()),
            );
          },
        ),
        ListTile(
          title: const Text('Group Members'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MembersScreen()),
            );
          },
        ),
      ],
    ),
  );
}
