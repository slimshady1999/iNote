import 'package:flutter/material.dart';

import 'homePage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 65.0),
                child: Image.asset("images/image1.png",
                    height: 300, width: 300, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "iNotes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Take notes in various places without the use of internet connection.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "iNote store's your data with less than 1MB per Note created.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 30),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Material(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.purple,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(13),
                            onTap: () async {
                              Future.delayed(const Duration(seconds: 1),
                                  () async {
                                await Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (route) => false);
                              });
                            },
                            child: const Center(
                                child: Text("Get Started",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))))))
          ]),
        ));
  }
}
