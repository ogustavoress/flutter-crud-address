import 'dart:convert';

import 'package:crud_address_app/api_config.dart';
import 'package:crud_address_app/model/address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Address> address = [];

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> fetchAddresses() async {
    final response = await http.get(Uri.parse(ApiConfig.addresses()));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        address = data.map((e) => Address.fromJson(e)).toList();
      });
    }
  }
}


