import 'dart:io';

import 'package:flutter/material.dart';

class ViewJourneyScreen extends StatelessWidget {
  final String? list;
  final String? destination;
  final String? description;
  final String? imageUrl;

  const ViewJourneyScreen({
    Key? key,
    @required this.list,
    @required this.destination,
    @required this.description,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DETAIL JOURNEY'),
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                destination.toString(),
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              Image.file(
                File(imageUrl!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
