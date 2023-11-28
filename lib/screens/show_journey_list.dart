import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:train_station_app/screens/create_journey_list.dart';
import 'package:train_station_app/screens/detail_journey_list.dart';
import 'package:train_station_app/widgets/drawer.dart';

import '../models/list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<ListModel>(ListModelAdapter());
  await Hive.openBox<ListModel>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JourneyListScreen(),
    );
  }
}

class JourneyListScreen extends StatefulWidget {
  const JourneyListScreen({super.key});

  @override
  State<JourneyListScreen> createState() => _JourneyListScreenState();
}

class _JourneyListScreenState extends State<JourneyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
        centerTitle: true,
        title: const Text(
          'JOURNEY LIST',
        ),
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<ListModel>('todos').listenable(),
          builder: (context, Box<ListModel> box, _) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, i) {
                final todos = box.getAt(i);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ViewJourneyScreen(
                              list: todos.title,
                              destination: todos.destination,
                              description: todos.description,
                              imageUrl: todos.imageUrl,
                            ),
                          ),
                        );
                      },
                      leading: Image.file(
                        File(
                          todos!.imageUrl.toString(),
                        ),
                      ),
                      title: Text(todos.destination.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          box.deleteAt(i);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddJourneyScreen(),
            ),
          );
        },
        label: const Text('+ | Add Journey'),
      ),
    );
  }
}
