import 'package:first_flutter_project/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class contactCreatePage extends StatelessWidget {
//  const contactCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text("Create")),
      body: ContactForm(),
    );
  }
}
