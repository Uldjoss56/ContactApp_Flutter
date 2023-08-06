import 'package:first_flutter_project/data/contact.dart';
import 'package:first_flutter_project/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class contactEditPage extends StatelessWidget {
//  const contactCreatePage({super.key});
  final Contact editedContact;
  //final int editedContactIndex;

  // ignore: prefer_const_constructors_in_immutables
  contactEditPage({
    Key? key,
    required this.editedContact,
    //required this.editedContactIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text("Edit")),
      body: ContactForm(
        editedContact: editedContact,
        //editedContactIndex: editedContactIndex,
      ),
    );
  }
}
