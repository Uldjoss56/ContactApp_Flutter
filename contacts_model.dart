import 'package:first_flutter_project/data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/contact.dart';

class ContactsModel extends Model {
  final ContactDao _contactDao = ContactDao();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future loadContacts() async {
    _isLoading = true;
    notifyListeners();

    _contacts = await _contactDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  List<Contact>? _contacts;
  /*= List.generate(5, (index) {
    return Contact(
      email: faker.Internet(faker.RandomGenerator()).freeEmail(),
      // ignore: prefer_interpolation_to_compose_strings
      name: faker.Person(faker.RandomGenerator()).firstName() +
          ' ' +
          faker.Person(faker.RandomGenerator()).lastName(),
      phoneNumber: faker.RandomGenerator().integer(1000000).toString(),
    );
  });*/

//Get only property, makes sure that we can't overwrite contacts
// from different classes
  List<Contact>? get contacts => _contacts;

  Future changeFavoriteStatus(Contact contact) async {
    // _contacts?[index].isFavorite = !_contacts![index].isFavorite;
    //_sortContacts();
    contact.isFavorite = !contact.isFavorite;
    await _contactDao.update(contact);
    _contacts = await _contactDao.getAllInSortedOrder();
    notifyListeners();
  }

  /*void _sortContacts() {
    _contacts.sort((a, b) {
      int comparaisonResult;

      comparaisonResult = _compareBasedOnFavoriteStatus(a, b);
      if (comparaisonResult == 0) {
        comparaisonResult = _compareAlphabetically(a, b);
      }

      return comparaisonResult;
    });
  }*/

  Future addContact(Contact contact) async {
    //_contacts?.add(contact);
    await _contactDao.insert(contact);
    await loadContacts();
    notifyListeners();
  }

  Future updateContact(Contact contact) async {
    //_contacts![contactIndex] = contact;
    await _contactDao.update(contact);
    await loadContacts();
    notifyListeners();
  }

  Future deleteContact(Contact contact) async {
    //_contacts?.removeAt(index);
    await _contactDao.delete(contact);
    await loadContacts();
    notifyListeners();
  }

  /* int _compareBasedOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      return -1;
    } else if (b.isFavorite) {
      return 1;
    } else {
      return 0;
    }
  }

  int _compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }*/
}
