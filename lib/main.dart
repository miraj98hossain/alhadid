import 'package:alhadid/helpers/database_helper.dart';
import 'package:alhadid/presentations/hadith_details_screen/hadith_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:alhadid/models/hadith.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HadithDetailsScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final DictionaryDataBaseHelper _dbHelper = DictionaryDataBaseHelper();
//   List<Hadith> _hadithList = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeDatabase();
//   }

//   Future<void> _initializeDatabase() async {
//     await _dbHelper.init();
//     _loadHadithData();
//   }

//   Future<void> _loadHadithData() async {
//     List<Hadith> hadithList = await _dbHelper.getAllTheWordsEnglish();
//     setState(() {
//       _hadithList = hadithList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: _hadithList.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _hadithList.length,
//               itemBuilder: (context, index) {
//                 Hadith hadith = _hadithList[index];
//                 return ListTile(
//                   title: Text(hadith.bookName ?? ""),
//                   subtitle: Text(hadith.narrator ?? ""),
//                 );
//               },
//             ),
//     );
//   }
// }
