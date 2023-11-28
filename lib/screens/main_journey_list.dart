import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:train_station_app/models/list.dart';

import 'show_journey_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<ListModel>(ListModelAdapter());
  await Hive.openBox<ListModel>('todos');

  runApp(const MainJourney());
}

class MainJourney extends StatelessWidget {
  const MainJourney({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JourneyListScreen(),
    );
  }
}
