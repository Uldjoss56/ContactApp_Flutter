import 'dart:io';

class Contact {
  late int idContact;

  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  File? imageFile;

  //Constructor
  Contact({
    // required makes sure that an optional parameter is actually
    //                       passed in
    required this.email,
    required this.name,
    required this.phoneNumber,
    this.isFavorite = false,
    this.imageFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite ? 1 : 0,
      'imageFilePath': imageFile?.path,
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      isFavorite: map['isFavorite'] == 1 ? true : false,
      imageFile:
          map['imageFilePath'] != null ? File(map['imageFilePath']) : null,
    );
  }
}
