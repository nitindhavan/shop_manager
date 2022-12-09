import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_share/flutter_share.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key,required this.filePath});

  final String filePath;
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  int pages=0;
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
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
                'Invoice',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PDFView(
                  filePath: widget.filePath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages!;
                      var isReady = true;
                    });
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                  await FlutterShare.shareFile(
                    title: 'Share Invoice',
                    text: 'Share generated invoice',
                    filePath: widget.filePath,
                  );
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16,right: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text('Share Invoice',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
