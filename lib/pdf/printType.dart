import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:remittance_income_cm/model/model.dart';

class PrintType {
  pw.Font? pg;
  pw.ImageProvider? logo;
  String? date;
  List<TotalType>? typeList;
  String? sumForeingCash;
  String? sumTHCash;
  String? sumCredit;
  String? sumEshop;
  String? sumPayin;
  String? sumVoucher;
  String? sumCheque;
  String? total;

  // ignore: avoid_types_as_parameter_names
  String convertToDouble(num) {
    double number = double.parse(num.toString());
    String formateedNumber = NumberFormat('#,##0.00').format(number);
    return formateedNumber;
  }

  Future<Uint8List> genPDF({
    String? date,
    List<TotalType>? typeList,
    String? sumForeingCash,
    String? sumTHCash,
    String? sumCredit,
    String? sumEshop,
    String? sumPayin,
    String? sumVoucher,
    String? sumCheque,
    String? total,
  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    pg = pw.Font.ttf(await rootBundle.load('fonts/pgvim.ttf'));
    logo = await imageFromAssetBundle('assets/Cashier_size-M.jpg');
    this.date = date;
    this.typeList = typeList;
    this.sumForeingCash = sumForeingCash;
    this.sumTHCash = sumTHCash;
    this.sumCredit = sumCredit;
    this.sumEshop = sumEshop;
    this.sumPayin = sumPayin;
    this.sumVoucher = sumVoucher;
    this.sumCheque = sumCheque;
    this.total = total;
    pdf.addPage(
      pw.MultiPage(
        pageFormat: const PdfPageFormat(
          29.7 * PdfPageFormat.cm,
          21.0 * PdfPageFormat.cm,
          marginTop: 0.2 * PdfPageFormat.cm,
          marginLeft: 1.5 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 0.3 * PdfPageFormat.cm,
        ),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: headReport(context),
          );
        },
        build: (context) {
          return listrow(context);
        },
        footer: (context) {
          return pw.Column(
            children: footerReport(context),
          );
        },
      ),
    );

    /* pdf.addPage(
      pw.MultiPage(
        pageFormat: const PdfPageFormat(
          29.7 * PdfPageFormat.cm,
          21.0 * PdfPageFormat.cm,
          marginTop: 0.2 * PdfPageFormat.cm,
          marginLeft: 1.5 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 0.3 * PdfPageFormat.cm,
        ),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: headReport(context),
          );
        },
        build: (context) {
          return [signatureWidget()];
        },
        footer: (context) {
          return pw.Column(
            children: footerReport(context),
          );
        },
      ),
    ); */
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
        width: 765,
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
        width: 765,
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
      pw.Padding(padding: const pw.EdgeInsets.only(top: 3)),
      pw.Container(
        width: 765,
        height: 35,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Row(
          children: [
            buildHeadCell('Shop Name', 85),
            buildHeadCell('Thai Bath', 85),
            buildHeadCell('Foreign', 85),
            buildHeadCell('Credit Card', 85),
            buildHeadCell('E-Shop', 85),
            buildHeadCell('Pay-In', 85),
            buildHeadCell('Voucher', 85),
            buildHeadCell('Cheque', 85),
            buildHeadCell('รวม', 85),
          ],
        ),
      ),
    ];
  }

  List<pw.Widget> listrow(pw.Context context) {
    return [
      pw.Column(
        children: [
          ...typeList!.map((e) {
            return pw.Container(
              width: 765,
              height: 30,
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(
                children: [
                  buildHeadCell(e.shopName!, 85),
                  buildDataCell(convertToDouble(e.thTot), 85),
                  buildDataCell(convertToDouble(e.foreignTot), 85),
                  buildDataCell(convertToDouble(e.creditTot), 85),
                  buildDataCell(convertToDouble(e.eShop), 85),
                  buildDataCell(convertToDouble(e.payinTot), 85),
                  buildDataCell(convertToDouble(e.voucherTot), 85),
                  buildDataCell(convertToDouble(e.chequeTot), 85),
                  buildDataCell(
                    convertToDouble(
                      double.parse(e.thTot!) +
                          double.parse(e.foreignTot!) +
                          double.parse(e.creditTot!) +
                          double.parse(e.eShop!) +
                          double.parse(e.payinTot!) +
                          double.parse(e.voucherTot!) +
                          double.parse(e.chequeTot!),
                    ),
                    85,
                  ),
                ],
              ),
            );
          }).toList(),
          pw.Container(
            width: 765,
            height: 30,
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Row(
              children: [
                buildHeadCell('รวม', 85),
                buildDataCell(convertToDouble(sumTHCash), 85),
                buildDataCell(convertToDouble(sumForeingCash), 85),
                buildDataCell(convertToDouble(sumCredit), 85),
                buildDataCell(convertToDouble(sumEshop), 85),
                buildDataCell(convertToDouble(sumPayin), 85),
                buildDataCell(convertToDouble(sumVoucher), 85),
                buildDataCell(convertToDouble(sumCheque), 85),
                buildDataCell(convertToDouble(total), 85),
              ],
            ),
          ),
          pw.Container(
            width: 765,
            height: 30,
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 510,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(),
                    ),
                  ),
                  alignment: pw.Alignment.center,
                  height: 30,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    'รวมทั้งหมด',
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
                pw.Container(
                  width: 255,
                  alignment: pw.Alignment.centerRight,
                  height: 30,
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text(
                    convertToDouble(total),
                    style: pw.TextStyle(font: pg, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
          //signatureWidget(),
        ],
      ),
    ];
  }

  List<pw.Widget> footerReport(pw.Context context) {
    String dateTime = DateFormat("dd/MM/yyyy").format(DateTime.now());
    return [
      pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
      pw.Container(
        width: 765,
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

  pw.Widget signatureWidget() {
    return pw.Column(
      children: [
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
        /* pw.Container(
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
        ), */
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
        /* pw.Container(
          width: 550,
          height: 20,
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(),
            ),
          ),
        ), */
      ],
    );
  }

  pw.Widget buildDataCell(String text, double width) {
    return pw.Container(
      width: width,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          right: pw.BorderSide(),
        ),
      ),
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(text, style: pw.TextStyle(font: pg, fontSize: 12)),
    );
  }

  pw.Widget buildHeadCell(String text, double width) {
    return pw.Container(
      width: width,
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          right: pw.BorderSide(),
        ),
      ),
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(text, style: pw.TextStyle(font: pg, fontSize: 12)),
    );
  }
}
