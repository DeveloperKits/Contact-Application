import 'dart:io';

import 'package:contact_application/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static const String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),

      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => FutureBuilder<ContactModel>(
          future: provider.getContactById(contact.id!),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final contactData = snapshot.data!;
              return ListView(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        contactData.image == null || contactData.image!.isEmpty?
                        const CircleAvatar(
                          backgroundImage: AssetImage('images/no_image_placeholder.png'),
                        )
                        : CircleAvatar(
                          backgroundImage: FileImage(contactData.image! as File),
                        ),

                        SizedBox(
                          height: 45,
                          width: 45,
                          child: FloatingActionButton(
                            onPressed: () {

                            },
                            child: const Icon(Icons.camera),
                          ),
                        )
                      ]
                    ),
                  ),
                  ListTile(
                    title: Text(contactData.name),
                    trailing: IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.edit),
                    ),
                  )
                ]
              );
            }

            if(snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ),
    );
  }
}
