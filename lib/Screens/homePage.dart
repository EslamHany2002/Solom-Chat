import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:message_application/Api/Apis.dart';
import 'package:message_application/Helper/Dialog.dart';
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/Screens/Profile_page.dart';
import 'package:message_application/Screens/Setting.dart';
import 'package:message_application/Widgets/chat_card.dart';
import 'package:message_application/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateProfilStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateProfilStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgroud.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            // backgroundColor: Color(0xff7354cb),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // flexibleSpace: Container(
              //   // decoration: BoxDecoration(
              //   //   image: DecorationImage(image: AssetImage('assets/backgroud.jpg'),fit: BoxFit.cover,)
              //   // ),
              // ),
              // backgroundColor: Color(0xff7354cb),
              elevation: 0,
              toolbarHeight: 80,
              leading: Container(
                width: 50,
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Profile_page(
                                  user: APIs.me,
                                )));
                  },
                ),
              ),
              // leading: IconButton(
              //   iconSize: 30,
              //   icon: const Icon(Icons.dehaze_rounded),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Setting()));
              //   },
              // ),
              title: _isSearching
                  ? TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name , Email ....',
                          hintStyle: TextStyle(color: Colors.white)),
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.6,
                          color: Colors.white),
                      onChanged: (val) {
                        _searchList.clear();

                        for (var i in _list) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(val.toLowerCase())) {
                            _searchList.add(i);
                          }
                          setState(() {
                            _searchList;
                          });
                        }
                      },
                    )
                  : const Text("Message"),
              centerTitle: true,
              actions: [
                Container(
                  width: 50,
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(_isSearching
                        ? CupertinoIcons.clear_circled
                        : Icons.search),
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                  ),
                ),
              ],
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white70,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: APIs.getmyUserId(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );

                            case ConnectionState.active:
                            case ConnectionState.done:
                              return StreamBuilder(
                                  stream: APIs.getAllUsers(snapshot.data?.docs
                                          .map((e) => e.id)
                                          .toList() ??
                                      []),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                      case ConnectionState.none:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );

                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        final data = snapshot.data?.docs;
                                        _list = data
                                                ?.map<ChatUser>((e) =>
                                                    ChatUser.fromJson(e.data()))
                                                .toList() ??
                                            [];

                                        if (_list.isNotEmpty) {
                                          return ListView.builder(
                                            itemCount: _isSearching
                                                ? _searchList.length
                                                : _list.length,
                                            padding: EdgeInsets.only(
                                                top: mq.height * .01),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Person(
                                                  user: _isSearching
                                                      ? _searchList[index]
                                                      : _list[index]);
                                              // return Text("Name: ${list[index]}");
                                            },
                                          );
                                        } else {
                                          return const Center(
                                            child: Text(
                                              "No Connections Found !",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          );
                                        }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  });
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {
                  _addChatUser();
                },
                child: const Icon(
                  Icons.add_comment_rounded,
                ),
                backgroundColor: const Color(0xff335061),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addChatUser() {
    String email = '';
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(" Add User")
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    if (email.isNotEmpty) {
                      await APIs.addChatUser(email).then((value) {
                        if (!value) {
                          Dialogs.showSnackbar(
                              context, 'User does not Exists!');
                        }
                      });
                    }

                    // APIs.updateMessage(widget.message, updateMsg);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ));
  }
}
