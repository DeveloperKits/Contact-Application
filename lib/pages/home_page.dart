import 'package:contact_application/models/contact_model.dart';
import 'package:contact_application/pages/new_contact_page.dart';
import 'package:contact_application/provider/contact_provider.dart';
import 'package:contact_application/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int indexValue = 0;
  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    if(isFirstTime){
      context.read<ContactProvider>().getContacts();
      isFirstTime = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 10.0,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              indexValue = index;
            });

            _loadData(index);
          },
          currentIndex: indexValue,
          backgroundColor: Colors.amberAccent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              label: 'All Contacts',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite Contacts',
            ),
          ],
        ),
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

  void _loadData(int index) {
    if(index == 0){
      context.read<ContactProvider>().getContacts();
    }else{
      context.read<ContactProvider>().getFavoriteContacts();
    }
  }
}
