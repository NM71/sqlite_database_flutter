import 'package:database_flutter/data/local/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;

  // controllers
  var titleController = TextEditingController();
  var descController = TextEditingController();

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
        leading: Icon(
          Icons.book_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Flutter SQLite DB',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
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
                            onPressed: () async {
                              bool check = await dbRef!.deleteNote(
                                sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO],
                              );
                              if (check) {
                                getNotes();
                              }
                            },
                            icon: Icon(Icons.delete_outline),
                          ),
                          // const SizedBox(width: 10,),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  titleController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_TITLE];
                                  descController.text =
                                      allNotes[index][DBHelper
                                          .COLUMN_NOTE_DESC];

                                  return getBottomSheetWidget(
                                    isUpdate: true,
                                    sno:
                                        allNotes[index][DBHelper
                                            .COLUMN_NOTE_SNO],
                                  );
                                },
                              );
                            },
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
          if (kDebugMode) {
            print('BottomSheet Opened');
          }
          showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descController.clear();
              return getBottomSheetWidget();
            },
          );
        },
        child: FaIcon(FontAwesomeIcons.plus, size: 20),
      ),
    );
  }

  // BottomSheet Code
  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    // setting value of title controller in case of reusability for add/update note functions

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              isUpdate ? 'Update Note' : 'Add Note',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text('Enter title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descController,
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
                      String title = titleController.text.trim();
                      String desc = descController.text.trim();

                      if (title.isNotEmpty && desc.isNotEmpty) {
                        bool check = isUpdate
                            ? await dbRef!.updateNote(
                                sno: sno,
                                title: title,
                                desc: desc,
                              )
                            : await dbRef!.addNote(mTitle: title, mDesc: desc);

                        if (check) {
                          // when we are adding a note, we also need to get all notes to update the UI
                          getNotes();
                          if (kDebugMode) {
                            print('Note Added');
                          }
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Please enter all the values'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    child: Text(isUpdate ? 'Update' : 'Add'),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
