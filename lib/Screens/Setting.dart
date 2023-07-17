
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_application/Screens/homePage.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool light = true;
  bool light1 = false;
  bool light2 = true;
  bool light3 = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xff7354cb),
      appBar: AppBar(
        backgroundColor: const Color(0xff7354cb),
        elevation: 0.0,
        toolbarHeight: 70,
        leading: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            IconButton(
              iconSize: 30,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        ),
        title: const Text("Settings"),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          color: Colors.white,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0.0
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const SizedBox(
                      width: 33,
                    ),
                    const Text(
                      "Theme",
                      style: TextStyle(fontSize: 16 ,color: Colors.black),
                    ),
                    const SizedBox(
                      width: 180,
                    ),
                    IconButton(
                        iconSize: 17.5,
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios) , color: Colors.black,)
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0.0
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const SizedBox(
                      width: 33,
                    ),
                    const Text(
                      "Font Size",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 164,
                    ),
                    IconButton(
                        iconSize: 17.5,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ))
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const SizedBox(
                      width: 33,
                    ),
                    const Text(
                      "Delay Sending",
                      style: TextStyle(fontSize: 16 , color: Colors.black),
                    ),
                    const SizedBox(
                      width: 129,
                    ),
                    IconButton(
                        iconSize: 17.5,
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios) , color: Colors.black,)
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const SizedBox(
                      width: 33,
                    ),
                    const Text(
                      "Swipe Action",
                      style: TextStyle(fontSize: 16 , color: Colors.black),
                    ),
                    const SizedBox(
                      width: 137,
                    ),
                    IconButton(
                        iconSize: 17.5,
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios) , color: Colors.black,)
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text("Night Mode"),
                const SizedBox(
                  width: 140,
                ),
                Switch(
                  value: light,
                  activeColor: const Color(0xff7354cb),
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text("Notification"),
                const SizedBox(
                  width: 140,
                ),
                Switch(
                  value: light1,
                  activeColor: const Color(0xff7354cb),
                  onChanged: (bool value) {
                    setState(() {
                      light1 = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text("Automatic contact colors"),
                const SizedBox(
                  width: 55,
                ),
                Switch(
                  value: light2,
                  activeColor: const Color(0xff7354cb),
                  onChanged: (bool value) {
                    setState(() {
                      light2 = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text("Use system font"),
                const SizedBox(
                  width: 110,
                ),
                Switch(
                  value: light3,
                  activeColor: const Color(0xff7354cb),
                  onChanged: (bool value) {
                    setState(() {
                      light3 = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
