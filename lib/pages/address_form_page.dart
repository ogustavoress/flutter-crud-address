import 'package:crud_address_app/model/address.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}