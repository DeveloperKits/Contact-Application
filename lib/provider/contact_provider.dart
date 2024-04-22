import 'package:contact_application/db/db_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contacts = [];
  final db = DbHelper();

  Future<int> addContacts(ContactModel contact) async {
    return await db.insertContact(contact);
  }

  Future<void> getContacts() async {
    contacts = await db.getContacts();
    notifyListeners();
  }
}