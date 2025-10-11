import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:remittance_income_cm/model/model.dart';
import 'package:remittance_income_cm/pdf/previewbill.dart';
import 'package:remittance_income_cm/pdf/previewdaily.dart';
import 'package:remittance_income_cm/pdf/previewpdf.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/upperCase.dart';
import '../pdf/new/printShop.dart';
import 'firstpage.dart';

class PreviewPage extends StatefulWidget {
  final List list;
  final String typeSelect;
  final String flagTab;
  final DateTime date;
  const PreviewPage(
      {super.key,
      required this.list,
      required this.typeSelect,
      required this.flagTab,
      required this.date});
  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  TextEditingController staffId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController dept = TextEditingController();
  TextEditingController creditCard = TextEditingController();
  TextEditingController fcCoin = TextEditingController();
  TextEditingController eShop = TextEditingController();
  TextEditingController voucher = TextEditingController();
  TextEditingController cheque = TextEditingController();
  TextEditingController payIn = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController giftCertificate = TextEditingController();
  TextEditingController others = TextEditingController();
  TextEditingController twentyXQuantity = TextEditingController();
  TextEditingController twentyXAmount = TextEditingController();
  TextEditingController tenXQuantity = TextEditingController();
  TextEditingController tenXAmount = TextEditingController();
  TextEditingController fiveXQuantity = TextEditingController();
  TextEditingController fiveXAmount = TextEditingController();
  TextEditingController coupon = TextEditingController();
  TextEditingController usdQuantity = TextEditingController();
  TextEditingController usdRate = TextEditingController();
  TextEditingController usdAmount = TextEditingController();
  TextEditingController sgdQuantity = TextEditingController();
  TextEditingController sgdRate = TextEditingController();
  TextEditingController sgdAmount = TextEditingController();
  TextEditingController twdQuantity = TextEditingController();
  TextEditingController twdRate = TextEditingController();
  TextEditingController twdAmount = TextEditingController();
  TextEditingController jpyQuantity = TextEditingController();
  TextEditingController jpyRate = TextEditingController();
  TextEditingController jpyAmount = TextEditingController();
  TextEditingController hkdQuantity = TextEditingController();
  TextEditingController hkdRate = TextEditingController();
  TextEditingController hkdAmount = TextEditingController();
  TextEditingController gbpQuantity = TextEditingController();
  TextEditingController gbpRate = TextEditingController();
  TextEditingController gbpAmount = TextEditingController();
  TextEditingController cnyQuantity = TextEditingController();
  TextEditingController cnyRate = TextEditingController();
  TextEditingController cnyAmount = TextEditingController();
  TextEditingController audQuantity = TextEditingController();
  TextEditingController audRate = TextEditingController();
  TextEditingController audAmount = TextEditingController();
  TextEditingController eurQuantity = TextEditingController();
  TextEditingController eurRate = TextEditingController();
  TextEditingController eurAmount = TextEditingController();
  TextEditingController foreignCurrenct = TextEditingController();
  TextEditingController firstCollection = TextEditingController();
  TextEditingController oneThousandQuantity = TextEditingController();
  TextEditingController oneThousandAmount = TextEditingController();
  TextEditingController fiveHundredQuatity = TextEditingController();
  TextEditingController fiveHundredAmount = TextEditingController();
  TextEditingController oneHundredQuatity = TextEditingController();
  TextEditingController oneHundredAmount = TextEditingController();
  TextEditingController fiftyQuantity = TextEditingController();
  TextEditingController fiftyAmount = TextEditingController();
  TextEditingController twentyQuantity = TextEditingController();
  TextEditingController twentyAmount = TextEditingController();
  TextEditingController tenQuantity = TextEditingController();
  TextEditingController tenAmount = TextEditingController();
  TextEditingController fiveQuantity = TextEditingController();
  TextEditingController fiveAmount = TextEditingController();
  TextEditingController twoQuantity = TextEditingController();
  TextEditingController twoAmount = TextEditingController();
  TextEditingController oneQuantity = TextEditingController();
  TextEditingController oneAmount = TextEditingController();
  TextEditingController dotFiftyQuantity = TextEditingController();
  TextEditingController dotFiftyAmount = TextEditingController();
  TextEditingController dotTwentyFiveQuantity = TextEditingController();
  TextEditingController dotTwentyFiveAmount = TextEditingController();
  TextEditingController noteAndCoins = TextEditingController();
  TextEditingController grandTotal = TextEditingController();
  TextEditingController refund = TextEditingController();
  TextEditingController netAmount = TextEditingController();
  TextEditingController remark = TextEditingController();
  String location = '';
  String dateTime = '';
  List<GetData>? dataList = [];
  bool dateTab = false;
  bool personTab = false;
  bool locationTab = false;
  bool creditTab = false;
  bool fcCoinTab = false;
  bool othersTab = false;
  bool couponTab = false;
  bool cerrencyTab = false;
  bool remarkTab = false;

  List<GetShop>? shopList = [];
  GetShop? takeShop;
  String takeShopName = '';
  String takeShopChar = '';
  String takeDeptCode = '';
  DateTime today = DateTime.now();
  String takeDateTime = '';
  String docNo = '';
  bool flagEnable = false;
  String nameT = '';

  Future<List<GetPerson>?> getPerson(staffId) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "get_person",
        "code": staffId,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetPerson>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetPerson.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<GetShop>?> getShop(type) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "get_shop",
        "type": type,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetShop>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetShop.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<GetShop>?> updateData(
    docno,
    type,
    date,
    usercode,
    shopcode,
    shopname,
    deptcode,
    creditTotal,
    fccoinTotal,
    eshopTot,
    voucherTot,
    chequeTot,
    payinTot,
    taxTot,
    giftTot,
    coupon20Qty,
    coupon10Qty,
    coupon5Qty,
    usdQty,
    usdRate,
    sgdQty,
    sgdRate,
    twdQty,
    twdRate,
    jpyQty,
    jpyRate,
    hkdQty,
    hkdRate,
    gbpQty,
    gbpRate,
    cnyQty,
    cnyRate,
    audQty,
    audRate,
    eurQty,
    eurRate,
    thb1000Qty,
    thb500Qty,
    thb100Qty,
    thb50Qty,
    thb20Qty,
    thb10Qty,
    thb5Qty,
    thb2Qty,
    thb1Qty,
    thb050Qty,
    thb025Qty,
    tOTAL,
    remark,
    tOTALCOUPON,
    tOTALREFUND,
    tOTALROUND1,
    flag,
  ) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "UPDATE_DATA",
        "incom_docno": docno,
        "type": type,
        "incom_date": date,
        "usercode": usercode,
        "shopcode": shopcode,
        "shopname": shopname,
        "deptcode": deptcode,
        "Credit_tot": creditTotal,
        "Fccoin_tot": fccoinTotal,
        "Eshop_tot": eshopTot,
        "Voucher_tot": voucherTot,
        "Cheque_tot": chequeTot,
        "Payin_tot": payinTot,
        "Tax_tot": taxTot,
        "Gift_tot": giftTot,
        "Coupon20_qty": coupon20Qty,
        "Coupon10_qty": coupon10Qty,
        "Coupon5_qty": coupon5Qty,
        "USD_qty": usdQty,
        "USD_rate": usdRate,
        "SGD_qty": sgdQty,
        "SGD_rate": sgdRate,
        "TWD_qty": twdQty,
        "TWD_rate": twdRate,
        "JPY_qty": jpyQty,
        "JPY_rate": jpyRate,
        "HKD_qty": hkdQty,
        "HKD_rate": hkdRate,
        "GBP_qty": gbpQty,
        "GBP_rate": gbpRate,
        "CNY_qty": cnyQty,
        "CNY_rate": cnyRate,
        "AUD_qty": audQty,
        "AUD_rate": audRate,
        "EUR_qty": eurQty,
        "EUR_rate": eurRate,
        "THB1000_qty": thb1000Qty,
        "THB500_qty": thb500Qty,
        "THB100_qty": thb100Qty,
        "THB50_qty": thb50Qty,
        "THB20_qty": thb20Qty,
        "THB10_qty": thb10Qty,
        "THB5_qty": thb5Qty,
        "THB2_qty": thb2Qty,
        "THB1_qty": thb1Qty,
        "THB050_qty": thb050Qty,
        "THB025_qty": thb025Qty,
        "TOTAL": tOTAL,
        "remark": remark,
        'TOTAL_COUPON': tOTALCOUPON,
        'TOTAL_REFUND': tOTALREFUND,
        'TOTAL_ROUND1': tOTALROUND1,
        'flag': flag,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetShop>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetShop.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(
      () {
        dateTab = true;
        personTab = false;
        locationTab = false;
        creditTab = false;
        fcCoinTab = false;
        othersTab = false;
        couponTab = false;
        cerrencyTab = false;
        remarkTab = false;
        today = day;
        takeDateTime = DateFormat('yyyy-MM-dd').format(today);
      },
    );
    //print(sendDate);
  }

  Future<dynamic> saveDialog() {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Stack(
          children: [
            const SizedBox(
              width: 510,
              height: 310,
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 500,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.pink[100],
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 500,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.fromLTRB(50, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.error_outline,
                          color: Color.fromRGBO(228, 60, 137, 1),
                          size: 70,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          'Alert',
                          style: TextStyle(
                            fontSize: 50,
                            color: Color.fromRGBO(228, 60, 137, 1),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontFamily: 'pg',
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: const [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          'ต้องการบันทึกใช่หรือไม่',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromRGBO(228, 60, 137, 1),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontFamily: 'pg',
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            elevation: MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              updateData(
                                docNo,
                                widget.typeSelect,
                                takeDateTime,
                                staffId.text,
                                takeShopChar,
                                takeShopName,
                                takeDeptCode,
                                creditCard.text,
                                fcCoin.text,
                                eShop.text,
                                voucher.text,
                                cheque.text,
                                payIn.text,
                                tax.text,
                                giftCertificate.text,
                                twentyXQuantity.text,
                                tenXQuantity.text,
                                fiveXQuantity.text,
                                usdQuantity.text,
                                usdRate.text,
                                sgdQuantity.text,
                                sgdRate.text,
                                twdQuantity.text,
                                twdRate.text,
                                jpyQuantity.text,
                                jpyRate.text,
                                hkdQuantity.text,
                                hkdRate.text,
                                gbpQuantity.text,
                                gbpRate.text,
                                cnyQuantity.text,
                                cnyRate.text,
                                audQuantity.text,
                                audRate.text,
                                eurQuantity.text,
                                eurRate.text,
                                oneThousandQuantity.text,
                                fiveHundredQuatity.text,
                                oneHundredQuatity.text,
                                fiftyQuantity.text,
                                twentyQuantity.text,
                                tenQuantity.text,
                                fiveQuantity.text,
                                twoQuantity.text,
                                oneQuantity.text,
                                dotFiftyQuantity.text,
                                dotTwentyFiveQuantity.text,
                                netAmount.text,
                                remark.text,
                                coupon.text,
                                refund.text,
                                firstCollection.text,
                                "N",
                              ).then((value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FirstPage(date: widget.date),
                                  ),
                                );
                              });
                            });
                          },
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'ใช่',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            elevation: MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'ไม่ใช่',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> loadDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          padding: const EdgeInsets.fromLTRB(50, 20, 20, 20),
          child: LoadingAnimationWidget.halfTriangleDot(
              color: Colors.pink, size: 150),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.flagTab == 'N') {
      flagEnable = true;
    } else {
      flagEnable = false;
    }
    getShop(widget.typeSelect).then((value) {
      setState(() {
        shopList = value;
      });
    });
    dataList = widget.list.cast<GetData>();
    final list = dataList!.first;
    docNo = list.incomDocno.toString();
    today = DateTime.parse(list.incomDate.toString());
    takeDateTime = DateFormat("yyyy-MM-dd").format(today);
    staffId.text = list.usercode.toString();
    takeShopChar = list.shopcode.toString();
    takeShopName = list.shopname.toString();
    getPerson(dataList!.first.usercode).then((value) {
      setState(() {
        name.text = value!.first.nameE.toString();
        dept.text = value.first.deptname.toString();
        nameT = value.first.nameT.toString();
      });
    });
    takeDeptCode = list.deptcode.toString();
    location = list.shopname.toString();
    creditCard.text = list.creditTot.toString();
    fcCoin.text = list.fccoinTot.toString();
    eShop.text = list.eshopTot.toString();
    voucher.text = list.voucherTot.toString();
    cheque.text = list.chequeTot.toString();
    payIn.text = list.payinTot.toString();
    tax.text = list.taxTot.toString();
    giftCertificate.text = list.giftTot.toString();
    others.text = (double.parse(eShop.text) +
            double.parse(voucher.text) +
            double.parse(cheque.text) +
            double.parse(payIn.text) +
            double.parse(tax.text) +
            double.parse(giftCertificate.text))
        .toString();
    twentyXQuantity.text = list.coupon20Qty.toString();
    twentyXAmount.text = (20 * double.parse(twentyXQuantity.text)).toString();
    tenXQuantity.text = list.coupon10Qty.toString();
    tenXAmount.text = (10 * double.parse(tenXQuantity.text)).toString();
    fiveXQuantity.text = list.coupon5Qty.toString();
    fiveXAmount.text = (5 * double.parse(fiveXQuantity.text)).toString();
    coupon.text = list.tOTALCOUPON.toString();
    usdQuantity.text = list.uSDQty.toString();
    usdRate.text = list.uSDRate.toString();
    usdAmount.text =
        (double.parse(usdQuantity.text) * double.parse(usdRate.text))
            .toString();
    sgdQuantity.text = list.sGDQty.toString();
    sgdRate.text = list.sGDRate.toString();
    sgdAmount.text =
        (double.parse(sgdQuantity.text) * double.parse(sgdRate.text))
            .toString();
    twdQuantity.text = list.tWDQty.toString();
    twdRate.text = list.tWDRate.toString();
    twdAmount.text =
        (double.parse(twdQuantity.text) * double.parse(twdRate.text))
            .toString();
    jpyQuantity.text = list.jPYQty.toString();
    jpyRate.text = list.jPYRate.toString();
    jpyAmount.text =
        (double.parse(jpyQuantity.text) * double.parse(jpyRate.text))
            .toString();
    hkdQuantity.text = list.hKDQty.toString();
    hkdRate.text = list.hKDRate.toString();
    hkdAmount.text =
        (double.parse(hkdQuantity.text) * double.parse(hkdRate.text))
            .toString();
    gbpQuantity.text = list.gBPQty.toString();
    gbpRate.text = list.gBPRate.toString();
    gbpAmount.text =
        (double.parse(gbpQuantity.text) * double.parse(gbpRate.text))
            .toString();
    cnyQuantity.text = list.cNYQty.toString();
    cnyRate.text = list.cNYRate.toString();
    cnyAmount.text =
        (double.parse(cnyQuantity.text) * double.parse(cnyRate.text))
            .toString();
    audQuantity.text = list.aUDQty.toString();
    audRate.text = list.aUDRate.toString();
    audAmount.text =
        (double.parse(audQuantity.text) * double.parse(audRate.text))
            .toString();
    eurQuantity.text = list.eURQty.toString();
    eurRate.text = list.eURRate.toString();
    eurAmount.text =
        (double.parse(eurQuantity.text) * double.parse(eurRate.text))
            .toString();
    foreignCurrenct.text = (double.parse(usdAmount.text) +
            double.parse(sgdAmount.text) +
            double.parse(twdAmount.text) +
            double.parse(jpyAmount.text) +
            double.parse(hkdAmount.text) +
            double.parse(gbpAmount.text) +
            double.parse(cnyAmount.text) +
            double.parse(audAmount.text) +
            double.parse(eurAmount.text))
        .toString();
    firstCollection.text = list.tOTALROUND1.toString();
    oneThousandQuantity.text = list.tHB1000Qty.toString();
    oneThousandAmount.text =
        (1000 * double.parse(oneThousandQuantity.text)).toString();
    fiveHundredQuatity.text = list.tHB500Qty.toString();
    fiveHundredAmount.text =
        (500 * double.parse(fiveHundredQuatity.text)).toString();
    oneHundredQuatity.text = list.tHB100Qty.toString();
    oneHundredAmount.text =
        (100 * double.parse(oneHundredQuatity.text)).toString();
    fiftyQuantity.text = list.tHB50Qty.toString();
    fiftyAmount.text = (50 * double.parse(fiftyQuantity.text)).toString();
    twentyQuantity.text = list.tHB20Qty.toString();
    twentyAmount.text = (20 * double.parse(twentyQuantity.text)).toString();
    tenQuantity.text = list.tHB10Qty.toString();
    tenAmount.text = (10 * double.parse(tenQuantity.text)).toString();
    fiveQuantity.text = list.tHB5Qty.toString();
    fiveAmount.text = (5 * double.parse(fiveQuantity.text)).toString();
    twoQuantity.text = list.tHB2Qty.toString();
    twoAmount.text = (2 * double.parse(twoQuantity.text)).toString();
    oneQuantity.text = list.tHB1Qty.toString();
    oneAmount.text = (1 * double.parse(oneQuantity.text)).toString();
    dotFiftyQuantity.text = list.tHB050Qty.toString();
    dotFiftyAmount.text =
        (.50 * double.parse(dotFiftyQuantity.text)).toString();
    dotTwentyFiveQuantity.text = list.tHB025Qty.toString();
    dotTwentyFiveAmount.text =
        (.25 * double.parse(dotTwentyFiveQuantity.text)).toString();
    noteAndCoins.text = (double.parse(oneThousandAmount.text) +
            double.parse(fiveHundredAmount.text) +
            double.parse(oneHundredAmount.text) +
            double.parse(fiftyAmount.text) +
            double.parse(twentyAmount.text) +
            double.parse(tenAmount.text) +
            double.parse(fiveAmount.text) +
            double.parse(twoAmount.text) +
            double.parse(oneAmount.text) +
            double.parse(dotFiftyAmount.text) +
            double.parse(dotTwentyFiveAmount.text))
        .toString();
    grandTotal.text = (double.parse(creditCard.text) +
            double.parse(fcCoin.text) +
            double.parse(others.text) +
            double.parse(foreignCurrenct.text) +
            double.parse(firstCollection.text) +
            double.parse(noteAndCoins.text))
        .toString();
    refund.text = list.tOTALREFUND.toString();
    netAmount.text =
        (double.parse(grandTotal.text) - double.parse(refund.text)).toString();
    remark.text = list.remark.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 1800;

    return Dialog(
      backgroundColor: Colors.pink[50],
      child: SingleChildScrollView(
        child: isSmallScreen
            ? Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  buttonWidget(context),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  dateSelect(),
                  personnalInfo(),
                  locationWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      creditWidget(),
                      fcCoinWidget(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      othersWidget(),
                      couponWidget(),
                    ],
                  ),
                  cerrencyWidget(),
                  remarkWidget(),
                ],
              )
            : Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  buttonWidget(context),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          dateSelect(),
                          personnalInfo(),
                          locationWidget(),
                        ],
                      ),
                      Column(
                        children: [
                          creditWidget(),
                          fcCoinWidget(),
                          othersWidget(),
                          couponWidget(),
                        ],
                      ),
                      Column(
                        children: [
                          cerrencyWidget(),
                          remarkWidget(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  SizedBox dateSelect() {
    return SizedBox(
      width: 600,
      height: !flagEnable ? 100 : 350,
      child: Card(
        elevation: 50,
        color: Colors.white,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'วันที่/Date',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.only(top: !flagEnable ? 20 : 0)),
            !flagEnable
                ? Text(
                    DateFormat('dd/MM/yyyy').format(today),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : TableCalendar(
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(
                        fontFamily: 'pg',
                        fontSize: 20,
                      ),
                      weekendTextStyle: const TextStyle(
                        fontFamily: 'pg',
                        fontSize: 20,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.pink[100],
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(
                        fontFamily: 'pg',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color.fromRGBO(228, 60, 137, 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    locale: "en_US",
                    rowHeight: 43,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    availableGestures: AvailableGestures.all,
                    focusedDay: today,
                    firstDay: DateTime.utc(1980),
                    lastDay: DateTime.utc(2050),
                    onDaySelected: _onDaySelected,
                  ),
          ],
        ),
      ),
    );
  }

  Row buttonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            widget.flagTab == 'N'
                ? InkWell(
                    onTap: () {
                      setState(() {
                        saveDialog();
                      });
                    },
                    child: Container(
                      width: 140,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.save, color: Colors.white),
                          Text(
                            'Save',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : /*widget.flagTab == 'Y'
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewPDFPage(),
                              ),
                            );
                          });
                        },
                        child: Container(
                          width: 140,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.print, color: Colors.white),
                              Text(
                                'Print',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    :*/
                Container(),
            widget.flagTab == 'A'
                ? InkWell(
                    onTap: () async {
                      loadDialog();
                      await PrintShop()
                          .printShop(
                        today,
                        nameT,
                        staffId.text,
                        dept.text,
                        takeShopName,
                        dataList!,
                        others.text,
                        twentyXAmount.text,
                        tenXAmount.text,
                        fiveXAmount.text,
                        coupon.text,
                        usdAmount.text,
                        oneThousandAmount.text,
                        sgdAmount.text,
                        fiveHundredAmount.text,
                        twdAmount.text,
                        oneHundredAmount.text,
                        jpyAmount.text,
                        fiftyAmount.text,
                        hkdAmount.text,
                        twentyAmount.text,
                        gbpAmount.text,
                        tenAmount.text,
                        cnyAmount.text,
                        fiveAmount.text,
                        audAmount.text,
                        twoAmount.text,
                        eurAmount.text,
                        oneAmount.text,
                        foreignCurrenct.text,
                        dotFiftyAmount.text,
                        dotTwentyFiveAmount.text,
                        noteAndCoins.text,
                        grandTotal.text,
                        netAmount.text,
                      )
                          .then((value) {
                        Navigator.of(context).pop();
                      });

                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewBill(
                            dataList: dataList!,
                            date: today.toString(),
                            staffID: staffId.text,
                            name: nameT,
                            dept: dept.text,
                            location: takeShopName,
                            others: others.text,
                            twentyXAmount: twentyXAmount.text,
                            tenXAmount: tenXAmount.text,
                            fiveXAmount: fiveXAmount.text,
                            coupon: coupon.text,
                            usdAmount: usdAmount.text,
                            sgdAmount: sgdAmount.text,
                            twdAmount: twdAmount.text,
                            jpyAmount: jpyAmount.text,
                            hkdAmount: hkdAmount.text,
                            gbpAmount: gbpAmount.text,
                            cnyAmount: cnyAmount.text,
                            audAmount: audAmount.text,
                            eurAmount: eurAmount.text,
                            foreignCurrenct: foreignCurrenct.text,
                            oneThousandAmount: oneThousandAmount.text,
                            fiveHundredAmount: fiveHundredAmount.text,
                            oneHundredAmount: oneHundredAmount.text,
                            fiftyAmount: fiftyAmount.text,
                            twentyAmount: twentyAmount.text,
                            tenAmount: tenAmount.text,
                            fiveAmount: fiveAmount.text,
                            twoAmount: twoAmount.text,
                            oneAmount: oneAmount.text,
                            dotFiftyAmount: dotFiftyAmount.text,
                            dotTwentyFiveAmount: dotTwentyFiveAmount.text,
                            noteAndCoins: noteAndCoins.text,
                            grandTotal: grandTotal.text,
                            netAmount: netAmount.text,
                          ),
                        ),
                      ); */
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewDialy(
                            dataList: dataList!,
                            date: today.toString(),
                          ),
                        ),
                      ); */
                    },
                    child: Container(
                      width: 140,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.print, color: Colors.white),
                          Text(
                            'Print',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            const Padding(padding: EdgeInsets.only(left: 20)),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.cancel, color: Colors.white),
                    Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 40)),
          ],
        ),
      ],
    );
  }

  SizedBox remarkWidget() {
    return SizedBox(
      width: 800,
      height: 160,
      child: Card(
        elevation: 50,
        color: remarkTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'หมายเหตุ/Remark',
              style: TextStyle(
                fontSize: 20,
                color: remarkTab ? Colors.white : Colors.black,
              ),
            ),
            Container(
              width: 780,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  color: remarkTab ? Colors.white : Colors.black,
                ),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                controller: remark,
                style: TextStyle(
                  fontSize: 20,
                  color: remarkTab ? Colors.white : Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                enabled: flagEnable,
                cursorColor: Colors.white,
                onTap: () {
                  setState(() {
                    dateTab = false;
                    dateTab = false;
                    personTab = false;
                    locationTab = false;
                    creditTab = false;
                    fcCoinTab = false;
                    othersTab = false;
                    couponTab = false;
                    cerrencyTab = false;
                    remarkTab = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox cerrencyWidget() {
    return SizedBox(
      width: 830,
      height: 660,
      child: Card(
        elevation: 50,
        color:
            cerrencyTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 430,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'เงินสกุลต่างประเทศ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Foreign Currency',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 280,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'จำนวน X มูลค่า',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Quantity X Rate',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'จำนวนเงิน',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'USD',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            controller: usdQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            minLines: 1,
                            enabled: flagEnable,
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  usdQuantity.clear();
                                  usdAmount.text =
                                      (double.parse(usdRate.text) * 0)
                                          .toString();
                                } else {
                                  if (usdRate.text.isEmpty) {
                                    usdRate.text = '0';
                                  }
                                  usdAmount.text =
                                      (double.parse(usdQuantity.text) *
                                              double.parse(usdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: usdRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  usdRate.clear();
                                  usdAmount.text =
                                      (double.parse(usdQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (usdQuantity.text.isEmpty) {
                                    usdQuantity.text = '0';
                                  }
                                  usdAmount.text =
                                      (double.parse(usdQuantity.text) *
                                              double.parse(usdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: usdAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'SGD',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: sgdQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  sgdQuantity.clear();
                                  sgdAmount.text =
                                      (double.parse(sgdRate.text) * 0)
                                          .toString();
                                } else {
                                  if (sgdRate.text.isEmpty) {
                                    sgdRate.text = '0';
                                  }
                                  sgdAmount.text =
                                      (double.parse(sgdQuantity.text) *
                                              double.parse(sgdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: sgdRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  sgdRate.clear();
                                  sgdAmount.text =
                                      (double.parse(sgdQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (sgdQuantity.text.isEmpty) {
                                    sgdQuantity.text = '0';
                                  }
                                  sgdAmount.text =
                                      (double.parse(sgdQuantity.text) *
                                              double.parse(sgdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: sgdAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'TWD',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twdQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twdQuantity.clear();
                                  twdAmount.text =
                                      (double.parse(twdRate.text) * 0)
                                          .toString();
                                } else {
                                  if (twdRate.text.isEmpty) {
                                    twdRate.text = '0';
                                  }
                                  twdAmount.text =
                                      (double.parse(twdQuantity.text) *
                                              double.parse(twdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twdRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twdRate.clear();
                                  twdAmount.text =
                                      (double.parse(twdQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (twdQuantity.text.isEmpty) {
                                    twdQuantity.text = '0';
                                  }
                                  twdAmount.text =
                                      (double.parse(twdQuantity.text) *
                                              double.parse(twdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twdAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'JPY',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: jpyQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  jpyQuantity.clear();
                                  jpyAmount.text =
                                      (double.parse(jpyRate.text) * 0)
                                          .toString();
                                } else {
                                  if (jpyRate.text.isEmpty) {
                                    jpyRate.text = '0';
                                  }
                                  jpyAmount.text =
                                      (double.parse(jpyQuantity.text) *
                                              double.parse(jpyRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: jpyRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  jpyRate.clear();
                                  jpyAmount.text =
                                      (double.parse(jpyQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (jpyQuantity.text.isEmpty) {
                                    jpyQuantity.text = '0';
                                  }
                                  jpyAmount.text =
                                      (double.parse(jpyQuantity.text) *
                                              double.parse(jpyRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: jpyAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'HKD',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: hkdQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  hkdQuantity.clear();
                                  hkdAmount.text =
                                      (double.parse(hkdRate.text) * 0)
                                          .toString();
                                } else {
                                  if (hkdRate.text.isEmpty) {
                                    hkdRate.text = '0';
                                  }
                                  hkdAmount.text =
                                      (double.parse(hkdQuantity.text) *
                                              double.parse(hkdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: hkdRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  hkdRate.clear();
                                  hkdAmount.text =
                                      (double.parse(hkdQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (hkdQuantity.text.isEmpty) {
                                    hkdQuantity.text = '0';
                                  }
                                  hkdAmount.text =
                                      (double.parse(hkdQuantity.text) *
                                              double.parse(hkdRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: hkdAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'GBP',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: gbpQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  gbpQuantity.clear();
                                  gbpAmount.text =
                                      (double.parse(gbpRate.text) * 0)
                                          .toString();
                                } else {
                                  if (gbpRate.text.isEmpty) {
                                    gbpRate.text = '0';
                                  }
                                  gbpAmount.text =
                                      (double.parse(gbpQuantity.text) *
                                              double.parse(gbpRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: gbpRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  gbpRate.clear();
                                  gbpAmount.text =
                                      (double.parse(gbpQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (gbpQuantity.text.isEmpty) {
                                    gbpQuantity.text = '0';
                                  }
                                  gbpAmount.text =
                                      (double.parse(gbpQuantity.text) *
                                              double.parse(gbpRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: gbpAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'CNY',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: cnyQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  cnyQuantity.clear();
                                  cnyAmount.text =
                                      (double.parse(cnyRate.text) * 0)
                                          .toString();
                                } else {
                                  if (cnyRate.text.isEmpty) {
                                    cnyRate.text = '0';
                                  }
                                  cnyAmount.text =
                                      (double.parse(cnyQuantity.text) *
                                              double.parse(cnyRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: cnyRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  cnyRate.clear();
                                  cnyAmount.text =
                                      (double.parse(cnyQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (cnyQuantity.text.isEmpty) {
                                    cnyQuantity.text = '0';
                                  }
                                  cnyAmount.text =
                                      (double.parse(cnyQuantity.text) *
                                              double.parse(cnyRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: cnyAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'AUD',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: audQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  audQuantity.clear();
                                  audAmount.text =
                                      (double.parse(audRate.text) * 0)
                                          .toString();
                                } else {
                                  if (audRate.text.isEmpty) {
                                    audRate.text = '0';
                                  }
                                  audAmount.text =
                                      (double.parse(audQuantity.text) *
                                              double.parse(audRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: audRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  audRate.clear();
                                  audAmount.text =
                                      (double.parse(audQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (audQuantity.text.isEmpty) {
                                    audQuantity.text = '0';
                                  }
                                  audAmount.text =
                                      (double.parse(audQuantity.text) *
                                              double.parse(audRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: audAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'EUR',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: eurQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  eurQuantity.clear();
                                  eurAmount.text =
                                      (double.parse(eurRate.text) * 0)
                                          .toString();
                                } else {
                                  if (eurRate.text.isEmpty) {
                                    eurRate.text = '0';
                                  }
                                  eurAmount.text =
                                      (double.parse(eurQuantity.text) *
                                              double.parse(eurRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: eurRate,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  eurRate.clear();
                                  eurAmount.text =
                                      (double.parse(eurQuantity.text) * 0)
                                          .toString();
                                } else {
                                  if (eurQuantity.text.isEmpty) {
                                    eurQuantity.text = '0';
                                  }
                                  eurAmount.text =
                                      (double.parse(eurQuantity.text) *
                                              double.parse(eurRate.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: eurAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 280,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '(4)รวม/Total',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          //padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: foreignCurrenct,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (usdAmount.text.isEmpty) {
                                      usdAmount.text = '0';
                                    }
                                    if (sgdAmount.text.isEmpty) {
                                      sgdAmount.text = '0';
                                    }
                                    if (twdAmount.text.isEmpty) {
                                      twdAmount.text = '0';
                                    }
                                    if (jpyAmount.text.isEmpty) {
                                      jpyAmount.text = '0';
                                    }
                                    if (hkdAmount.text.isEmpty) {
                                      hkdAmount.text = '0';
                                    }
                                    if (gbpAmount.text.isEmpty) {
                                      gbpAmount.text = '0';
                                    }
                                    if (cnyAmount.text.isEmpty) {
                                      cnyAmount.text = '0';
                                    }
                                    if (audAmount.text.isEmpty) {
                                      audAmount.text = '0';
                                    }
                                    if (eurAmount.text.isEmpty) {
                                      eurAmount.text = '0';
                                    }
                                    foreignCurrenct.text =
                                        (double.parse(usdAmount.text) +
                                                double.parse(sgdAmount.text) +
                                                double.parse(twdAmount.text) +
                                                double.parse(jpyAmount.text) +
                                                double.parse(hkdAmount.text) +
                                                double.parse(gbpAmount.text) +
                                                double.parse(cnyAmount.text) +
                                                double.parse(audAmount.text) +
                                                double.parse(eurAmount.text))
                                            .toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 430,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            'รายได้รอบ1/Amount (First Collection)',
                            style: TextStyle(
                              fontSize: 18,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 280,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '(5)เงินสด/Cash',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: firstCollection,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              top: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'ธนบัตรและเหรียญกษาปณ์',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Notes & Coins',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'ประเภท',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Type',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'จำนวน',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'จำนวนเงิน',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'Amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      cerrencyTab ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '1000',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneThousandQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneThousandQuantity.clear();
                                  oneThousandAmount.text =
                                      (1000 * 0).toString();
                                } else {
                                  oneThousandAmount.text = (1000 *
                                          double.parse(
                                              oneThousandQuantity.text))
                                      .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneThousandAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '500',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiveHundredQuatity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiveHundredQuatity.clear();
                                  fiveHundredAmount.text = (500 * 0).toString();
                                } else {
                                  fiveHundredAmount.text = (500 *
                                          double.parse(fiveHundredQuatity.text))
                                      .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiveHundredAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '100',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneHundredQuatity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneHundredQuatity.clear();
                                  oneHundredAmount.text = (100 * 0).toString();
                                } else {
                                  oneHundredAmount.text = (100 *
                                          double.parse(oneHundredQuatity.text))
                                      .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneHundredAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '50',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiftyQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiftyQuantity.clear();
                                  fiftyAmount.text = (50 * 0).toString();
                                } else {
                                  fiftyAmount.text =
                                      (50 * double.parse(fiftyQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiftyAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '20',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twentyQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twentyQuantity.clear();
                                  twentyAmount.text = (20 * 0).toString();
                                } else {
                                  twentyAmount.text =
                                      (20 * double.parse(twentyQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twentyAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '10',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: tenQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  tenQuantity.clear();
                                  tenAmount.text = (10 * 0).toString();
                                } else {
                                  tenAmount.text =
                                      (10 * double.parse(tenQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: tenAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '5',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiveQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiveQuantity.clear();
                                  fiveAmount.text = (5 * 0).toString();
                                } else {
                                  fiveAmount.text =
                                      (5 * double.parse(fiveQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: fiveAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twoQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twoQuantity.clear();
                                  twoAmount.text = (2 * 0).toString();
                                } else {
                                  twoAmount.text =
                                      (2 * double.parse(twoQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: twoAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneQuantity.clear();
                                  oneAmount.text = (1 * 0).toString();
                                } else {
                                  oneAmount.text =
                                      (1 * double.parse(oneQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: oneAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '0.50',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: dotFiftyQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  dotFiftyQuantity.clear();
                                  dotFiftyAmount.text = (1 * 0).toString();
                                } else {
                                  dotFiftyAmount.text =
                                      (1 * double.parse(dotFiftyQuantity.text))
                                          .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: dotFiftyAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '0.25',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: dotTwentyFiveQuantity,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  dotTwentyFiveQuantity.clear();
                                  dotTwentyFiveAmount.text = (1 * 0).toString();
                                } else {
                                  dotTwentyFiveAmount.text = (1 *
                                          double.parse(
                                              dotTwentyFiveQuantity.text))
                                      .toString();
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: dotTwentyFiveAmount,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 225,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          child: Text(
                            '(6)รวม/Total',
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                              right: BorderSide(
                                color:
                                    cerrencyTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: noteAndCoins,
                            style: TextStyle(
                              fontSize: 20,
                              color: cerrencyTab ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (oneThousandAmount.text.isEmpty) {
                                      oneThousandAmount.text = '0';
                                    }
                                    if (fiveHundredAmount.text.isEmpty) {
                                      fiveHundredAmount.text = '0';
                                    }
                                    if (oneHundredAmount.text.isEmpty) {
                                      oneHundredAmount.text = '0';
                                    }
                                    if (fiftyAmount.text.isEmpty) {
                                      fiftyAmount.text = '0';
                                    }
                                    if (twentyAmount.text.isEmpty) {
                                      twentyAmount.text = '0';
                                    }
                                    if (tenAmount.text.isEmpty) {
                                      tenAmount.text = '0';
                                    }
                                    if (fiveAmount.text.isEmpty) {
                                      fiveAmount.text = '0';
                                    }
                                    if (twoAmount.text.isEmpty) {
                                      twoAmount.text = '0';
                                    }
                                    if (oneAmount.text.isEmpty) {
                                      oneAmount.text = '0';
                                    }
                                    if (dotFiftyAmount.text.isEmpty) {
                                      dotFiftyAmount.text = '0';
                                    }
                                    if (dotTwentyFiveAmount.text.isEmpty) {
                                      dotTwentyFiveAmount.text = '0';
                                    }
                                    noteAndCoins.text = (double.parse(
                                                oneThousandAmount.text) +
                                            double.parse(
                                                fiveHundredAmount.text) +
                                            double.parse(
                                                oneHundredAmount.text) +
                                            double.parse(fiftyAmount.text) +
                                            double.parse(twentyAmount.text) +
                                            double.parse(tenAmount.text) +
                                            double.parse(fiveAmount.text) +
                                            double.parse(twoAmount.text) +
                                            double.parse(oneAmount.text) +
                                            double.parse(dotFiftyAmount.text) +
                                            double.parse(
                                                dotTwentyFiveAmount.text))
                                        .toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            cursorColor: Colors.white,
                            enabled: flagEnable,
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = false;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = true;
                                remarkTab = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 655,
                  height: 50,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  child: Text(
                    'รวมทั้งสิ้น/Grand Total(1)+(2)+(3)+(4)+(5)+(6)',
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: grandTotal,
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (creditCard.text.isEmpty) {
                              creditCard.text = '0';
                            }
                            if (fcCoin.text.isEmpty) {
                              fcCoin.text = '0';
                            }
                            if (others.text.isEmpty) {
                              others.text = '0';
                            }
                            if (foreignCurrenct.text.isEmpty) {
                              foreignCurrenct.text = '0';
                            }
                            if (firstCollection.text.isEmpty) {
                              firstCollection.text = '0';
                            }
                            if (noteAndCoins.text.isEmpty) {
                              noteAndCoins.text = '0';
                            }
                            grandTotal.text = (double.parse(creditCard.text) +
                                    double.parse(fcCoin.text) +
                                    double.parse(others.text) +
                                    double.parse(foreignCurrenct.text) +
                                    double.parse(firstCollection.text) +
                                    double.parse(noteAndCoins.text))
                                .toString();
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = false;
                        cerrencyTab = true;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 655,
                  height: 30,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                      color: cerrencyTab ? Colors.white : Colors.black,
                    )),
                  ),
                  child: Text(
                    'หักรับคืนคูปอง/Refund',
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: refund,
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = false;
                        cerrencyTab = true;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 655,
                  height: 60,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                      color: cerrencyTab ? Colors.white : Colors.black,
                    )),
                  ),
                  child: Text(
                    'รวมรายได้สุทธิ/Net Amount',
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 155,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: cerrencyTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: netAmount,
                    style: TextStyle(
                      fontSize: 20,
                      color: cerrencyTab ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (grandTotal.text.isEmpty) {
                              grandTotal.text = '0';
                            }
                            if (refund.text.isEmpty) {
                              refund.text = '0';
                            }
                            netAmount.text = (double.parse(grandTotal.text) -
                                    double.parse(refund.text))
                                .toString();
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = false;
                        cerrencyTab = true;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox couponWidget() {
    return SizedBox(
      width: 400,
      height: 280,
      child: Card(
        elevation: 50,
        color: couponTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: couponTab ? Colors.white : Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'คูปอง',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Coupon',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'จำนวน',
                        style: TextStyle(
                          fontSize: 20,
                          color: couponTab ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 20,
                          color: couponTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 190,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'จำนวนเงิน',
                        style: TextStyle(
                          fontSize: 20,
                          color: couponTab ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 20,
                          color: couponTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '20 X',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: twentyXQuantity,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value == '') {
                          twentyXAmount.text = '';
                        } else {
                          twentyXAmount.text =
                              (double.parse(twentyXQuantity.text) * 20)
                                  .toString();
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: twentyXAmount,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '10 X',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: tenXQuantity,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value == '') {
                          tenXAmount.text = '';
                        } else {
                          tenXAmount.text =
                              (double.parse(tenXQuantity.text) * 10).toString();
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: tenXAmount,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '5 X',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: fiveXQuantity,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value == '') {
                          fiveXAmount.text = '';
                        } else {
                          fiveXAmount.text =
                              (double.parse(fiveXQuantity.text) * 5).toString();
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: fiveXAmount,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'รวม/Total',
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: couponTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: coupon,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: couponTab ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (twentyXAmount.text.isEmpty) {
                              twentyXAmount.text = '0';
                            }
                            if (tenXAmount.text.isEmpty) {
                              tenXAmount.text = '0';
                            }
                            if (fiveXAmount.text.isEmpty) {
                              fiveXAmount.text = '0';
                            }
                            coupon.text = (double.parse(twentyXAmount.text) +
                                    double.parse(tenXAmount.text) +
                                    double.parse(fiveXAmount.text))
                                .toString();
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = false;
                        couponTab = true;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox othersWidget() {
    return SizedBox(
      width: 400,
      height: 280,
      child: Card(
        elevation: 50,
        color: othersTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 380,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: othersTab ? Colors.white : Colors.black,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Others',
                style: TextStyle(
                  fontSize: 20,
                  color: othersTab ? Colors.white : Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'E-SHOP',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: eShop,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'VOUCHER',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: voucher,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'CHEQUE',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: cheque,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'PAY-IN',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: payIn,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'TAX',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: tax,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'GIFT CERTIFICATE',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: giftCertificate,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '(3)รวม/Total',
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 190,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                      right: BorderSide(
                        color: othersTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: others,
                    cursorColor: Colors.white,
                    enabled: flagEnable,
                    style: TextStyle(
                      fontSize: 20,
                      color: othersTab ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (eShop.text.isEmpty) {
                              eShop.text = '0';
                            }
                            if (voucher.text.isEmpty) {
                              voucher.text = '0';
                            }
                            if (cheque.text.isEmpty) {
                              cheque.text = '0';
                            }
                            if (payIn.text.isEmpty) {
                              payIn.text = '0';
                            }
                            if (tax.text.isEmpty) {
                              tax.text = '0';
                            }
                            if (giftCertificate.text.isEmpty) {
                              giftCertificate.text = '0';
                            }
                            others.text = (double.parse(eShop.text) +
                                    double.parse(voucher.text) +
                                    double.parse(cheque.text) +
                                    double.parse(payIn.text) +
                                    double.parse(tax.text) +
                                    double.parse(giftCertificate.text))
                                .toString();
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        dateTab = false;
                        personTab = false;
                        locationTab = false;
                        creditTab = false;
                        fcCoinTab = false;
                        othersTab = true;
                        couponTab = false;
                        cerrencyTab = false;
                        remarkTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox fcCoinWidget() {
    return SizedBox(
      width: 400,
      height: 120,
      child: Card(
        elevation: 50,
        color: fcCoinTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: fcCoinTab ? Colors.white : Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'เอฟซีคอยน์',
                    style: TextStyle(
                      fontSize: 20,
                      color: fcCoinTab ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'FC Coin',
                    style: TextStyle(
                      fontSize: 20,
                      color: fcCoinTab ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 380,
              height: 30,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: fcCoinTab ? Colors.white : Colors.black,
                  ),
                  bottom: BorderSide(
                    color: fcCoinTab ? Colors.white : Colors.black,
                  ),
                  right: BorderSide(
                    color: fcCoinTab ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 190,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: fcCoinTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      '(2)รวม/Total',
                      style: TextStyle(
                        fontSize: 20,
                        color: fcCoinTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 185,
                    height: 30,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: fcCoin,
                      cursorColor: Colors.white,
                      enabled: flagEnable,
                      style: TextStyle(
                        fontSize: 20,
                        color: fcCoinTab ? Colors.white : Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          dateTab = false;
                          personTab = false;
                          locationTab = false;
                          creditTab = false;
                          fcCoinTab = true;
                          othersTab = false;
                          couponTab = false;
                          cerrencyTab = false;
                          remarkTab = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox creditWidget() {
    return SizedBox(
      width: 400,
      height: 120,
      child: Card(
        elevation: 50,
        color: creditTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 380,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: creditTab ? Colors.white : Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'บัตรเครดิต',
                    style: TextStyle(
                      fontSize: 20,
                      color: creditTab ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Credit Card',
                    style: TextStyle(
                      fontSize: 20,
                      color: creditTab ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 380,
              height: 30,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: creditTab ? Colors.white : Colors.black,
                  ),
                  bottom: BorderSide(
                    color: creditTab ? Colors.white : Colors.black,
                  ),
                  right: BorderSide(
                    color: creditTab ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 190,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: creditTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      '(1)รวม/Total',
                      style: TextStyle(
                        fontSize: 20,
                        color: creditTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 185,
                    height: 30,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: creditCard,
                      style: TextStyle(
                        fontSize: 20,
                        color: creditTab ? Colors.white : Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.white,
                      enabled: flagEnable,
                      onTap: () {
                        setState(() {
                          dateTab = false;
                          personTab = false;
                          locationTab = false;
                          creditTab = true;
                          fcCoinTab = false;
                          othersTab = false;
                          couponTab = false;
                          cerrencyTab = false;
                          remarkTab = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox locationWidget() {
    return SizedBox(
      width: 600,
      height: 100,
      child: Card(
        elevation: 50,
        color:
            locationTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'จุดสร้างรายได้/Location',
              style: TextStyle(
                fontSize: 20,
                color: !locationTab ? Colors.black : Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: !flagEnable ? 20 : 0)),
            !flagEnable
                ? Text(
                    takeShopName,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : widget.typeSelect == 'TK' || widget.typeSelect == 'OTH'
                    ? Text(
                        widget.typeSelect == 'TK' ? 'Ticket' : 'อื่นๆ',
                        style: TextStyle(
                          fontSize: 20,
                          color: !locationTab ? Colors.black : Colors.white,
                        ),
                      )
                    : Container(
                        width: 580,
                        height: 50,
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        decoration: BoxDecoration(
                          color: locationTab
                              ? const Color.fromRGBO(228, 60, 137, 1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: !locationTab ? Colors.black : Colors.white,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: locationTab
                                ? const Color.fromRGBO(228, 60, 137, 1)
                                : Colors.white,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                              color: !locationTab ? Colors.black : Colors.white,
                            ),
                            items: shopList!.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.shopname.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: !locationTab
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                takeShop = value;
                                takeShopChar = takeShop!.shopchar.toString();
                                takeShopName = takeShop!.shopname.toString();
                              });
                            },
                            onTap: () {
                              setState(() {
                                dateTab = false;
                                personTab = false;
                                locationTab = true;
                                creditTab = false;
                                fcCoinTab = false;
                                othersTab = false;
                                couponTab = false;
                                cerrencyTab = false;
                                remarkTab = false;
                              });
                            },
                            value: takeShop,
                            style: TextStyle(
                              fontFamily: 'pg',
                              fontSize: 20,
                              color: !locationTab ? Colors.black : Colors.white,
                            ),
                            hint: Text(
                              location,
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    locationTab ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  SizedBox personnalInfo() {
    return SizedBox(
      width: 600,
      height: 200,
      child: Card(
        elevation: 50,
        color: personTab ? const Color.fromRGBO(228, 60, 137, 1) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 580,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: personTab ? Colors.white : Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'ข้อมูลผู้นำส่ง',
                    style: TextStyle(
                      fontSize: 20,
                      color: personTab ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Personal Info',
                    style: TextStyle(
                      fontSize: 20,
                      color: personTab ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 580,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  bottom: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  right: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: personTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      'เลขประจำตัว/Staff ID',
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 375,
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: staffId,
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: staffId.text.isEmpty
                              ? null
                              : () {
                                  getPerson(staffId.text).then((value) {
                                    setState(() {
                                      name.text = value!.first.nameE.toString();
                                      dept.text =
                                          value.first.deptname.toString();
                                      takeDeptCode =
                                          value.first.deptcode.toString();
                                      nameT = value.first.nameT.toString();
                                    });
                                  });
                                },
                          icon: Icon(
                            Icons.search,
                            color: personTab ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      cursorColor: Colors.white,
                      enabled: flagEnable,
                      onTap: () {
                        setState(() {
                          dateTab = false;
                          personTab = true;
                          locationTab = false;
                          creditTab = false;
                          fcCoinTab = false;
                          othersTab = false;
                          couponTab = false;
                          cerrencyTab = false;
                          remarkTab = false;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          getPerson(value).then((value) {
                            setState(() {
                              name.text = value!.first.nameE.toString();
                              dept.text = value.first.deptname.toString();
                              nameT = value.first.nameT.toString();
                            });
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 580,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  bottom: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  right: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: personTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      'ชื่อ/Name',
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 375,
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: name,
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.white,
                      enabled: flagEnable,
                      onTap: () {
                        setState(() {
                          dateTab = false;
                          personTab = true;
                          creditTab = false;
                          fcCoinTab = false;
                          othersTab = false;
                          couponTab = false;
                          cerrencyTab = false;
                          remarkTab = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 580,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  bottom: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                  right: BorderSide(
                    color: personTab ? Colors.white : Colors.black,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: personTab ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      'ฝ่าย/Depertment',
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: 375,
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: dept,
                      style: TextStyle(
                        fontSize: 20,
                        color: personTab ? Colors.white : Colors.black,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      cursorColor: Colors.white,
                      enabled: flagEnable,
                      onTap: () {
                        setState(() {
                          dateTab = false;
                          personTab = true;
                          locationTab = false;
                          creditTab = false;
                          fcCoinTab = false;
                          othersTab = false;
                          couponTab = false;
                          cerrencyTab = false;
                          remarkTab = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
