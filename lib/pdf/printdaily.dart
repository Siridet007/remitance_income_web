import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../model/model.dart';

class PrintDaily {
  pw.Font? pg;
  pw.ImageProvider? logo;
  List<TotalData>? dataList = [];
  String? date;
  String? foreCash;
  String? thbCash;
  String? subTotal;

  // ignore: avoid_types_as_parameter_names
  String convertToDouble(num) {
    double number = double.parse(num.toString());
    if(number == 0.0){
      return '';
    }
    String formatedNumber = NumberFormat('#,##0.00').format(number);
    return formatedNumber;
  }

  Future<Uint8List> genPDF({
    List<TotalData>? dataList,
    String? date,
    String? foreCash,
    String? thbCash,
  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    pg = pw.Font.ttf(await rootBundle.load('fonts/pgvim.ttf'));
    this.dataList = dataList;
    this.date = date;
    this.foreCash = foreCash;
    this.thbCash = thbCash;
    logo = await imageFromAssetBundle('assets/Cashier_size-M.jpg');
    double parseNum(dynamic value) {
      if (value == null) return 0;
      return double.tryParse(value.toString()) ?? 0;
    }

    double calculateThbTotal(List<TotalData>? dataList) {
      return dataList!.fold<double>(0, (sumAll, data) {
        final thbDenominations = {
          1000: data.tHB1000Qty,
          500: data.tHB500Qty,
          100: data.tHB100Qty,
          50: data.tHB50Qty,
          20: data.tHB20Qty,
          10: data.tHB10Qty,
          5: data.tHB5Qty,
          2: data.tHB2Qty,
          1: data.tHB1Qty,
          0.5: data.tHB050Qty,
          0.25: data.tHB025Qty,
        };

        return sumAll +
            thbDenominations.entries.fold<double>(
              0,
              (sum, e) => sum + (e.key * parseNum(e.value)),
            );
      });
    }

    double calculateForeTotal(List<TotalData>? dataList) {
      return dataList!.fold<double>(0, (sumAll, data) {
        final foreCurrencies = {
          data.uSDRate: data.uSDQty,
          data.sGDRate: data.sGDQty,
          data.tWDRate: data.tWDQty,
          data.jPYRate: data.jPYQty,
          data.hKDRate: data.hKDQty,
          data.gBPRate: data.gBPQty,
          data.cNYRate: data.cNYQty,
          data.aUDRate: data.aUDQty,
          data.eURRate: data.eURQty,
        };

        return sumAll +
            foreCurrencies.entries.fold<double>(
              0,
              (sum, e) => sum + (parseNum(e.key) * parseNum(e.value)),
            );
      });
    }

    subTotal = ((double.parse(thbCash!)) + double.parse(foreCash!)).toString();
    print(subTotal);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(40, 10, 40, 10),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: headReport(context),
          );
        },
        build: (context) {
          return listrow(context, thbCash, foreCash, subTotal);
        },
        footer: (context) {
          return pw.Column(
            children: footerReport(context),
          );
        },
      ),
    );
    return pdf.save();
  }

  List<pw.Widget> headReport(pw.Context context) {
    return [
      pw.Container(
        width: 100,
        alignment: pw.Alignment.centerLeft,
        padding: const pw.EdgeInsets.only(top: 6),
        margin: const pw.EdgeInsets.only(top: 0.5 * PdfPageFormat.cm),
        //decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Image(logo!, dpi: 800),
      ),
      pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
      pw.Container(
        width: 550,
        child: pw.Row(
          children: [
            pw.Text(
              'ใบสรุปส่งเงินรายได้/',
              style: pw.TextStyle(
                font: pg,
                fontSize: 16,
              ),
            ),
            pw.Text(
              'Daily Income Settlement',
              style: pw.TextStyle(
                font: pg,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
      pw.Container(
        width: 550,
        child: pw.Row(
          children: [
            pw.Stack(
              overflow: pw.Overflow.visible,
              children: [
                pw.Text(
                  'วันที่/Date_____/______/________',
                  style: pw.TextStyle(
                    font: pg,
                    fontSize: 12,
                  ),
                ),
                pw.Positioned(
                  left: 60,
                  child: pw.Text(
                    (DateFormat("dd").format(DateTime.parse(date!))),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Positioned(
                  left: 110,
                  child: pw.Text(
                    (DateFormat("MM").format(DateTime.parse(date!))),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Positioned(
                  left: 160,
                  child: pw.Text(
                    (DateFormat("yyyy").format(DateTime.parse(date!))),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  List<pw.Widget> listrow(pw.Context context, thbTotal, foreTotal, subTotal) {
    return [
      pw.Column(
        children: [
          pw.Padding(padding: const pw.EdgeInsets.only(top: 3)),
          pw.Container(
            width: 550,
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            alignment: pw.Alignment.center,
            height: 20,
            padding: const pw.EdgeInsets.only(top: 5),
            child: pw.Text(
              'ธนบัตรและเหรียญกษาปณ์/Notes & Coins',
              style: pw.TextStyle(font: pg, fontSize: 12),
            ),
          ),
          pw.Container(
            width: 550,
            height: 35,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 35,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'ชนิด',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                      pw.Text(
                        'Type',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 40,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'จำนวน',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                      pw.Text(
                        'Quantity',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  width: 275,
                  alignment: pw.Alignment.center,
                  height: 40,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'รวมเงิน (บาท)',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                      pw.Text(
                        'Amount (Bath)',
                        style: pw.TextStyle(font: pg, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '1000',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB1000Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(1000 *
                        double.parse(dataList!.first.tHB1000Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '500',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB500Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(500 *
                        double.parse(dataList!.first.tHB500Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '100',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB100Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(100 *
                        double.parse(dataList!.first.tHB100Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '50',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB50Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        50 * double.parse(dataList!.first.tHB50Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '20',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB20Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        20 * double.parse(dataList!.first.tHB20Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '10',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB10Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        10 * double.parse(dataList!.first.tHB10Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '5',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB5Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        5 * double.parse(dataList!.first.tHB5Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '2',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB2Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        2 * double.parse(dataList!.first.tHB2Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '1',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB1Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(
                        1 * double.parse(dataList!.first.tHB1Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '0.50',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB050Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(0.5 *
                        double.parse(dataList!.first.tHB050Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 130,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    '0.25',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 145,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tHB025Qty),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(0.25 *
                        double.parse(dataList!.first.tHB025Qty.toString())),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'รวมเงินไทย/Sub Total',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(thbTotal),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 3),
                  child: pw.Text(
                    'เงินต่างประเทศ/Foreign Currency',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(foreTotal),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: 2),
                bottom: pw.BorderSide(width: 2),
                right: pw.BorderSide(width: 2),
                top: pw.BorderSide(width: 2),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(width: 2),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'รวมเงิน/Total',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(subTotal),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
                top: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'บัตรเครดิต/Credit Card',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.creditTot),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
                top: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'E-Shop',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.eShop),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
                top: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 5),
                  child: pw.Text(
                    'ชำระเงินผ่านธนาคาร/PAY IN',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.payinTot),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
                top: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    'ลูกหนี้(เรียกเก็บเงิน)Voucher',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.voucherTot),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'เช็ค/Cheque',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.chequeTot),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  child: pw.Text(
                    'FC Coin',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.fccoinTot),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: 2),
                bottom: pw.BorderSide(width: 2),
                right: pw.BorderSide(width: 2),
                top: pw.BorderSide(width: 2),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(width: 2),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    'รวมรายได้ทั้งสิ้น/Grand Total',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  alignment: pw.Alignment.centerRight,
                  height: 20,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(dataList!.first.tOTAL),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
                top: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    'ชื่อผู้นำส่ง/Submitted by',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Container(
                  width: 275,
                  alignment: pw.Alignment.center,
                  height: 20,
                  padding: const pw.EdgeInsets.only(top: 2),
                  child: pw.Text(
                    'ชื่อผู้รับ/Received by',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 40,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  height: 40,
                  padding: const pw.EdgeInsets.only(left: 5),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    '1.__________________________',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 275,
                  height: 40,
                  padding: const pw.EdgeInsets.only(left: 5),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    '1.__________________________',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 40,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(),
                bottom: pw.BorderSide(),
                right: pw.BorderSide(),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 275,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  height: 40,
                  padding: const pw.EdgeInsets.only(left: 5),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    '2.__________________________',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Container(
                  width: 275,
                  height: 40,
                  padding: const pw.EdgeInsets.only(left: 5),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    '2.__________________________',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
          pw.Container(
            width: 550,
            height: 20,
            child: pw.Row(
              children: [
                pw.Text(
                  'หมายเหตุ/Remarks   ',
                  style: pw.TextStyle(
                    font: pg,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(),
              ),
            ),
          ),
          pw.Container(
            width: 550,
            height: 20,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  List<pw.Widget> footerReport(pw.Context context) {
    String dateTime = DateFormat("dd/MM/yyyy").format(DateTime.now());
    return [
      pw.Container(
        width: 550,
        child: pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 150,
                  //decoration: pw.BoxDecoration(border: pw.Border.all()),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'ฝ่ายรายรับ',
                    style: pw.TextStyle(
                      font: pg,
                    ),
                  ),
                ),
                pw.Container(
                  width: 150,
                  alignment: pw.Alignment.center,
                  //decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Text(
                    dateTime,
                    style: pw.TextStyle(
                      font: pg,
                    ),
                  ),
                ),
                pw.Container(
                  width: 150,
                  //decoration: pw.BoxDecoration(border: pw.Border.all()),
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'ใบสรุปส่งรายได้',
                    style: pw.TextStyle(
                      font: pg,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
