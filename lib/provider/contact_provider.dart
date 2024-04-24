import 'package:contact_application/db/db_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contacts = [];
  final db = DbHelper();

  Future<int> addContacts(ContactModel contact) async {
    final id = await db.insertContact(contact);
    await getContacts();
    return id;
  }

  Future<int> updateSingleContactValue(int rowId, String column, dynamic value) async {
    final id = await db.updateSingleContactValue(rowId, {column: value});
    await getContacts();
    return id;
  }

  Future<void> getContacts() async {
    contacts = await db.getContacts();
    notifyListeners();
  }
}