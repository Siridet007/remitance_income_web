import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:remittance_income_cm/pdf/printdaily.dart';

import '../model/model.dart';

class PreviewDialy extends StatefulWidget {
  final List<TotalData> dataList;
  final String date;
  final String foreCash;
  final String thbCash;
  const PreviewDialy(
      {super.key,
      required this.dataList,
      required this.date,
      required this.foreCash,
      required this.thbCash});

  @override
  State<PreviewDialy> createState() => _PreviewDialyState();
}

class _PreviewDialyState extends State<PreviewDialy> {
  Uint8List? report;
  List<TotalData>? datalist = [];
  String? date;
  String? foreCash;
  String? thbCash;
  @override
  void initState() {
    super.initState();
    datalist = widget.dataList;
    date = widget.date;
    foreCash = widget.foreCash;
    thbCash = widget.thbCash;
    PrintDaily()
        .genPDF(
          dataList: datalist,
          date: date,
          foreCash: foreCash,
          thbCash: thbCash,
        )
        .then((value) => report = value);
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
