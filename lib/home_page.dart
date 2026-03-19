import 'package:database_flutter/data/local/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  // controllers
  var titleText = TextEditingController();
  var descText = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.book_outlined),
        title: Text('Flutter Local DB'),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                      subtitle: Text(
                        allNotes[index][DBHelper.COLUMN_NOTE_DESC],
                      ),
                      trailing: Row(
                        mainAxisSize: .min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete_outline),
                          ),
                          // const SizedBox(width: 10,),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Icon(Icons.book_outlined, size: 80),
                  const SizedBox(height: 15),
                  Text('No notes yet!!'),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('BottomSheet Opened');
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return getBottomSheetWidget();
            },
          );

          // bool check = await dbRef!.addNote(
          //   mTitle: "Hello World",
          //   mDesc: "This is a sample msg for Hello",
          // );

          // if (check) {
          //   // when we are adding a note, we also need to get all notes to update the UI
          //   getNotes();
          // }
        },
        child: Icon(Icons.note_add_outlined),
      ),
    );
  }

  // BottomSheet Code
  Widget getBottomSheetWidget() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text('Add New Note', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextField(
              controller: titleText,
              decoration: InputDecoration(
                label: Text('Enter title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descText,
              maxLines: 4,
              decoration: InputDecoration(
                label: Text('Enter description'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String title = titleText.text.trim();
                      String desc = descText.text.trim();

                      if (title.isNotEmpty && desc.isNotEmpty) {
                        bool check = await dbRef!.addNote(
                          mTitle: title,
                          mDesc: desc,
                        );

                        if (check) {
                          // when we are adding a note, we also need to get all notes to update the UI
                          getNotes();
                          print('Note Added');
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Please enter all the values'),
                          ),
                        );
                      }
                    },
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: () async {
            //     String title = titleText.text.trim();
            //     String desc = descText.text.trim();

            //     if (title.isNotEmpty && desc.isNotEmpty) {
            //       bool check = await dbRef!.addNote(
            //         mTitle: title,
            //         mDesc: desc,
            //       );

            //       if (check) {
            //         // when we are adding a note, we also need to get all notes to update the UI
            //         getNotes();
            //         print('Note Added');
            //         Navigator.pop(context);
            //       }
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Please enter all the values'),
            //         ),
            //       );
            //     }
            //   },
            //   child: CircleAvatar(
            //     child: Icon(Icons.arrow_forward_ios_sharp),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
