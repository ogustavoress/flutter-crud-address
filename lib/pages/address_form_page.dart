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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}