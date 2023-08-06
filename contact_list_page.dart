import 'package:first_flutter_project/ui/contact/contact_create_page.dart';
import 'package:first_flutter_project/ui/contactList/widget/contact_tile.dart';
import 'package:first_flutter_project/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: use_key_in_widget_constructors
class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: ScopedModelDescendant<ContactsModel>(
          builder: (context, child, model) {
        print(model.contacts);
        if (model.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: model.contacts!.length,
            // Runs & bluids every single list item
            itemBuilder: (context, index) {
              return ContactTile(
                contactIndex: index,
                /*contact: _contacts[index],
                onFavoritePressed: () {
                  setState(() {
                    _contacts[index].isFavorite = !_contacts[index].isFavorite;
                    _sortContacts();
                  });
                },*/
              );
              /*
              ListTile(
                title: Text(_contacts[index].name),
                subtitle: Text(_contacts[index].email),
                trailing: IconButton(
                  icon: Icon(
                    _contacts[index].isFavorite ? Icons.star : Icons.star_border,
                    color:
                        _contacts[index].isFavorite ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _contacts[index].isFavorite = !_contacts[index].isFavorite;
        
                      _sortContacts();
                    });
                  },
                ),
              );
               Center(
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  faker.Person(faker.RandomGenerator()).firstName() +
                      ' ' +
                      faker.Person(faker.RandomGenerator()).lastName(),
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 30),
                ),
              );
            */
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => contactCreatePage()),
          );
        },
      ),
    );
  }
}
