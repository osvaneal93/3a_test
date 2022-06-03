import 'package:flutter/material.dart';
import 'package:prueba_3a/eat_view.dart';
import 'package:prueba_3a/matrix_view.dart';
import 'package:prueba_3a/ui/multirepoprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context)=> MatrixView(),
          "eatView/" : (context) => MultiRepoProvider()
        },
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        );
  }
}
