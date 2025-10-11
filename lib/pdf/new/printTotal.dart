import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintTotal {
  PrintTotal();
  String convertToDouble(num) {
    double number = double.parse(num.toString());
    if (number == 0.0) {
      return '';
    }
    String formatedNumber = NumberFormat('#,##0.00').format(number);
    return formatedNumber;
  }

  Future<void> printTotalMethod(
      sumList, sumTHCash, sumForeingCash, date) async {
    final doc = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    pw.Font? pg = pw.Font.ttf(await rootBundle.load('fonts/pgvim.ttf'));
    pw.ImageProvider? logo =
        await imageFromAssetBundle('assets/Cashier_size-M.jpg');
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(40, 10, 40, 10),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: headReport(context, logo, pg, date),
          );
        },
        build: (context) {
          return listrow(
            context,
            sumTHCash,
            sumForeingCash,
            ((double.parse(sumTHCash.toString())) +
                double.parse(sumForeingCash.toString())),
            pg,
            sumList,
          );
        },
        footer: (context) {
          return pw.Column(
            children: footerReport(context, pg, date),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) => doc.save());
  }

  List<pw.Widget> headReport(pw.Context context, logo, pg, date) {
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
                    (DateFormat("dd").format(DateTime.parse(date))),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Positioned(
                  left: 110,
                  child: pw.Text(
                    (DateFormat("MM").format(DateTime.parse(date))),
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Positioned(
                  left: 160,
                  child: pw.Text(
                    (DateFormat("yyyy").format(DateTime.parse(date))),
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

  List<pw.Widget> listrow(
      pw.Context context, thbTotal, foreTotal, subTotal, pg, sumList) {
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
                    convertToDouble(sumList!.first.tHB1000Qty),
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
                        double.parse(sumList!.first.tHB1000Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB500Qty),
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
                        double.parse(sumList!.first.tHB500Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB100Qty),
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
                        double.parse(sumList!.first.tHB100Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB50Qty),
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
                        50 * double.parse(sumList!.first.tHB50Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB20Qty),
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
                        20 * double.parse(sumList!.first.tHB20Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB10Qty),
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
                        10 * double.parse(sumList!.first.tHB10Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB5Qty),
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
                        5 * double.parse(sumList!.first.tHB5Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB2Qty),
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
                        2 * double.parse(sumList!.first.tHB2Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB1Qty),
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
                        1 * double.parse(sumList!.first.tHB1Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB050Qty),
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
                        double.parse(sumList!.first.tHB050Qty.toString())),
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
                    convertToDouble(sumList!.first.tHB025Qty),
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
                        double.parse(sumList!.first.tHB025Qty.toString())),
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
                    convertToDouble(sumList!.first.creditTot),
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
                    convertToDouble(sumList!.first.eShop),
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
                    convertToDouble(sumList!.first.payinTot),
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
                    convertToDouble(sumList!.first.voucherTot),
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
                    convertToDouble(sumList!.first.chequeTot),
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
                    convertToDouble(sumList!.first.fccoinTot),
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
                    convertToDouble(sumList!.first.tOTAL),
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

  List<pw.Widget> footerReport(pw.Context context, pg, date) {
    String dateTime = DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
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
