import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../model/model.dart';

class PrintShop {
  PrintShop();
  String convertToDouble(num) {
    double number = double.parse(num);
    if (number == 0.0) {
      return '';
    }
    String formattedNumber = NumberFormat('#,##0.00').format(number);
    var convert = formattedNumber;
    return convert;
  }

  double fs = 10;

  Future<void> printShop(
    date,
    name,
    staffID,
    dept,
    location,
    List<GetData> dataList,
    others,
    twentyXAmount,
    tenXAmount,
    fiveXAmount,
    coupon,
    usdAmount,
    oneThousandAmount,
    sgdAmount,
    fiveHundredAmount,
    twdAmount,
    oneHundredAmount,
    jpyAmount,
    fiftyAmount,
    hkdAmount,
    twentyAmount,
    gbpAmount,
    tenAmount,
    cnyAmount,
    fiveAmount,
    audAmount,
    twoAmount,
    eurAmount,
    oneAmount,
    foreignCurrenct,
    dotFiftyAmount,
    dotTwentyFiveAmount,
    noteAndCoins,
    grandTotal,
    netAmount,
    approvename,
    dateapprove,
  ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final list = dataList.first;
    pw.Font? pg = pw.Font.ttf(await rootBundle.load('fonts/pgvim.ttf'));
    pw.ImageProvider? logo =
        await imageFromAssetBundle('assets/Cashier_size-M.jpg');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(20, 20, 20, 20),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 550,
                height: 110,
                /*decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),*/
                child: pw.Stack(
                  overflow: pw.Overflow.visible,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Text(
                          'ใบนำส่งรายได้/Income Report Carnival Magic',
                          style: pw.TextStyle(
                            font: pg,
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'วันที่/Date_______/________/________',
                          style: pw.TextStyle(
                            font: pg,
                            fontSize: fs,
                          ),
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'ชื่อ/Name__________________________ ',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                            pw.Text(
                              'เลขประจำตัว/Staff ID No._______________________',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'ฝ่าย/Dept._________________________ ',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                            pw.Text(
                              'จุดสร้างรายได้/Location_________________________',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.Positioned(
                      right: 5,
                      child: pw.Container(
                        width: 80,
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Image(logo, dpi: 800),
                      ),
                    ),
                    pw.Positioned(
                      top: 55,
                      left: 60,
                      child: pw.Text(
                        DateFormat('dd')
                            .format(DateTime.parse(date.toString())),
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 55,
                      left: 110,
                      child: pw.Text(
                        DateFormat('MM')
                            .format(DateTime.parse(date.toString())),
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 55,
                      left: 150,
                      child: pw.Text(
                        DateFormat('yyyy')
                            .format(DateTime.parse(date.toString())),
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 75,
                      left: 60,
                      child: pw.Text(
                        '$name',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 75,
                      left: 320,
                      child: pw.Text(
                        '$staffID',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 95,
                      left: 60,
                      child: pw.Text(
                        '$dept',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Positioned(
                      top: 95,
                      left: 320,
                      child: pw.Text(
                        '$location',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 25,
              ),
              pw.Row(
                children: [
                  pw.Column(
                    children: [
                      pw.Container(
                        width: 200,
                        height: 60,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 200,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'บัตรเครดิต',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'Credit Card',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    '(1) รวม/Total',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.creditTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Container(
                        width: 200,
                        height: 60,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 200,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'เอฟซีคอยน์',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'FC coin',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    '(2) รวม/Total',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.fccoinTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Container(
                        width: 200,
                        height: 160,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 200,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Container(
                                width: 200,
                                height: 20,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  'Others',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'E-SHOP',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.eshopTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'VOUCHER',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.voucherTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'CHEQUE',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.chequeTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'PAY-IN',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.payinTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'TAX',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.taxTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    'GIFT CERTIFICATE',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(list.giftTot),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    '(3) รวม/Total',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(others),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Container(
                        width: 200,
                        height: 160,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              width: 200,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'คูปอง',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 200,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'Coupon',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 40,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  child: pw.Column(
                                    children: [
                                      pw.Container(
                                        width: 120,
                                        height: 20,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          'จำนวน',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 120,
                                        height: 20,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          'Quantity',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 40,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                      right: pw.BorderSide(),
                                    ),
                                  ),
                                  child: pw.Column(
                                    children: [
                                      pw.Container(
                                        width: 80,
                                        height: 20,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          'จำนวนเงิน',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 80,
                                        height: 20,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          'Amount',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '20 X',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '${list.coupon20Qty}',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(twentyXAmount),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '10 X',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '${list.coupon10Qty}',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(tenXAmount),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '5 X',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 60,
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          '${list.coupon5Qty}',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(fiveXAmount),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  width: 120,
                                  height: 20,
                                  decoration: const pw.BoxDecoration(
                                    border: pw.Border(
                                      right: pw.BorderSide(),
                                      bottom: pw.BorderSide(),
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    '(4) รวม/Total',
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  width: 80,
                                  height: 20,
                                  alignment: pw.Alignment.centerRight,
                                  padding: const pw.EdgeInsets.only(right: 5),
                                  child: pw.Text(
                                    convertToDouble(coupon),
                                    style: pw.TextStyle(
                                      font: pg,
                                      fontSize: fs,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Container(
                    width: 340,
                    height: 500,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(),
                        top: pw.BorderSide(),
                      ),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    width: 170,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'เงินสกุลต่างประเทศ',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 170,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'Foreign Currency',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Column(
                                children: [
                                  pw.Container(
                                    width: 170,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'ธนบัตรแล้วเหรียญกษาปณ์',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 170,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      'Notes & Coins',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          width: 100,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'จำนวน X มูลค่า',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 100,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'Quantity X Rate',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 40,
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          width: 70,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'จำนวนเงิน',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 70,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'Amount',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 40,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          width: 50,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'ประเภท',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 50,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'Type',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          width: 60,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'จำนวน',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 60,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'Quantity',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    child: pw.Column(
                                      children: [
                                        pw.Container(
                                          width: 60,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'จำนวนเงิน',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 60,
                                          height: 20,
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            'Amount',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'USD',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.uSDQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.uSDRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(usdAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '1000',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB1000Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(oneThousandAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'SGD',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.sGDQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.sGDRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(sgdAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '500',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB500Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(fiveHundredAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'TWD',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.tWDQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.tWDRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(twdAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '100',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB100Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(oneHundredAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'JPY',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.jPYQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.jPYRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(jpyAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '50',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB50Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(fiftyAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'HKD',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.hKDQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.hKDRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(hkdAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '20',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB20Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(twentyAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'GBP',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.gBPQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.gBPRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(gbpAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '10',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB10Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(tenAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'CNY',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.cNYQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.cNYRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(cnyAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '5',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB5Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(fiveAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'AUD',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.aUDQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.aUDRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(audAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '2',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB2Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(twoAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 30,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            'EUR',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerLeft,
                                          padding:
                                              const pw.EdgeInsets.only(left: 5),
                                          child: pw.Text(
                                            '${list.eURQty}',
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          width: 35,
                                          height: 20,
                                          alignment: pw.Alignment.centerRight,
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            convertToDouble(list.eURRate),
                                            style: pw.TextStyle(
                                              font: pg,
                                              fontSize: fs,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(eurAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '1',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB1Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(oneAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '(4)รวม/Total',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(foreignCurrenct),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '0.50',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB050Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(dotFiftyAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              alignment: pw.Alignment.center,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Text(
                                'รายได้รอบ1/Amount(First Collection)',
                                style: pw.TextStyle(
                                  font: pg,
                                  fontSize: fs,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 50,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '0.25',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '${list.tHB025Qty}',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(dotTwentyFiveAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                  left: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 100,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '(5)เงินสด/Cash',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 70,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    child: pw.Text(
                                      convertToDouble(list.tOTALROUND1),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              width: 170,
                              height: 20,
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(),
                                  right: pw.BorderSide(),
                                ),
                              ),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 110,
                                    height: 20,
                                    alignment: pw.Alignment.center,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      '(6)รวม/Total',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(noteAndCoins),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 340,
                              height: 20,
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 280,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      'รวมทั้งสิ้น/Grand Total(1)+(2)+(3)+(4)+(5)+(6)',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(grandTotal),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 340,
                              height: 20,
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 280,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      'หักรับคืนคูปอง/Refund',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(list.tOTALREFUND),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 340,
                              height: 20,
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 280,
                                    height: 20,
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(right: 5),
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                      ),
                                    ),
                                    child: pw.Text(
                                      'รวมรายได้สุทธิ/Net Amount',
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 60,
                                    height: 40,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        right: pw.BorderSide(),
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                    alignment: pw.Alignment.centerRight,
                                    padding: const pw.EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: pw.Text(
                                      convertToDouble(netAmount),
                                      style: pw.TextStyle(
                                        font: pg,
                                        fontSize: fs,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Stack(
                          children: [
                            pw.Container(
                              width: 340,
                              height: 100,
                              child: pw.Column(
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 100,
                                        height: 20,
                                        alignment: pw.Alignment.bottomLeft,
                                        child: pw.Text(
                                          'หมายเหตุ/Remark',
                                          style: pw.TextStyle(
                                            font: pg,
                                            fontSize: fs,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 240,
                                        height: 20,
                                        decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                            bottom: pw.BorderSide(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Container(
                                    width: 340,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 340,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 340,
                                    height: 20,
                                    decoration: const pw.BoxDecoration(
                                      border: pw.Border(
                                        bottom: pw.BorderSide(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Positioned(
                              child: pw.Container(
                                width: 340,
                                height: 100,
                                padding: const pw.EdgeInsets.only(top: 10),
                                child: pw.Text(
                                  '                            ${list.remark}',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                    lineSpacing: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 25,
              ),
              pw.Container(
                width: 550,
                height: 85,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  children: [
                    pw.Container(
                      width: 550,
                      height: 15,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(),
                        ),
                      ),
                      child: pw.Row(
                        children: [
                          pw.Container(
                            width: 275,
                            height: 15,
                            decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                right: pw.BorderSide(),
                              ),
                            ),
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              'ผู้นำส่ง/Reported by',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 275,
                            height: 15,
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              'ผู้รับเงิน/Received by',
                              style: pw.TextStyle(
                                font: pg,
                                fontSize: fs,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 275,
                          height: 70,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(),
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Column(
                            children: [
                              pw.Container(
                                width: 275,
                                height: 25,
                                alignment: pw.Alignment.bottomCenter,
                                child: pw.Text(
                                  name!.split(" ")[0],
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                              pw.Container(
                                width: 275,
                                height: 25,
                                alignment: pw.Alignment.bottomCenter,
                                child: pw.Text(
                                  '( $name )',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                              pw.Container(
                                width: 275,
                                height: 20,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  '${DateFormat('dd').format(DateTime.parse(date.toString()))}/${DateFormat('MM').format(DateTime.parse(date.toString()))}/${DateFormat('yyyy').format(DateTime.parse(date.toString()))}',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 275,
                          height: 70,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(),
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Column(
                            children: [
                              pw.Container(
                                width: 275,
                                height: 25,
                                alignment: pw.Alignment.bottomCenter,
                                child: pw.Text(
                                  approvename.split(" ")[0],
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                              pw.Container(
                                width: 275,
                                height: 25,
                                alignment: pw.Alignment.bottomCenter,
                                child: pw.Text(
                                  '( $approvename )',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                              pw.Container(
                                width: 275,
                                height: 20,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  '$dateapprove',
                                  style: pw.TextStyle(
                                    font: pg,
                                    fontSize: fs,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.Container(
                width: 550,
                height: 20,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 150,
                      height: 20,
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        'ฝ่ายรายรับ',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 150,
                      height: 20,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 150,
                      height: 20,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        'ใบนำส่งรายได้',
                        style: pw.TextStyle(
                          font: pg,
                          fontSize: fs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) => pdf.save());
  }
}
