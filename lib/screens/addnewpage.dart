import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remittance_income_cm/model/model.dart';
import 'package:remittance_income_cm/screens/firstpage.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/upperCase.dart';

class AddNewPage extends StatefulWidget {
  final String typeSelect;
  final String typeName;
  final DateTime date;
  const AddNewPage(
      {super.key,
      required this.typeSelect,
      required this.typeName,
      required this.date});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
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
  List<GetExchange>? exchangeList = [];
  String nameT = '';

  String addLeadingZeroIfNeeded(String input) {
    if (input.startsWith('.')) {
      return '0$input';
    }
    return input;
  }

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
      var result;
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
      var result;
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

  Future<List<GetShop>?> insertData(
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
  ) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "INSERT_DATA",
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
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      var result;
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
    setState(() {
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
      takeDateTime = DateFormat('yyyy-MM-dd').format(widget.date);
      print(takeDateTime);
    });
    //print(sendDate);
  }

  Future<List<GetExchange>?> getExchange() async {
    FormData formData = FormData.fromMap(
      {
        "mode": "exchang_rate",
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetExchange>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetExchange.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
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
                              insertData(
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
                              ).then((value) {
                                Navigator.of(context).pop([1]);
                                Navigator.of(context).pop([1]);
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

  @override
  void initState() {
    super.initState();
    takeDateTime = DateFormat('yyyy-MM-dd').format(widget.date);
    takeShopChar = widget.typeSelect;
    takeShopName = widget.typeName;
    print(takeShopChar);
    print(takeShopName);
    getShop(widget.typeSelect).then((value) {
      setState(() {
        shopList = value;
      });
    });
    getExchange().then((value) {
      setState(() {
        exchangeList = value;
        usdRate.text = exchangeList![0].buying!;
        eurRate.text = exchangeList![1].buying!;
        gbpRate.text = exchangeList![2].buying!;
        jpyRate.text = exchangeList![3].buying!;
        sgdRate.text = exchangeList![4].buying!;
        hkdRate.text = exchangeList![5].buying!;
        audRate.text = exchangeList![6].buying!;
        cnyRate.text = exchangeList![7].buying!;
        twdRate.text = exchangeList![8].buying!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 1800;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: isSmallScreen
            ? Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  buttonWidget(context),
                  const Padding(padding: EdgeInsets.only(top: 10)),
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
      height: 400,
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
            TableCalendar(
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
              selectedDayPredicate: (day) => isSameDay(day, widget.date),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 40)),
            SizedBox(
              width: 220,
              height: 60,
              child: Card(
                elevation: 50,
                color: Colors.pink[100],
                child: Center(
                  child: Text(
                    widget.typeName,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: staffId.text.isEmpty ||
                      takeShopChar == '' ||
                      creditCard.text.isEmpty ||
                      fcCoin.text.isEmpty ||
                      others.text.isEmpty ||
                      coupon.text.isEmpty ||
                      foreignCurrenct.text.isEmpty ||
                      firstCollection.text.isEmpty ||
                      noteAndCoins.text.isEmpty ||
                      refund.text.isEmpty ||
                      netAmount.text.isEmpty
                  ? null
                  : () {
                      setState(() {
                        print('type => ' + widget.typeSelect);
                        print('date => ' + takeDateTime);
                        print('staff => ' + staffId.text);
                        print('shopchar => ' + takeShopChar);
                        print('shopname => ' + takeShopName);
                        print('dept => ' + takeDeptCode);
                        print('credit => ' + creditCard.text);
                        print('fc => ' + fcCoin.text);
                        print('eshop => ' + eShop.text);
                        print('voucher => ' + voucher.text);
                        print('cheque => ' + cheque.text);
                        print('payIn => ' + payIn.text);
                        print('tax => ' + tax.text);
                        print('giftCertificate => ' + giftCertificate.text);
                        print('twentyX => ' + twentyXQuantity.text);
                        print('tenX => ' + tenXQuantity.text);
                        print('fiveX => ' + fiveXQuantity.text);
                        print('usdQuantity => ' + usdQuantity.text);
                        print('usdRate => ' + usdRate.text);
                        print('sgdQuantity => ' + sgdQuantity.text);
                        print('sgdRate => ' + sgdRate.text);
                        print('twdQuantity => ' + twdQuantity.text);
                        print('twdRate => ' + twdRate.text);
                        print('jpyQuantity => ' + jpyQuantity.text);
                        print('jpyRate => ' + jpyRate.text);
                        print('hkdQuantity => ' + hkdQuantity.text);
                        print('hkdRate => ' + hkdRate.text);
                        print('gbpQuantity => ' + gbpQuantity.text);
                        print('gbpRate => ' + gbpRate.text);
                        print('cnyQuantity => ' + cnyQuantity.text);
                        print('cnyRate => ' + cnyRate.text);
                        print('audQuantity => ' + audQuantity.text);
                        print('audRate => ' + audRate.text);
                        print('eurQuantity => ' + eurQuantity.text);
                        print('eurRate => ' + eurRate.text);
                        print('oneThousandQuantity => ' +
                            oneThousandQuantity.text);
                        print(
                            'fiveHundredQuatity => ' + fiveHundredQuatity.text);
                        print('oneHundredQuatity => ' + oneHundredQuatity.text);
                        print('fiftyQuantity => ' + fiftyQuantity.text);
                        print('twentyQuantity => ' + twentyQuantity.text);
                        print('tenQuantity => ' + tenQuantity.text);
                        print('fiveQuantity => ' + fiveQuantity.text);
                        print('twoQuantity => ' + twoQuantity.text);
                        print('oneQuantity => ' + oneQuantity.text);
                        print('dotFiftyQuantity => ' + dotFiftyQuantity.text);
                        print('dotTwentyFiveQuantity => ' +
                            dotTwentyFiveQuantity.text);
                        print('netAmount => ' + netAmount.text);
                        print('remark => ' + remark.text);

                        saveDialog();
                      });
                    },
              child: Container(
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: staffId.text.isEmpty ||
                          takeShopChar == '' ||
                          creditCard.text.isEmpty ||
                          fcCoin.text.isEmpty ||
                          others.text.isEmpty ||
                          coupon.text.isEmpty ||
                          foreignCurrenct.text.isEmpty ||
                          firstCollection.text.isEmpty ||
                          noteAndCoins.text.isEmpty ||
                          refund.text.isEmpty ||
                          netAmount.text.isEmpty
                      ? Colors.grey
                      : Colors.green,
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
            ),
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
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  usdQuantity.clear();
                                  usdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  usdRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (usdRate.text.isEmpty) {
                                    usdRate.text = '0';
                                  }
                                  usdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  usdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              usdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  usdRate.clear();
                                  usdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  usdQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (usdQuantity.text.isEmpty) {
                                    usdQuantity.text = '0';
                                  }
                                  usdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  usdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              usdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  sgdQuantity.clear();
                                  sgdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  sgdRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (sgdRate.text.isEmpty) {
                                    sgdRate.text = '0';
                                  }
                                  sgdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  sgdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              sgdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  sgdRate.clear();
                                  sgdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  sgdQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (sgdQuantity.text.isEmpty) {
                                    sgdQuantity.text = '0';
                                  }
                                  sgdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  sgdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              sgdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twdQuantity.clear();
                                  twdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  twdRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (twdRate.text.isEmpty) {
                                    twdRate.text = '0';
                                  }
                                  twdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  twdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              twdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twdRate.clear();
                                  twdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  twdQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (twdQuantity.text.isEmpty) {
                                    twdQuantity.text = '0';
                                  }
                                  twdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  twdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              twdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  jpyQuantity.clear();
                                  jpyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  jpyRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (jpyRate.text.isEmpty) {
                                    jpyRate.text = '0';
                                  }
                                  jpyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  jpyQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              jpyRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  jpyRate.clear();
                                  jpyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  jpyQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (jpyQuantity.text.isEmpty) {
                                    jpyQuantity.text = '0';
                                  }
                                  jpyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  jpyQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              jpyRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  hkdQuantity.clear();
                                  hkdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  hkdRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (hkdRate.text.isEmpty) {
                                    hkdRate.text = '0';
                                  }
                                  hkdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  hkdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              hkdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  hkdRate.clear();
                                  hkdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  hkdQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (hkdQuantity.text.isEmpty) {
                                    hkdQuantity.text = '0';
                                  }
                                  hkdAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  hkdQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              hkdRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  gbpQuantity.clear();
                                  gbpAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  gbpRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (gbpRate.text.isEmpty) {
                                    gbpRate.text = '0';
                                  }
                                  gbpAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  gbpQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              gbpRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  gbpRate.clear();
                                  gbpAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  gbpQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (gbpQuantity.text.isEmpty) {
                                    gbpQuantity.text = '0';
                                  }
                                  gbpAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  gbpQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              gbpRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  cnyQuantity.clear();
                                  cnyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  cnyRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (cnyRate.text.isEmpty) {
                                    cnyRate.text = '0';
                                  }
                                  cnyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  cnyQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              cnyRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  cnyRate.clear();
                                  cnyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  cnyQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (cnyQuantity.text.isEmpty) {
                                    cnyQuantity.text = '0';
                                  }
                                  cnyAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  cnyQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              cnyRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  audQuantity.clear();
                                  audAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  audRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (audRate.text.isEmpty) {
                                    audRate.text = '0';
                                  }
                                  audAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  audQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              audRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  audRate.clear();
                                  audAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  audQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (audQuantity.text.isEmpty) {
                                    audQuantity.text = '0';
                                  }
                                  audAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  audQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              audRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  eurQuantity.clear();
                                  eurAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  eurRate.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (eurRate.text.isEmpty) {
                                    eurRate.text = '0';
                                  }
                                  eurAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  eurQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              eurRate.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  eurRate.clear();
                                  eurAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  eurQuantity.text)) *
                                          0)
                                      .toStringAsFixed(2);
                                } else {
                                  if (eurQuantity.text.isEmpty) {
                                    eurQuantity.text = '0';
                                  }
                                  eurAmount.text = (double.parse(
                                              addLeadingZeroIfNeeded(
                                                  eurQuantity.text)) *
                                          double.parse(addLeadingZeroIfNeeded(
                                              eurRate.text)))
                                      .toStringAsFixed(2);
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
                                            .toStringAsFixed(2);
                                  });
                                },
                                icon: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            cursorColor: Colors.white,
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneThousandQuantity.clear();
                                  oneThousandAmount.text =
                                      (1000 * 0).toStringAsFixed(2);
                                } else {
                                  oneThousandAmount.text = (1000 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              oneThousandQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiveHundredQuatity.clear();
                                  fiveHundredAmount.text =
                                      (500 * 0).toStringAsFixed(2);
                                } else {
                                  fiveHundredAmount.text = (500 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              fiveHundredQuatity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneHundredQuatity.clear();
                                  oneHundredAmount.text =
                                      (100 * 0).toStringAsFixed(2);
                                } else {
                                  oneHundredAmount.text = (100 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              oneHundredQuatity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiftyQuantity.clear();
                                  fiftyAmount.text =
                                      (50 * 0).toStringAsFixed(2);
                                } else {
                                  fiftyAmount.text = (50 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              fiftyQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twentyQuantity.clear();
                                  twentyAmount.text =
                                      (20 * 0).toStringAsFixed(2);
                                } else {
                                  twentyAmount.text = (20 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              twentyQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  tenQuantity.clear();
                                  tenAmount.text = (10 * 0).toStringAsFixed(2);
                                } else {
                                  tenAmount.text = (10 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              tenQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  fiveQuantity.clear();
                                  fiveAmount.text = (5 * 0).toStringAsFixed(2);
                                } else {
                                  fiveAmount.text = (5 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              fiveQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  twoQuantity.clear();
                                  twoAmount.text = (2 * 0).toStringAsFixed(2);
                                } else {
                                  twoAmount.text = (2 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              twoQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  oneQuantity.clear();
                                  oneAmount.text = (1 * 0).toStringAsFixed(2);
                                } else {
                                  oneAmount.text = (1 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              oneQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  dotFiftyQuantity.clear();
                                  dotFiftyAmount.text =
                                      (1 * 0).toStringAsFixed(2);
                                } else {
                                  dotFiftyAmount.text = (1 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              dotFiftyQuantity.text)))
                                      .toStringAsFixed(2);
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
                            onChanged: (value) {
                              setState(() {
                                if (value == '') {
                                  dotTwentyFiveQuantity.clear();
                                  dotTwentyFiveAmount.text =
                                      (1 * 0).toStringAsFixed(2);
                                } else {
                                  dotTwentyFiveAmount.text = (0.25 *
                                          double.parse(addLeadingZeroIfNeeded(
                                              dotTwentyFiveQuantity.text)))
                                      .toStringAsFixed(2);
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
                                        .toStringAsFixed(2);
                                  });
                                },
                                icon: const Icon(
                                  Icons.drag_handle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            cursorColor: Colors.white,
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
                            if (coupon.text.isEmpty) {
                              coupon.text = '0';
                            }
                            grandTotal.text = (double.parse(creditCard.text) +
                                    double.parse(fcCoin.text) +
                                    double.parse(others.text) +
                                    double.parse(foreignCurrenct.text) +
                                    double.parse(firstCollection.text) +
                                    double.parse(noteAndCoins.text))
                                .toStringAsFixed(2);
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    cursorColor: Colors.white,
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
                            netAmount.text = (double.parse((grandTotal.text)) -
                                    double.parse(refund.text))
                                .toStringAsFixed(2);
                          });
                        },
                        icon: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    cursorColor: Colors.white,
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
                          twentyXAmount.text = (double.parse(
                                      addLeadingZeroIfNeeded(
                                          twentyXQuantity.text)) *
                                  20)
                              .toStringAsFixed(2);
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
                          tenXAmount.text = (double.parse(
                                      addLeadingZeroIfNeeded(
                                          tenXQuantity.text)) *
                                  10)
                              .toStringAsFixed(2);
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
                          fiveXAmount.text = (double.parse(
                                      addLeadingZeroIfNeeded(
                                          fiveXQuantity.text)) *
                                  5)
                              .toStringAsFixed(2);
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
                            coupon.text = (double.parse(addLeadingZeroIfNeeded(
                                        twentyXAmount.text)) +
                                    double.parse(addLeadingZeroIfNeeded(
                                        tenXAmount.text)) +
                                    double.parse(addLeadingZeroIfNeeded(
                                        fiveXAmount.text)))
                                .toStringAsFixed(2);
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
                                .toStringAsFixed(2);
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
            const Padding(padding: EdgeInsets.only(top: 10)),
            widget.typeSelect == 'TK' || widget.typeSelect == 'OTH'
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
                                color:
                                    !locationTab ? Colors.black : Colors.white,
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
                              takeDeptCode = value.first.deptcode.toString();
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
