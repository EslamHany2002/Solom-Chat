import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/main.dart';

class ShowImage extends StatelessWidget{
  final ChatUser user;
  const ShowImage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      content: Container(
        color: Colors.red,
        child: CachedNetworkImage(
          width: mq.width * 1,
          height: mq.height * 0.5,
          fit: BoxFit.cover,
          imageUrl: user.image,
          errorWidget: (context, url, error) =>
          const CircleAvatar(
              child: Icon(CupertinoIcons.person)),
        ),
      ),
    );
  }

}