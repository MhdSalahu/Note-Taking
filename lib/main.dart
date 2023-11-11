import 'package:flutter/material.dart';
import 'package:note_taking/provider.dart';

import 'home_page.dart';
import 'package:provider/provider.dart';

void main() {

  NoteData noteDataProvider(BuildContext context) {
    return Provider.of<NoteData>(context, listen: false);
  }


  runApp( ChangeNotifierProvider(
      create: (context) => NoteData(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

