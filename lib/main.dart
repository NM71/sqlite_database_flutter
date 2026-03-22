// // import 'package:database_flutter/home_page.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: .fromSeed(seedColor: Colors.tealAccent),
// //         textTheme: GoogleFonts.latoTextTheme(),
// //       ),
// //       home: const HomePage(),
// //     );
// //   }
// // }

// // // class MyHomePage extends StatefulWidget {
// // //   const MyHomePage({super.key, required this.title});

// // //   final String title;

// // //   @override
// // //   State<MyHomePage> createState() => _MyHomePageState();
// // // }

// // // class _MyHomePageState extends State<MyHomePage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text(widget.title), centerTitle: true),
// // //       body: Center(
// // //         child: Container(
// // //           height: 300,
// // //           width: 300,
// // //           decoration: BoxDecoration(
// // //             color: Colors.red,
// // //             borderRadius: BorderRadius.all(Radius.circular(20)),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // -----------------------------------------------------------------------

// import 'package:database_flutter/counter_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChangeNotifierProvider(
//         create: (context) => CounterProvider(),
//         child: MyHomePage(),
//       ), // this takes object of the same type of our provider
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   // counter variable
//   // int _count = 0;

//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: Text(
//           '${Provider.of<CounterProvider>(context, listen: true).getValue()}',
//           style: TextStyle(fontSize: 40),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Provider.of<CounterProvider>(context, listen: false).incrementCount();
//           // _count++;
//           // print(_count);
//         },
//       ),
//     );
//   }
// }

// -------------------------------------------------------------------------------------

import 'package:database_flutter/practice/list_page.dart';
import 'package:database_flutter/practice/counter_provider.dart';
import 'package:database_flutter/pages/home_page.dart';
import 'package:database_flutter/practice/list_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ListMapProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     print('Build Function Called');
//     return Scaffold(
//       appBar: AppBar(title: Text('Provider Counter'), centerTitle: true),
//       body: Center(
//         child: Consumer<CounterProvider>(
//           builder: (ctx, _, _) {
//             print('Consumer Build Function Called');
//             return Column(
//               mainAxisAlignment: .center,
//               children: [
//                 Text(
//                   // '${Provider.of<CounterProvider>(ctx, listen: true).getCount()}',
//                   '${ctx.watch<CounterProvider>().getCount()}',
//                   style: TextStyle(fontSize: 100),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: .spaceAround,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               // Provider.of<CounterProvider>(
//               //   context,
//               //   listen: false,
//               // ).incrementCount();
//               context.read<CounterProvider>().incrementCount();
//             },
//             child: Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             elevation: 30,
//             onPressed: () {
//               // Provider.of<CounterProvider>(context, listen: false).resetCount();
//               context.read<CounterProvider>().resetCount();
//             },
//             child: Icon(Icons.restore),
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               // Provider.of<CounterProvider>(
//               //   context,
//               //   listen: false,
//               // ).decrementCount();
//               context.read<CounterProvider>().decrementCount();
//             },
//             child: Icon(Icons.minimize),
//           ),
//         ],
//       ),
//     );
//   }
// }
