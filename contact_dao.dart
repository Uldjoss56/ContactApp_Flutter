// contact_dao == contact data access object

import 'package:first_flutter_project/data/contact.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class ContactDao {
  //static const String CONTACT_STORE_NANE = 'contacts';

  final _contactStore = intMapStoreFactory.store('contacts');

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Contact contact) async {
    await _contactStore.add(
      await _db,
      contact.toMap(),
    );
  }

  Future update(Contact contact) async {
    final finder = Finder(
      filter: Filter.byKey(contact.idContact),
    );
    await _contactStore.update(
      await _db,
      contact.toMap(),
      finder: finder,
    );
  }

  Future delete(Contact contact) async {
    final finder = Finder(
      filter: Filter.byKey(contact.idContact),
    );
    await _contactStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Contact>> getAllInSortedOrder() async {
    final finder = Finder(sortOrders: [
      SortOrder('isFavorite', false),
      SortOrder('name'),
    ]);

    final recordSnapshots = await _contactStore.find(await _db, finder: finder);

    /*return recordSnapshots.map((snapshot) => Contact.fromMap(snapshot.value)
      ..id = snapshot.key).toList();*/

    return recordSnapshots.map((snapshot) {
      final contact = Contact.fromMap(snapshot.value);
      contact.idContact = snapshot.key;
      return contact;
    }).toList();
  }
}
