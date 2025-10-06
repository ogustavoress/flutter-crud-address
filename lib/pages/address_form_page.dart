import 'dart:convert';
import 'dart:ffi';

import 'package:crud_address_app/api_config.dart';
import 'package:crud_address_app/model/address.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AddressFormPage extends StatefulWidget {
  final Address? address;

  const AddressFormPage({super.key, this.address});

  @override
  State<AddressFormPage> createState() =>
    _AddressFormPageState();

}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.address!= null) {
      nomeController.text = widget.address!.nomeUsuario;
      logradouroController.text = widget.address!.logradouro;
      bairroController.text = widget.address!.bairro;
      cepController.text = widget.address!.cep;
      cidadeController.text = widget.address!.cidade;
      ufController.text = widget.address!.uf;
    }
  }

  Future<void> saveAddress() async {
    if(_formKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        "nomeUsuario": nomeController.text,
        "logradouro": logradouroController.text,
        "bairro": bairroController.text,
        "cidade": cidadeController.text,
        "uf": ufController.text,
      };

      if (widget.address ==null) {
        await http.post(
          Uri.parse(ApiConfig.addresses()),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data),
        );
      } else{
        await http.put(
          Uri.parse(ApiConfig.addressById(widget.address!.id as Int)),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data),
        );
      }

      if (mounted) Navigator.pop(context);
      else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Falha ao salvar')));
      }
    }
  }

  Future<void> deleteAddress() async {
    if(widget.address == null) {
      return;
    }
    final response = await http.delete(
      Uri.parse(ApiConfig.addressById(widget.address!.id as Int)),
    );

    if(response.statusCode == 200) {
      if(mounted) Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Erro ao excluir endereço")
      ));
    }
  }
  Future<bool> showConfirmDialog(BuildContext context) async {
    return await showDialog<bool> (
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Deseja realmente excluir esse endereço?"),
        actions: [
          TextButton(
              onPressed: Navigator.pop(ctx, false),
              child: const Text("Excluir"),
          ),
        ],
      ),
    ) ??
    false;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar endereço" : "Novo endereço"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do usuário",
                ),
                validator: (v) => (v == null || v.isEmpty) ? 'Preencha o nome' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cepController,
                      decoration: const InputDecoration(labelText: "CEP"),
                    ),
                  ),
                  IconButton(
                    onPressed: fetchCep,
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              TextFormField(
                controller: logradouroController,
                decoration: const InputDecoration(labelText: "Logradouro"),
                validator: (v) => (v == null || v.isEmpty) ? 'Preencha o logradouro' : null,
              ),
              TextFormField(
                controller: bairroController,
                decoration: const InputDecoration(labelText: "Bairro"),
                validator: (v) => (v == null || v.isEmpty) ? 'Preencha o bairro' : null,
              ),
              TextFormField(
                controller: cidadeController,
                decoration: const InputDecoration(labelText: "Cidade"),
                validator: (v) => (v == null || v.isEmpty) ? 'Preencha a cidadde' : null,
              ),
              TextFormField(
                controller: ufController,
                decoration: const InputDecoration(labelText: "UF"),
                validator: (v) => (v == null || v.isEmpty) ? 'Preencha o UF' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveAddress,
                child: const Text("Salvar"),
              )
            ],
          )
        ),
      ),
    );
  }
}