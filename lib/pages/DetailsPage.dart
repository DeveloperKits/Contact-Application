import 'dart:io';

import 'package:contact_application/provider/contact_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/contact_model.dart';
import '../utils/helper_function.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static const String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final contactModel = ModalRoute.of(context)!.settings.arguments as ContactModel;
    final contact = Provider.of<ContactProvider>(context).getContactFromCache(contactModel.id!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),

      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView(
          children: [
            profileImage(context, contact), // profile image
            const SizedBox(height: 20,),

            ListTile(
              title: Text(contact.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),

            ListTile(
              title: Text(contact.mobile),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {_callNumber(context, contact);},
                    icon: const Icon(Icons.call),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column profileImage(BuildContext context, ContactModel contactData) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(fit: StackFit.expand, children: [
            contactData.image == null || contactData.image!.isEmpty
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage('images/no_image_placeholder.png'),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(File(contactData.image!)),
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                child: FloatingActionButton(
                  mini: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: Colors.white)),
                  backgroundColor: Colors.grey.shade50,
                  onPressed: () {updateImage(context, ImageSource.camera, contactData);},
                  child: const Icon(Icons.camera),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  void updateImage(BuildContext context, ImageSource type, ContactModel contactData) async {
    final image = await ImagePicker().pickImage(source: type);
    if(image != null) {
      context.read<ContactProvider>().updateSingleContactValue(contactData.id!, colImage, image.path);
    }
  }

  Future<void> _callNumber(BuildContext context, ContactModel contact) async {
    final url = 'tel:${contact.mobile}';
    if(await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }else{
      showMsg("Could not launch $url", context);
    }
  }

  /*FutureBuilder<ContactModel> demoFutureBuilder(ContactProvider provider, ContactModel contact) {
    return FutureBuilder<ContactModel>(
      future: provider.getContactById(contact.id!),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final contactData = snapshot.data!;
          return ListView(
            children: [
              profileImage(contactData), // profile image
              const SizedBox(height: 20,),

              ListTile(
                title: Text(contactData.name),
                trailing: IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.edit),
                ),
              )
            ],
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
    );
  }*/
}



