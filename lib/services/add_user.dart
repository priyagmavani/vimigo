import 'package:flutter/material.dart';

import '../screens/card.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final namecontroller = TextEditingController();
  final _nameformKey = GlobalKey<FormState>(debugLabel: 'Name');
  final phonecontroller = TextEditingController();
  final _phoneformKey = GlobalKey<FormState>(debugLabel: 'Phone');

  @override
  void initState() {
    namecontroller.text = '';
    phonecontroller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.03, horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _nameformKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: namecontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Cant be empty';
                  }
                  return null;
                },
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    height: 1,
                    color: Colors.red,
                  ),
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Form(
              key: _phoneformKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: phonecontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Cant be empty';
                  }
                  return null;
                },
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                decoration: const InputDecoration(
                  labelText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    height: 1,
                    color: Colors.red,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.015, horizontal: width * 0.08),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shadowColor: Colors.grey[400],
                elevation: 7,
              ),
              onPressed: () {
                if (validatephone(phonecontroller.text)) {
                  setState(() {
                    addCardList(namecontroller.text, phonecontroller.text,
                        DateTime.now().toString(), context);
                  });
                  Navigator.pop(context);
                } else {
                  (ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red[900],
                      content: const Text('Enter a valid phone number'))));
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool validatephone(String? value) {
  String pattern = r'^(01)[0-46-9]*[0-9]{8,9}$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}
