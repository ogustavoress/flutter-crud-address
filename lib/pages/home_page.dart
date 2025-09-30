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
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Endereços"),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final addr = addresses[index];
          return ListTile(
            title: Text(addr.nomeUsuario),
            subtitle: Text(
                "${addr.logradouro}, ${addr.bairro}, "
                "${addr.cidade}/${addr.uf},"
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => goToForm(address: addr),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchAddresses() async {
    final response = await http.get(Uri.parse(ApiConfig.addresses()));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        addresses = data.map((e) => Address.fromJson(e)).toList();
      });
    }
  }

  void goToForm({Address? address}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddressFormPage(address: address)),
    );
    fetchAddresses();
  }
}


