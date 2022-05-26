import 'package:flutter/material.dart';

import '../customWidgets/homeWidget/onErrorLoading.dart';
import '../sqlHelper.dart/sqlDB.dart';
import '../sqlModel.dart/sqlModelClass.dart';
import 'notesPages/addNote.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Note note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 6, 6),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddNotePage(note: null)));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 5));
          return setState(() {});
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(
                            "iNotes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Image.asset("images/image2.png",
                              height: 50, width: 50),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<List<Note>?>(
                    future: DatabaseHelper.fetchDb(),
                    builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return onErrorLoading(context);
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 0, crossAxisCount: 2),
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 100),
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Card(
                                  elevation: 30,
                                  borderOnForeground: true,
                                  shadowColor: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    onLongPress: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                backgroundColor: Colors.purple,
                                                title: const Text(
                                                    "Are you sure you want to delete this iNote?",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red)),
                                                      onPressed: () async {
                                                        await DatabaseHelper
                                                            .deleteNote(snapshot
                                                                .data![index]);
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Text("Yes")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Text("No")),
                                                ],
                                              ));
                                    },
                                    child: Container(
                                      // height: 60,
                                      // width: 70,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.pink,
                                                Colors.purple
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: index % 2 == 0
                                              ? const Color.fromARGB(
                                                  255, 220, 64, 247)
                                              : const Color.fromARGB(
                                                  255, 40, 155, 249)),
                                      child: Center(
                                          child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "iNote",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddNotePage(
                                                                        note: snapshot
                                                                            .data![index])));
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.white))
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 17),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                snapshot.data![index].title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      }
                      return const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No Notes found! Please add Notes",
                            style: TextStyle(color: Colors.white),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
