import 'dart:io' as io;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_management/models/BillModel.dart';
import 'package:shop_management/models/CustomerModel.dart';
import 'package:shop_management/screens/invoice_screen.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BillPage extends StatefulWidget {
  const BillPage({super.key, required this.uid, required this.type});
  final String uid;
  final String type;
  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bills',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Date or Total ...',
                          hintStyle: TextStyle(color: Colors.black54)),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text('No Bills Found'),
                  );
                List<BillModel> billList = [];
                for (DataSnapshot snap in snapshot.data!.snapshot.children) {
                  BillModel model = BillModel.fromMap(snap.value as Map);
                  billList.add(model);
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        generatePDF(billList[index]);
                      },
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bill Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(billList[index].date))}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Bill Total: ${billList[index].total}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: billList.length,
                );
              },
              future: FirebaseDatabase.instance
                  .ref('bills')
                  .child(FirebaseAuth.instance.currentUser!.uid)
                  .orderByChild('userID')
                  .equalTo(widget.uid)
                  .once(),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> generatePDF(BillModel model) async {
    var status=await Permission.storage.status;
    if(status.isDenied){
      Permission.storage.request();
    }else {
      FirebaseDatabase.instance
          .ref(widget.type)
          .child(widget.uid)
          .once()
          .then((value) async {
        CustomerModel cmodel = CustomerModel.fromMap(
            value.snapshot.value as Map);
        List<pw.TableRow> list = [
          pw.TableRow(
              children: [
                pw.SizedBox(width: 16),
                pw.Text('Name', style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 16)),
                pw.Text('Quantity', style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 16)),
                pw.Text('Price', style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 16)),
                pw.Text('Total', style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 16))
              ],
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    top: pw.BorderSide(),
                    bottom: pw.BorderSide(),
                  )))
        ];
        for (Map map in model.item) {
          pw.TableRow row = pw.TableRow(
              children: [
                pw.SizedBox(width: 16),
                pw.Text(map['name']),
                pw.Text(map['quantity'].toString()),
                pw.Text(map['price'].toString()),
                pw.Text((map['price'] * map['quantity']).toString()),
              ],
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    top: pw.BorderSide(),
                    bottom: pw.BorderSide(),
                  )));
          list.add(row);
        }
        list.add(pw.TableRow(
            children: [
              pw.SizedBox(width: 16),
              pw.Text('', style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 20)),
              pw.Text('', style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 20)),
              pw.Text('Total', style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 16)),
              pw.Text('${model.total}', style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 16))
            ],
            decoration: pw.BoxDecoration(
                border: pw.Border(
                  left: pw.BorderSide(),
                  right: pw.BorderSide(),
                  top: pw.BorderSide(),
                  bottom: pw.BorderSide(),
                ))));

        final pdf = pw.Document();
        pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Invoice", style: pw.TextStyle(fontSize: 32)),
                    pw.SizedBox(height: 20),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Details",
                              style: pw.TextStyle(fontSize: 16, fontWeight: pw
                                  .FontWeight.bold)),
                          pw.Text("Date : ${DateFormat('dd-MMMM-yyyy').format(
                              DateTime.parse(model.date))}",
                              style: pw.TextStyle(fontSize: 16)),
                        ]
                    ),
                    pw.Text(cmodel.name, style: pw.TextStyle(fontSize: 16)),
                    pw.Text(cmodel.phone, style: pw.TextStyle(fontSize: 16)),
                    pw.Container(width: 200,
                        child: pw.Text(
                            cmodel.address, style: pw.TextStyle(fontSize: 16))),
                    pw.SizedBox(height: 20),
                    pw.Table(
                        border: pw.TableBorder(
                          left: pw.BorderSide(),
                          right: pw.BorderSide(),
                          top: pw.BorderSide(),
                          bottom: pw.BorderSide(),
                        ),
                        children: list)
                  ]);
            }));

        final output = await getExternalStorageDirectories(type: StorageDirectory.documents);

        final path = "${output?.first.path}/invoice.pdf";
        final file = await io.File(path).writeAsBytes(await pdf.save());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvoicePage(filePath: file.path)));
      });
    }
  }
}
