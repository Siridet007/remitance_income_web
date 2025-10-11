import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:remittance_income_cm/pdf/printbill.dart';

import '../model/model.dart';

class PreviewBill extends StatefulWidget {
  final List<GetData> dataList;
  final String date;
  final String? staffID;
  final String? name;
  final String? dept;
  final String? location;
  final String? others;
  final String? twentyXAmount;
  final String? tenXAmount;
  final String? fiveXAmount;
  final String? coupon;
  final String? usdAmount;
  final String? sgdAmount;
  final String? twdAmount;
  final String? jpyAmount;
  final String? hkdAmount;
  final String? gbpAmount;
  final String? cnyAmount;
  final String? audAmount;
  final String? eurAmount;
  final String? foreignCurrenct;
  final String? oneThousandAmount;
  final String? fiveHundredAmount;
  final String? oneHundredAmount;
  final String? fiftyAmount;
  final String? twentyAmount;
  final String? tenAmount;
  final String? fiveAmount;
  final String? twoAmount;
  final String? oneAmount;
  final String? dotFiftyAmount;
  final String? dotTwentyFiveAmount;
  final String? noteAndCoins;
  final String? grandTotal;
  final String? netAmount;
  const PreviewBill({
    super.key,
    required this.dataList,
    required this.date,
    this.staffID,
    this.name,
    this.dept,
    this.location,
    this.others,
    this.twentyXAmount,
    this.tenXAmount,
    this.fiveXAmount,
    this.coupon,
    this.usdAmount,
    this.sgdAmount,
    this.twdAmount,
    this.jpyAmount,
    this.hkdAmount,
    this.gbpAmount,
    this.cnyAmount,
    this.audAmount,
    this.eurAmount,
    this.foreignCurrenct,
    this.oneThousandAmount,
    this.fiveHundredAmount,
    this.oneHundredAmount,
    this.fiftyAmount,
    this.twentyAmount,
    this.tenAmount,
    this.fiveAmount,
    this.twoAmount,
    this.oneAmount,
    this.dotFiftyAmount,
    this.dotTwentyFiveAmount,
    this.noteAndCoins,
    this.grandTotal,
    this.netAmount,
  });

  @override
  State<PreviewBill> createState() => _PreviewBillState();
}

class _PreviewBillState extends State<PreviewBill> {
  Uint8List? report;
  List<GetData>? dataList = [];
  String? date;
  String? staffID;
  String? name;
  String? dept;
  String? location;
  String? others;
  String? twentyXAmount;
  String? tenXAmount;
  String? fiveXAmount;
  String? coupon;
  String? usdAmount;
  String? sgdAmount;
  String? twdAmount;
  String? jpyAmount;
  String? hkdAmount;
  String? gbpAmount;
  String? cnyAmount;
  String? audAmount;
  String? eurAmount;
  String? foreignCurrenct;
  String? oneThousandAmount;
  String? fiveHundredAmount;
  String? oneHundredAmount;
  String? fiftyAmount;
  String? twentyAmount;
  String? tenAmount;
  String? fiveAmount;
  String? twoAmount;
  String? oneAmount;
  String? dotFiftyAmount;
  String? dotTwentyFiveAmount;
  String? noteAndCoins;
  String? grandTotal;
  String? netAmount;
  @override
  void initState() {
    super.initState();
    dataList = widget.dataList;
    date = widget.date;
    staffID = widget.staffID;
    name = widget.name;
    dept = widget.dept;
    location = widget.location;
    others = widget.others;
    twentyXAmount = widget.twentyXAmount;
    tenXAmount = widget.tenXAmount;
    fiveXAmount = widget.fiveXAmount;
    coupon = widget.coupon;
    usdAmount = widget.usdAmount;
    sgdAmount = widget.sgdAmount;
    twdAmount = widget.twdAmount;
    jpyAmount = widget.jpyAmount;
    hkdAmount = widget.hkdAmount;
    gbpAmount = widget.gbpAmount;
    cnyAmount = widget.cnyAmount;
    audAmount = widget.audAmount;
    eurAmount = widget.eurAmount;
    foreignCurrenct = widget.foreignCurrenct;
    oneThousandAmount = widget.oneThousandAmount;
    fiveHundredAmount = widget.fiveHundredAmount;
    oneHundredAmount = widget.oneHundredAmount;
    fiftyAmount = widget.fiftyAmount;
    twentyAmount = widget.twentyAmount;
    tenAmount = widget.tenAmount;
    fiveAmount = widget.fiveAmount;
    twoAmount = widget.twoAmount;
    oneAmount = widget.oneAmount;
    dotFiftyAmount = widget.dotFiftyAmount;
    dotTwentyFiveAmount = widget.dotTwentyFiveAmount;
    noteAndCoins = widget.noteAndCoins;
    grandTotal = widget.grandTotal;
    netAmount = widget.netAmount;
    PrintBill()
        .genPDF(
      dataList: dataList,
      date: date,
      staffID: staffID,
      name: name,
      dept: dept,
      location: location,
      others: others,
      twentyXAmount: twentyXAmount,
      tenXAmount: tenXAmount,
      fiveXAmount: fiveXAmount,
      coupon: coupon,
      usdAmount: usdAmount,
      sgdAmount: sgdAmount,
      twdAmount: twdAmount,
      jpyAmount: jpyAmount,
      hkdAmount: hkdAmount,
      gbpAmount: gbpAmount,
      cnyAmount: cnyAmount,
      audAmount: audAmount,
      eurAmount: eurAmount,
      foreignCurrenct: foreignCurrenct,
      oneThousandAmount: oneThousandAmount,
      fiveHundredAmount: fiveHundredAmount,
      oneHundredAmount: oneHundredAmount,
      fiftyAmount: fiftyAmount,
      twentyAmount: twentyAmount,
      tenAmount: tenAmount,
      fiveAmount: fiveAmount,
      twoAmount: twoAmount,
      oneAmount: oneAmount,
      dotFiftyAmount: dotFiftyAmount,
      dotTwentyFiveAmount: dotTwentyFiveAmount,
      noteAndCoins: noteAndCoins,
      grandTotal: grandTotal,
      netAmount: netAmount,
    )
        .then((value) {
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
