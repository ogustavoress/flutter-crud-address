import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddressApp extends StatelessWidget {
  const AddressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(AddressApp());
}