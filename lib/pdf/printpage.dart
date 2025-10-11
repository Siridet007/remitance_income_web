import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../model/model.dart';

class PrintPage {
  pw.Font? pg;
  pw.ImageProvider? logo;

  //PrintPage();
  List<GetData>? dataList = [];
  String? date;
  // ignore: avoid_types_as_parameter_names
  String convertToDouble(num) {
    double number = double.parse(num);
    String formattedNumber = NumberFormat('#,##0.00').format(number);
    var convert = formattedNumber;
    return convert;
  }

  Future<Uint8List> genPDF({
    List<GetData>? dataList,
    String? date,
  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    pg = pw.Font.ttf(await rootBundle.load('fonts/pgvim.ttf'));
    this.dataList = dataList;
    this.date = date;
    logo = await imageFromAssetBundle('assets/Cashier_size-M.jpg');
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(40, 10, 40, 10),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (context) {
          return pw.Column(
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
    return pdf.save();
  }

  List<pw.Widget> headReport(pw.Context context) {
    return [
      pw.Container(
        width: 550,
        //  padding: pw.EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 15),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
              width: 150,
              alignment: pw.Alignment.centerLeft,
              padding: const pw.EdgeInsets.only(top: 6),
              margin: const pw.EdgeInsets.only(top: 0.5 * PdfPageFormat.cm),
              //decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Image(logo!, dpi: 800),
            ),
            pw.Container(
              width: 320,
              //decoration: pw.BoxDecoration(border: pw.Border.all()),
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Summary Income Report',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 28,
                    ),
                  ),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                  pw.Text(
                    'สรุปใบนำส่งรายได้',
                    style: pw.TextStyle(
                      font: pg,
                      fontSize: 28,
                    ),
                  ),
                  pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                  pw.Text(
                    'วันที่ $date',
                    style: pw.TextStyle(
                      font: pg,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      pw.SizedBox(height: 30),
    ];
  }

  List<pw.Widget> listrow(pw.Context context) {
    return [
      pw.Column(
        children: [
          pw.Container(
            child: pw.Column(
              children: [
                dataList!.isEmpty
                    ? pw.Container()
                    : pw.Row(
                        children: [
                          pw.Container(
                            width: 80,
                            height: 40,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            padding: const pw.EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Text(
                                  'ลำดับ',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                                pw.Text(
                                  'Item',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 300,
                            height: 40,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            padding: const pw.EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Text(
                                  'ชื่อร้านค้า',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                                pw.Text(
                                  'Shop Name',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 140,
                            height: 40,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            padding: const pw.EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceAround,
                              children: [
                                pw.Text(
                                  'ราคารวม',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                                pw.Text(
                                  'Net Amount',
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(font: pg),
                                ),
                              ],
                            ),
                          ),
                          /*pw.Container(
                        width: 60,
                        height: 20,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 2,
                            ),
                            pw.Text(
                              'สาเหตุ',
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(font: tamilFont),
                            ),
                            pw.Text(
                              'Remark',
                              textAlign: pw.TextAlign.center,
                              style:
                                  pw.TextStyle(font: TranJanFont),
                            ),
                          ],
                        ),
                      ),*/
                        ],
                      ),
                //////////////////////////////////////////////Data///////////////////////////////////////////////////////////////////////////
              ],
            ),
          ),
          pw.ListView.builder(
            itemCount: dataList!.length,
            itemBuilder: (context, index) {
              return pw.Row(
                children: [
                  pw.Container(
                    width: 80,
                    height: 30,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          '${index + 1}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(font: pg),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    width: 300,
                    height: 30,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    padding: const pw.EdgeInsets.only(left: 5),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          '${dataList![index].shopname}',
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(font: pg),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    width: 140,
                    height: 30,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    padding: const pw.EdgeInsets.only(right: 5),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          convertToDouble(dataList![index].tOTAL),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(font: pg),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          pw.Row(
            children: [
              pw.Container(
                width: 380,
                height: 30,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'รายได้รวม',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: pg),
                ),
              ),
              pw.Container(
                width: 140,
                height: 30,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                alignment: pw.Alignment.centerRight,
                padding: const pw.EdgeInsets.only(right: 5),
                child: pw.Text(
                  convertToDouble(dataList!.fold(0.0, (sum, item) => sum + double.parse(item.tOTAL!)).toString()),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(font: pg),
                ),
              ),
            ],
          ),
        ],
      )
    ];
  }

  List<pw.Widget> footerReport(pw.Context context) {
    String dateTime = DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
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
                  //decoration: pw.BoxDecoration(border: pw.Border.all()),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'page ${context.pageNumber}/${context.pagesCount}',
                    style: pw.TextStyle(
                      font: pg,
                    ),
                  ),
                ),
                pw.Container(
                  width: 150,
                  alignment: pw.Alignment.centerRight,
                  //decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Text(
                    dateTime,
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
