import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_demo/src/core/service_locator/sl.dart';
import 'package:football_demo/src/feature/scheduale/presentation/bloc/teams_bloc.dart';
import 'package:football_demo/src/feature/scheduale/presentation/view/schedule_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl.get<TeamsBloc>())],
      child: MaterialApp(
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const DashboardScreen(),
      ),
    );
  }
}
