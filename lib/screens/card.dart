import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vimigo_assessment/screens/contact_details.dart';
import 'package:vimigo_assessment/utilities/contact_data.dart';

List<Widget> initialiseCardList(
  String contactData,
  BuildContext context,
) {
  List<Widget> cardList = [];
  List<dynamic> parsedcontact = jsonDecode(contactData);

  for (int i = 0; i < parsedcontact.length; i++) {
    final useri = parsedcontact[i]['user'];
    final phonei = parsedcontact[i]['phone'];
    final datetimei = parsedcontact[i]['check-in'];
    cardList.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[800],
          ),
          child: ListTile(
            title: Text(
              useri,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              phonei,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            leading: const Icon(
              Icons.account_circle_rounded,
              size: 40,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetails(
                    user: useri,
                    datetime: datetimei,
                    phonenum: phonei,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  return cardList;
}

String addCardList(
    String user, String phoneNum, String dateTime, BuildContext context) {
  final newparsedcontact;
  List<dynamic> parsedcontact = jsonDecode(contact_data);
  parsedcontact.add("""  {
    "user": "$user",
    "phone": "$phoneNum",
    "check-in": "$dateTime"
  },""");
  newparsedcontact = jsonEncode(parsedcontact);
  contact_data = newparsedcontact;
  return contact_data;
}

List<String> userName(
  String contactData,
  BuildContext context,
) {
  List<String> userList = [];
  List<dynamic> parsedcontact = jsonDecode(contactData);
  for (int i = 0; i < parsedcontact.length; i++) {
    final useri = parsedcontact[i]['user'];

    userList.add(useri);
  }
  return userList;
}
