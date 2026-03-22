import 'package:database_flutter/practice/list_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Data'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ListMapProvider>().addData({
                  "Name": "Nousher",
                  "Phone": "+923293354523",
                });
              },
              child: Text('Add Data'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<ListMapProvider>().resetData();
              },
              child: Text('Reset Data'),
            ),
          ],
        ),
      ),
    );
  }
}
