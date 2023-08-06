import 'package:first_flutter_project/data/contact.dart';
import 'package:first_flutter_project/ui/contact/contact_edit_page.dart';
import 'package:first_flutter_project/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.contactIndex,
    //required this.onFavoritePressed,
  }) : super(key: key);

  final int contactIndex;

  //final Contact contact;
  //final void Function() onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<ContactsModel>(context);
    final displayContact = model.contacts![contactIndex];
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.green,
            icon: Icons.phone,
            label: 'Call',
            onPressed: (context) =>
                _callPhoneNumber(context, displayContact.phoneNumber),
          ),
          SlidableAction(
            backgroundColor: Colors.blue,
            icon: Icons.email,
            label: 'Email',
            onPressed: (context) => _writeEmail(
              context,
              displayContact.email,
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Supprimer',
            onPressed: (context) {
              model.deleteContact(displayContact);
            },
          ),
        ],
      ),
      child: ListTile(
        title: Text(displayContact.name),
        subtitle: Text(displayContact.email),
        leading: buildCircleAvatar(displayContact),
        trailing: IconButton(
          icon: Icon(
            displayContact.isFavorite ? Icons.star : Icons.star_border,
            color: displayContact.isFavorite ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            model.changeFavoriteStatus(displayContact);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => contactEditPage(
                editedContact: displayContact,
                //editedContactIndex: contactIndex,
              ),
            ),
          );
        },
      ),
    );
  }

  Future _callPhoneNumber(
    BuildContext context,
    String number,
  ) async {
    final url = 'tel:$number';
    if (await url_launcher.canLaunchUrl(url as Uri)) {
      await url_launcher.launchUrl(url as Uri);
    } else {
      const snackbar = SnackBar(
        content: Text('Can\'t make a call'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future _writeEmail(
    BuildContext context,
    String emailAddress,
  ) async {
    final url = 'mailto:$emailAddress';
    if (await url_launcher.canLaunchUrl(url as Uri)) {
      await url_launcher.launchUrl(url as Uri);
    } else {
      const snackbar = SnackBar(
        content: Text('Can\'t write a message'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Hero buildCircleAvatar(Contact displayContact) {
    return Hero(
      tag: displayContact.hashCode,
      child: CircleAvatar(
        child: _buildCircleAvatarContent(displayContact),
      ),
    );
  }

  Widget _buildCircleAvatarContent(Contact displayContact) {
    if (displayContact.imageFile == null) {
      return Text(
        displayContact.name[0],
      );
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            displayContact.imageFile!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
