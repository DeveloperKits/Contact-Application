import 'package:contact_application/models/contact_model.dart';
import 'package:contact_application/pages/new_contact_page.dart';
import 'package:contact_application/provider/contact_provider.dart';
import 'package:contact_application/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    context.read<ContactProvider>().getContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
        child: const Icon(Icons.add),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.contacts.length,
            itemBuilder: (context, index) {
              final contact = value.contacts[index];
              return Dismissible(
                key: ValueKey(contact.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) {
                  return showMyDialog(context);
                },
                onDismissed: (_) {
                  context.read<ContactProvider>().deleteSingleContact(contact.id!);
                },
                child: ListTile(
                  title: Text(contact.name),
                  trailing: IconButton(
                    onPressed: () {
                      final value = contact.favorite ? 0 : 1;
                      context.read<ContactProvider>()
                          .updateSingleContactValue(contact.id!, colFavorite, value);
                    },
                    icon: Icon(contact.favorite ? Icons.favorite : Icons.favorite_border),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
