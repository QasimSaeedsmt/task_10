import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_10/businessLogic/bloc/alarmBloc/alarm_bloc.dart';
import 'package:task_10/constants/common_keys.dart';
import 'package:task_10/data/data_model/alarm_model.dart';
import 'package:task_10/presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(AlarmModelAdapter());
  await Hive.openBox<AlarmModel>(CommonKeys.HIVE_BOX_NAME);
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlarmBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: false),
        home: const HomeScreen(),
      ),
    );
  }
}
