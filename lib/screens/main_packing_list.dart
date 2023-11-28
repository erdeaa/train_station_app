import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:train_station_app/models/list.dart';

import 'show_packing_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ListModelAdapter());
  await Hive.openBox<ListModel>('todos');

  runApp(const MainPacking());
}

class MainPacking extends StatelessWidget {
  const MainPacking({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowPackingList(),
    );
  }
}
