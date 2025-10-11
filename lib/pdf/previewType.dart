import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:remittance_income_cm/model/model.dart';
import 'package:remittance_income_cm/pdf/printType.dart';

class PreviewType extends StatefulWidget {
  final List<TotalType> typeList;
  final String sumForeingCash;
  final String sumTHCash;
  final String sumCredit;
  final String sumEshop;
  final String sumPayin;
  final String sumVoucher;
  final String sumCheque;
  final String total;
  final String date;
  const PreviewType({
    super.key,
    required this.typeList,
    required this.sumForeingCash,
    required this.sumTHCash,
    required this.sumCredit,
    required this.sumEshop,
    required this.sumPayin,
    required this.sumVoucher,
    required this.sumCheque,
    required this.total,
    required this.date,
  });

  @override
  State<PreviewType> createState() => _PreviewTypeState();
}

class _PreviewTypeState extends State<PreviewType> {
  Uint8List? report;
  List<TotalType> typeList = [];
  String? sumForeingCash;
  String? sumTHCash;
  String? sumCredit;
  String? sumEshop;
  String? sumPayin;
  String? sumVoucher;
  String? sumCheque;
  String? total;
  String? date;

  @override
  void initState() {
    super.initState();
    typeList = widget.typeList;
    sumForeingCash = widget.sumForeingCash;
    sumTHCash = widget.sumTHCash;
    sumCredit = widget.sumCredit;
    sumEshop = widget.sumEshop;
    sumPayin = widget.sumPayin;
    sumVoucher = widget.sumVoucher;
    sumCheque = widget.sumCheque;
    total = widget.total;
    date = widget.date;
    PrintType()
        .genPDF(
          typeList: widget.typeList,
          sumForeingCash: widget.sumForeingCash,
          sumTHCash: widget.sumTHCash,
          sumCredit: widget.sumCredit,
          sumEshop: widget.sumEshop,
          sumPayin: widget.sumPayin,
          sumVoucher: widget.sumVoucher,
          sumCheque: widget.sumCheque,
          total: widget.total,
          date: widget.date,
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
