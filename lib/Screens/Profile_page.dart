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
import 'package:message_application/Models/chat_users.dart';
import 'package:message_application/Screens/auth/login_screen.dart';
import 'package:message_application/Screens/homePage.dart';
import 'package:message_application/Widgets/show_Image.dart';

import '../main.dart';

class Profile_page extends StatefulWidget {
  final ChatUser user;

  const Profile_page({super.key, required this.user});
  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

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

            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //     image: AssetImage('assets/backgroud.jpg'),
            //     fit: BoxFit.cover,
            //   )),
            // ),
            // backgroundColor: Color(0xff7354cb),
            elevation: 0.0,
            toolbarHeight: 80,
            leading: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            title: const Text("My Profile"),
            centerTitle: true,
          ),
          body: Container(
            decoration:const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white70,
            ),
            child: ListView(children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: mq.height * .02,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(mq.height * .1),
                                    child: Image.file(
                                      File(_image!),
                                      width: mq.height * 0.2,
                                      height: mq.height * 0.2,
                                      fit: BoxFit.cover,
                                    ))
                                : InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (_) => ShowImage(user: widget.user,));
                              },
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(mq.height * .1),
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
                                ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: MaterialButton(
                                onPressed: () {
                                  _showButtonSheet();
                                },
                                elevation: 1,
                                shape: const CircleBorder(),
                                color: Colors.white,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: mq.height * .03,
                        ),
                        Text(
                          widget.user.email,
                          style: const TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        SizedBox(
                          height: mq.height * .06,
                        ),
                        TextFormField(
                          initialValue: widget.user.name,
                          onSaved: (val) => APIs.me.name = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                              ? null
                              : 'Requierd Field',
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xff335061),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'solom chat',
                            label: const Text("Name"),
                          ),
                        ),
                        SizedBox(
                          height: mq.height * .03,
                        ),
                        TextFormField(
                          initialValue: widget.user.about,
                          onSaved: (val) => APIs.me.about = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                              ? null
                              : 'Requierd Field',
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.info_outline,
                              color: Color(0xff335061),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'hey, i am using Solom Chat',
                            label: const Text("About"),
                          ),
                        ),
                        SizedBox(
                          height: mq.height * .03,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              APIs.updateUserInfo().then((value) {
                                Dialogs.showSnackbar(
                                    context, 'Profle Update Successfully');
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: Size(mq.width * .5, mq.height * 0.06)),
                          icon: const Icon(
                            Icons.edit,
                            size: 28,
                          ),
                          label: const Text(
                            "UPDATE",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
              label: const Text("Logout"),
              icon: const Icon(Icons.logout),
              onPressed: () async {
                Dialogs.showProgressBar(context);

                await APIs.updateProfilStatus(false);

                await APIs.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);

                    APIs.auth = FirebaseAuth.instance;

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login_Screen()));
                  });
                });
              },
              backgroundColor: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }

  void _showButtonSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * 0.05),
            children: [
              const Text("Pick your Profile Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * 0.15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          log('Image path: ${image.path} -- MimeType: ${image.mimeType}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilrPicture(File(_image!));

                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/image picker/add_image.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(mq.width * .3, mq.height * 0.15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          log('Image path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          APIs.updateProfilrPicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/image picker/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
