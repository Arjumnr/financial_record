import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_record/Data/db_helpers.dart';
import 'package:financial_record/Models/model_transactions.dart';
import 'package:financial_record/Views/add_transactions.dart';
import 'package:financial_record/Views/form_login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  late Box box;
  String name = '';

  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalPemasukan = 0;
  int totalPengeluaran = 0;

  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() async {
    super.initState();
    box = await Hive.openBox('money');
    fetch();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('name') ?? '';
      });
    });
    // box = Hive.box('money');
  }

  //get data from firebase to
  Future<List<ModelTransactions>> fetch() async {
    List<ModelTransactions> items = [];
    FirebaseFirestore.instance.collection("datas").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        items.add(
          ModelTransactions(
            result.data()['amount'] as int,
            result.data()['note'],
            result.data()['date'].toDate(),
            result.data()['type'],
            result.data()['name'],
          ),
        );
      });
    });
    box.toMap().values.forEach((element) {
      // print(element);
      items.add(
        ModelTransactions(
          element['amount'] as int,
          element['note'],
          element['date'] as DateTime,
          element['type'],
          element['name'],
        ),
      );
    });
    return items;

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection('datas')
    //     .where('name', isEqualTo: name)
    //     .orderBy('date', descending: true)
    //     .get();
    // querySnapshot.docs.map((doc) {
    //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //   return ModelTransactions(
    //     data['amount'],
    //     data['note'],
    //     data['date'].toDate(),
    //     data['type'],
    //     data['name'],
    //   );
    // }).toList();

    // print(querySnapshot.docs.length);

    // if (querySnapshot.docs.isEmpty) {
    //   return [];
    // } else {
    //   List<ModelTransactions> items = [];
    //   box.toMap().values.forEach((element) {
    //     // print(element);
    //     items.add(
    //       ModelTransactions(
    //         element['amount'] as int,
    //         element['note'],
    //         element['date'] as DateTime,
    //         element['type'],
    //         element['name'],
    //       ),
    //     );
    //   });
    //   return items;
    // }

    // if (box.values.isEmpty) {
    //   return Future.value([]);
    // } else {
    //   // return Future.value(box.toMap());
    //   List<ModelTransactions> items = [];
    //   box.toMap().values.forEach((element) {
    //     // print(element);
    //     items.add(
    //       ModelTransactions(
    //         element['amount'] as int,
    //         element['note'],
    //         element['date'] as DateTime,
    //         element['type'],
    //         element['name'],
    //       ),
    //     );
    //   });
    //   return items;
  }

  getTotalBalance(List<ModelTransactions> entiredata) {
    int totalPengeluaran = 0;
    int totalPemasukan = 0;
    int totalBalance = 0;
    DateTime today = DateTime.now();

    for (ModelTransactions data in entiredata) {
      if (data.date.month == today.month) if (data.type == "Pemasukan") {
        totalBalance += data.amount;
        totalPemasukan += data.amount;
      } else {
        totalBalance -= data.amount;
        totalPengeluaran += data.amount;
      }
    }
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      persistentFooterButtons: [
        Container(
          width: 900,
          child: const Text(
            'Created by: Arjum Nur Ramadhan',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddTransactions(),
            ),
          )
              .whenComplete(() {
            setState(() {});
          });
        },
        backgroundColor: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: const Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<List<ModelTransactions>>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error!"),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("Tambahkan Daftar Traksaksi"),
                );
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              color: Colors.white70,
                            ),
                            child: CircleAvatar(
                              maxRadius: 32.0,
                              child: Image.asset(
                                "asset/bg.png",
                                width: 64.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue.shade300),
                          ),
                        ]),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white70,
                          ),
                          padding: EdgeInsets.all(12.0),
                          child: IconButton(
                            icon: Icon(Icons.settings,
                                size: 32.0, color: Color(0xff3E454C)),
                            onPressed: () {
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (context) => Home(),
                              //   ),
                              // );
                            },
                          ),
                        ),
                        // child: Icon(Icons.settings,
                        // size: 32.0,
                        //   color: Color(0xff3E454C),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 0, 157, 196),
                              Color.fromARGB(255, 0, 157, 196),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(24.0))),
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Total Saldo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Rp. $totalBalance",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:
                                      cardPemasukan(totalPemasukan.toString()),
                                ),
                                Expanded(
                                    child: cardPengeluaran(
                                        totalPengeluaran.toString())),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  /////
                  ////
                  ////
                  Padding(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Text(
                      "Riwayat Transaksi",
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        ModelTransactions dataAtIndex;
                        try {
                          // dataAtIndex = snapshot.data![index];
                          dataAtIndex = snapshot.data![index];
                        } catch (e) {
                          // deleteAt deletes that key and value,
                          // hence makign it null here., as we still build on the length.
                          return Container();
                        }

                        // if (dataAtIndex.type == "Pemasukan") {
                        //   return PemasukanTile(dataAtIndex.amount,
                        //       dataAtIndex.note, dataAtIndex.date, index);
                        // } else {
                        //   return pengeluaranTile(dataAtIndex.amount,
                        //       dataAtIndex.note, dataAtIndex.date, index);
                        // }
                      }),
                  SizedBox(
                    height: 60.0,
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("Error!"),
              );
            }
          }),
    );
  }
}

Widget cardPemasukan(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_upward,
          size: 28.0,
          color: Colors.green[700],
        ),
        margin: EdgeInsets.only(right: 8.0),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pemasukan",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              "Rp. $value",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

///////////////

Widget cardPengeluaran(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.arrow_downward,
          size: 28.0,
          color: Colors.red[700],
        ),
        margin: EdgeInsets.only(right: 8.0),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pengeluaran",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              "Rp. $value",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
