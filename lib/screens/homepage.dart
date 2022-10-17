import 'package:flutter/material.dart';
import 'package:vimigo_assessment/routes/routes.dart';
import '../utilities/contact_data.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  HomePage(this.animation, {super.key});
  var animation;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> cardList = [];
  List<String> userList = [];
  List<Widget> contactsFiltered = [];
  bool isDescending = false;
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    searchcontroller.addListener(() {
      filterContacts();
    });
    super.initState();
  }

  filterContacts() {
    List<Widget> _contacts = [];
    _contacts.addAll(cardList);
    if (searchcontroller.text.isNotEmpty) {
      _contacts.retainWhere((cardList) {
        String searchTerm = searchcontroller.text.toLowerCase();
        String contactName = cardList.toString().toLowerCase();
        return contactName.contains(searchTerm);
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    cardList = initialiseCardList(contact_data, context);
    userList = userName(contact_data, context);
    bool isSearching = searchcontroller.text.isNotEmpty;

    // print(userList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vimigo Assessment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: width * 0.7,
                            child: TextFormField(
                              controller: searchcontroller,
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
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.15,
                            child: TextButton.icon(
                              icon: const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.compare_arrows,
                                  size: 28,
                                ),
                              ),
                              label: const Text(''),
                              onPressed: () {
                                setState(() {
                                  isDescending = !isDescending;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.7,
                      width: width,
                      child: ListView.builder(
                          itemCount:
                              // isSearching == true
                              //     ? contactsFiltered.length
                              //     :
                              cardList.length,
                          itemBuilder: (BuildContext context, index) {
                            // final sortedList = cardList.sort(
                            //     (cardList1, cardlist2) =>
                            //         cardlist2.compareTo(cardList1));
                            // final list = isSearching == true
                            //     ? contactsFiltered[index]
                            //     : cardList[index];
                            return cardList[index];
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.015),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                              horizontal: width * 0.08),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shadowColor: Colors.grey[400],
                          elevation: 7,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(addUserRoute);
                        },
                        child: const Text('Add User'),
                      ),
                    ),
                  ],
                ),
                widget.animation,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
