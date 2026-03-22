// import 'package:flutter/material.dart';

// class ListMapProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> _mapist = [];

//   // events
//   List<Map<String, dynamic>> getList() {
//     return _mapist;
//   }

//   // add data
//   void addData(Map<String, dynamic> data) {
//     _mapist.add(data);
//     notifyListeners();
//   }

//   // remove data
//   void removeData(Map<String, dynamic> data, int index) {
//     _mapist.remove(_mapist[index]['$data']);
//   }
// }

import 'package:flutter/foundation.dart';

class ListMapProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _myData = [];

  /// events
  List<Map<String, dynamic>> getData() {
    return _myData;
  }

  void resetData() {
    _myData = [];
    notifyListeners();
  }

  void addData(Map<String, dynamic> data) {
    _myData.add(data);
    notifyListeners();
  }

  // update data
  void updateData(Map<String, dynamic> updatedData, int index) {
    _myData[index] = updatedData;
    notifyListeners();
  }

  // remove data
  void deleteData(int index) {
    _myData.removeAt(index);
    notifyListeners();
  }
}
