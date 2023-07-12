import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key});

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  //
  int? amonunt;
  String note = "Milk";
  String types = "Pemasukan";
  DateTime sdate = DateTime.now();
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

  CollectionReference datas = FirebaseFirestore.instance.collection('datas');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sdate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sdate) {
      setState(() {
        sdate = picked;
      });
    }
  }

  Future<void> addDataTransaction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('name') ?? '';
    return datas
        .add({
          'amount': amonunt,
          'name': name,
          'date': sdate,
          'type': types,
          'note': note,
        })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data: $error"));
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
          child: Text(
            'Created by: Arjum Nur Ramadhan',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Tambahkan Transaksi",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                color: Colors.blue),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.attach_money,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Rp",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    try {
                      amonunt = int.parse(val);
                    } catch (e) {}
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),

////////------------------------2nd
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.description,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Keterangan",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    note = val;
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20.0,
          ),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.moving_sharp,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: ChoiceChip(
                  label: Text(
                    "Pemasukan",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: types == "Pemasukan" ? Colors.white : Colors.white,
                    ),
                  ),
                  selectedColor: Colors.green,
                  selected: types == "Pemasukan" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        types = "Pemasukan";
                        if (note.isEmpty || note == "Pengeluaran") {
                          note = 'Pemasukan';
                        }
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: ChoiceChip(
                  label: Text(
                    "Pengeluaran",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: types == "Pemasukan" ? Colors.white : Colors.white,
                    ),
                  ),
                  selectedColor: Colors.red[700],
                  selected: types == "Pengeluaran" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        types = "Pengeluaran";
                        if (note.isEmpty || note == "Pengeluaran") {
                          note = 'Pengeluaran';
                        }
                      });
                    }
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.date_range,
                      size: 24.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "${sdate.day} ${months[sdate.month - 1]} ${sdate.year}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                if (amonunt != null) {
                  // DbHelper dbHelper = DbHelper();
                  // dbHelper.addData(amonunt!, sdate, types, note);
                  addDataTransaction();
                  Navigator.of(context).pop();
                  // add to firebase
                } else {
                  print("Not ");
                }
                print(amonunt);
                print(note);
                print(types);
                print(sdate);
              },
              child: Text(
                "Tambah",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
