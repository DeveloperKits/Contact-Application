import 'package:flutter/material.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});
  static const String routeName = '/new_contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {

  final fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveContact,
          )
        ],
      ),

      body: Form(
        key: fromKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Contact Name (required)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter a contact name';
                }
                return null;
              },
            ),

            const SizedBox(height: 10.0,),

            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact Number (required)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter a contact name';
                }
                return null;
              },
            ),

            const SizedBox(height: 10.0,),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 10.0,),

            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    if(fromKey.currentState!.validate()){
      final name = nameController.text;
      final number = numberController.text;
      final email = emailController.text;
      final address = addressController.text;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
