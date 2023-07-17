import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/Screens/ChatPage.dart';
import 'package:message_application/Screens/viewUserProfile.dart';
import 'package:message_application/main.dart';

class ProfileDialog extends StatelessWidget {
  final ChatUser user;

  const ProfileDialog({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        width: mq.width * 0.3,
        height: mq.height * 0.4,
        child: Stack(
          children: [
            Positioned(
              top: mq.height * .075,
              left: mq.width * .1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  width: mq.height * .25,
                  height: mq.height * .25,
                  fit: BoxFit.cover,
                  imageUrl: user.image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
            ),

            //user name
            Positioned(
              left: mq.width * .04,
              top: mq.height * .02,
              width: mq.width * .55,
              child: Text(user.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500 )),
            ),

            //info button
            // Positioned(
            //     right: 15,
            //     top: 6,
            //     child: MaterialButton(
            //       onPressed: () {
            //         //for hiding image dialog
            //         Navigator.pop(context);
            //
            //         //move to view profile screen
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (_) => ViewUserProfile(user: user)));
            //       },
            //       minWidth: 0,
            //       padding: const EdgeInsets.all(0),
            //       shape: const CircleBorder(),
            //       child: const Icon(Icons.info_outline,
            //           color: Colors.blue, size: 30),
            //     )),

            Positioned(
              bottom: 0,
              width: mq.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  // SizedBox(
                  //   width: mq.width * 0.13,
                  // ),
                  MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatPage(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.chat_outlined,
                        color: Colors.blue, size: 30),
                  ),
                  // SizedBox(
                  //   width: mq.width * 0.2,
                  // ),
                  MaterialButton(
                    onPressed: () {
                      //for hiding image dialog
                      Navigator.pop(context);

                      //move to view profile screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewUserProfile(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
