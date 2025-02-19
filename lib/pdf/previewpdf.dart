import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:remittance_income_cm/pdf/printpage.dart';

import '../model/model.dart';

class PreviewPDFPage extends StatefulWidget {
  final List<GetData> dataList;
  final String date;
  const PreviewPDFPage({super.key, required this.dataList, required this.date});

  @override
  State<PreviewPDFPage> createState() => _PreviewPDFPageState();
}

class _PreviewPDFPageState extends State<PreviewPDFPage> {
  Uint8List? report;
  List<GetData>? dataList = [];
  String? date;
  @override
  void initState() {
    super.initState();
    dataList = widget.dataList;
    date = widget.date;
    //print(jsonEncode(dataList));
    PrintPage().genPDF(dataList: dataList, date: date).then((value) {
      setState(() {
        report = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        title: const Text('Preview'),
      ),
      body: PdfPreview(
        build: (format) => report!,
        allowSharing: false,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'mydoc.pdf',
      ),
    );
  }
}
