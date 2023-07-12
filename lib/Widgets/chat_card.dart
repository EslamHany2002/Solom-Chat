import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_application/Api/Apis.dart';
import 'package:message_application/Helper/My_Date.dart';
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/Models/message.dart';
import 'package:message_application/Screens/ChatPage.dart';
import 'package:message_application/Widgets/profile_Dialog.dart';

import 'package:message_application/main.dart';

class Person extends StatefulWidget {
  final ChatUser user;

  const Person({super.key, required this.user});
  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
      // color: Colors.red,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, AsyncSnapshot snapshot) {
              final data = snapshot.data?.docs;
              final list = data
                      ?.map<Message>((e) => Message.fromJson(e.data()))
                      .toList() ??
                  [];
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                // leading: CircleAvatar(child: Icon(CupertinoIcons.person),
                // ),
                leading: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (_) => ProfileDialog(user: widget.user,));
                  },
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(mq.height * .3),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: mq.height * 0.055,
                      height: mq.height * 0.055,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) =>
                          const CircleAvatar(child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                ),
                title: Text(widget.user.name),
                subtitle: Text(
                  _message != null ?
                  _message!.type == Type.image ? 'image' :
                  _message!.msg : widget.user.about,
                  maxLines: 1,
                ),
                trailing: _message == null
                    ? null
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        : Text(
                            My_Date.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            },
          )),
    );
  }
}
