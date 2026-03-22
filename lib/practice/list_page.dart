import 'package:database_flutter/practice/add_data_page.dart';
import 'package:database_flutter/practice/list_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Page'), centerTitle: true),
      body: Consumer<ListMapProvider>(
        builder: (_, provider, _) {
          var allData = provider.getData();
          return allData.isNotEmpty
              ? ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return Card(
                      elevation: 10,
                      child: ListTile(
                        title: Text('${allData[index]["Name"]}'),
                        subtitle: Text('${allData[index]["Phone"]}'),
                        trailing: Row(
                          mainAxisSize: .min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<ListMapProvider>().updateData({
                                  "Name": "Nouraiz",
                                  "Phone": "No Number",
                                }, index);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ListMapProvider>().deleteData(
                                  index,
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('No Data added'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
