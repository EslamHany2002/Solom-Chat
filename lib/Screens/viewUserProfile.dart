import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_application/Api/Apis.dart';
import 'package:message_application/Helper/Dialog.dart';
import 'package:message_application/Helper/My_Date.dart';
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/Screens/auth/login_screen.dart';
import 'package:message_application/Screens/homePage.dart';

import '../main.dart';

class ViewUserProfile extends StatefulWidget {
  final ChatUser user;

  const ViewUserProfile({super.key, required this.user});
  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
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
            elevation: 0.0,
            toolbarHeight: 80,

            title: const Text("Profile"),
            centerTitle: true,
          ),
          body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white70,
            ),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: mq.height * .02,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height * .1),
                        child: CachedNetworkImage(
                          width: mq.height * 0.2,
                          height: mq.height * 0.2,
                          fit: BoxFit.cover,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * .03,
                      ),

                      ListTile(
                        leading: Icon(Icons.email_outlined , color: Color(0xff335061), size: 35,),
                        title: Text("Email" , style: TextStyle(fontSize: 15),),
                        subtitle: Text(widget.user.email , style: TextStyle(fontSize: 16),),
                      ),

                      Container(
                        width: mq.width * 0.8,
                        height: 1,
                        color: Colors.black38,
                      ),

                      ListTile(
                        leading: Icon(Icons.person_outline , color: Color(0xff335061), size: 35,),
                        title: Text("Name" , style: TextStyle(fontSize: 15),),
                        subtitle: Text(widget.user.name , style: TextStyle(fontSize: 16),),
                      ),

                      Container(
                        width: mq.width * 0.8,
                        height: 1,
                        color: Colors.black38,
                      ),

                      ListTile(
                        leading: Icon(Icons.info_outline , color: Color(0xff335061), size: 35,),
                        title: Text("About" , style: TextStyle(fontSize: 15),),
                        subtitle: Text(widget.user.about , style: TextStyle(fontSize: 16),),
                      ),

                    ],
                  ),
                ),
              ),
            ]),
          ),

          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Joined on : " , style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16),),
              Text(My_Date.getLastMessageTime(context: context, time: widget.user.createdAt , showYear: true) , style: TextStyle(color: Colors.black54 , fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}
