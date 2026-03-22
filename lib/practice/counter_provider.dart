// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart' show context;

// class CounterProvider extends ChangeNotifier {
//   int _count = 0;

//   // give access to count
//   int getValue() =>
//       _count; // by this approach we only give the value of count, and no one can change it from outside of this class
//   // no direct access to count

//   // events (to perform changes in the count)
//   void incrementCount() {
//     _count++;
//     notifyListeners();
//   }

//   void decrement() {
//     if (_count > 0) {
//       _count--;
//     } else {
//       ScaffoldMessenger.of(
//         context as BuildContext,
//       ).showSnackBar(SnackBar(content: Text('Count cannot be negative')));
//     }
//     notifyListeners();
//   }

//   void resetCount() {
//     _count = 0;
//     notifyListeners();
//   }
// }
// ----------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show context;

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int getCount() {
    return _count;
  }

  void incrementCount() {
    _count++;
    notifyListeners();
  }

  void decrementCount() {
    if (_count > 0) {
      _count--;
    } else {
      print('Count cannot be -ve');
    }
    notifyListeners();
  }

  void resetCount() {
    _count = 0;
    notifyListeners();
  }
}
