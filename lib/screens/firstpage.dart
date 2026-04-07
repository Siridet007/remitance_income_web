// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:remittance_income_cm/model/model.dart';
import 'package:remittance_income_cm/pdf/previewpdf.dart';
import 'package:remittance_income_cm/screens/addnewpage.dart';
import 'package:remittance_income_cm/screens/previewpage.dart';

import '../pdf/new/printTotal.dart';
import '../pdf/previewType.dart';
import '../pdf/previewdaily.dart';
import 'package:pdf/widgets.dart' as pw;

class FirstPage extends StatefulWidget {
  final DateTime date;
  const FirstPage({super.key, required this.date});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  final _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag_rounded),
      label: 'Souvinir',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.food_bank_outlined),
      activeIcon: Icon(Icons.food_bank_rounded),
      label: 'F & B',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_outlined),
      activeIcon: Icon(Icons.restaurant_menu),
      label: 'Restaurant',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.games_outlined),
      activeIcon: Icon(Icons.games),
      label: 'Game',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.tram_outlined),
      activeIcon: Icon(Icons.tram),
      label: 'Tram',
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.ticket),
      activeIcon: Icon(CupertinoIcons.ticket_fill),
      label: 'Ticket',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.pending_outlined),
      activeIcon: Icon(Icons.pending_rounded),
      label: 'Others',
    ),
  ];
  int _selectedIndex = 0;
  String typeSelect = "SOU";
  String typeName = 'Souvinir';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<GetData>? dataList = [];
  late TabController _tabController;
  String flagTab = "N";
  bool loadData = false;
  int selectedRowIndexNew = 0;
  int selectedRowIndexComplete = 0;
  int selectedRowIndexApprove = 0;

  TextEditingController dateStart = TextEditingController();
  String takeDateStart = '';
  TextEditingController dateEnd = TextEditingController();
  String takeDateEnd = '';
  String takeDocno = '';
  String takeFlag = '';
  List<GetShop>? shopList = [];
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  List<GetData>? totalList = [];
  List<TotalData>? sumList = [];
  List<TotalType>? typeList = [];
  double creditTot = 0;
  double eshop = 0;
  double voucherTot = 0;
  double chequeTot = 0;
  double payinTot = 0;
  double fccoinTot = 0;
  double uSDQty = 0;
  double uSDRate = 0;
  double sGDQty = 0;
  double sGDRate = 0;
  double tWDQty = 0;
  double tWDRate = 0;
  double jPYQty = 0;
  double jPYRate = 0;
  double hKDQty = 0;
  double hKDRate = 0;
  double gBPQty = 0;
  double gBPRate = 0;
  double cNYQty = 0;
  double cNYRate = 0;
  double aUDQty = 0;
  double aUDRate = 0;
  double eURQty = 0;
  double eURRate = 0;
  double tHB1000Qty = 0;
  double tHB500Qty = 0;
  double tHB100Qty = 0;
  double tHB50Qty = 0;
  double tHB20Qty = 0;
  double tHB10Qty = 0;
  double tHB5Qty = 0;
  double tHB2Qty = 0;
  double tHB1Qty = 0;
  double tHB050Qty = 0;
  double tHB025Qty = 0;
  double tOTAL = 0;

  double uSDQtyType = 0;
  double uSDRateType = 0;
  double sGDQtyType = 0;
  double sGDRateType = 0;
  double tWDQtyType = 0;
  double tWDRateType = 0;
  double jPYQtyType = 0;
  double jPYRateType = 0;
  double hKDQtyType = 0;
  double hKDRateType = 0;
  double gBPQtyType = 0;
  double gBPRateType = 0;
  double cNYQtyType = 0;
  double cNYRateType = 0;
  double aUDQtyType = 0;
  double aUDRateType = 0;
  double eURQtyType = 0;
  double eURRateType = 0;
  double tHB1000QtyType = 0;
  double tHB500QtyType = 0;
  double tHB100QtyType = 0;
  double tHB50QtyType = 0;
  double tHB20QtyType = 0;
  double tHB10QtyType = 0;
  double tHB5QtyType = 0;
  double tHB2QtyType = 0;
  double tHB1QtyType = 0;
  double tHB050QtyType = 0;
  double tHB025QtyType = 0;
  double thTot = 0;
  double foreignTot = 0;
  double sumForeingCash = 0;
  double sumTHCash = 0;

  String? selectedPrint;

  List<String> printList = ['Total', 'By Shop'];
  String shopName = '';

  String convertToDouble(num) {
    double number = double.parse(num.toString());
    if (number == 0.0) {
      return '';
    }
    String formatedNumber = NumberFormat('#,##0.00').format(number);
    return formatedNumber;
  }

  Future<List<GetData>?> getReport(type, flag, date) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "get_report",
        "type": type,
        "flag": flag,
        "incom_date": date,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetData>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetData.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<GetData>?> getReportTotal(date) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "get_report_total",
        "incom_date": date,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetData>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetData.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<GetData>?> updateFlag(flag, doc) async {
    FormData formData = FormData.fromMap(
      {
        "mode": "UPDATE_FLAG",
        "flag": flag,
        "incom_docno": doc,
      },
    );
    String domain =
        "http://172.2.100.14/application/query_income_report_cm/fluttercon.php";
    try {
      Response response = await Dio().post(domain, data: formData);
      List<GetData>? result;
      if (response.data != null && response.data.toString().trim().isNotEmpty) {
        result = GetData.fromJsonList(response.data);
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<GetShop>?> getShop() async {
    FormData formData = FormData.fromMap(
      {
        "mode": "get_shop",
        "type": 'SOU',
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

  Future<dynamic> updateDialog(flag, actionText, shopName) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 550,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.pink.shade100,
                offset: const Offset(10, 10),
              ),
            ],
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
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    'ต้องการ $actionText ใช่หรือไม่',
                    style: const TextStyle(
                      fontSize: 25,
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
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    'ร้าน $shopName',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Color.fromRGBO(228, 60, 137, 1),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'pg',
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 60)),
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
                        updateFlag(flag, takeDocno).then((value) {
                          Navigator.of(context).pop();
                          loadData = false;
                          getReport(typeSelect, flagTab, takeDateStart)
                              .then((value) {
                            setState(() {
                              dataList = value;
                              takeDocno = dataList!.first.incomDocno.toString();
                              loadData = true;
                            });
                          });
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
    );
  }

  Future<dynamic> userDialog(flag, actionText) {
    return showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 500,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  color: Colors.pink.shade100,
                  offset: const Offset(10, 10),
                ),
              ],
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
                      'Confirm',
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
                      'ใส่ชื่อรหัสผู้ Approve',
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
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(228, 60, 137, 1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'pg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: userName,
                        style: const TextStyle(
                          fontFamily: 'pg',
                          fontSize: 20,
                        ),
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(228, 60, 137, 1),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'pg',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: password,
                        style: const TextStyle(
                          fontFamily: 'pg',
                          fontSize: 20,
                        ),
                        obscureText: true,
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
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
                          if (userName.text.isNotEmpty) {
                            checkApprove(userName.text, password.text, flag);
                          }
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
      ),
    );
  }

  Future<void> checkApprove(userName, passWord, flag) async {
    FormData formData = FormData.fromMap({
      "param": "auth",
      "user": userName,
      "password": passWord,
      "system_id": "0019",
    });
    String urlAPI = "http://172.2.100.14/usercontrol/datamodule/mainlib.php";
    try {
      Response response = await Dio().post(urlAPI, data: formData);
      if (response.data['authdetail'].first['Active'] == 'Y') {
        updateFlag(flag, takeDocno).then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          loadData = false;
          getReport(typeSelect, flagTab, takeDateStart).then((value) {
            setState(() {
              dataList = value;
              takeDocno = dataList!.first.incomDocno.toString();
              loadData = true;
            });
          });
        });
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        errorDialog();
      }
    } catch (e) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      errorDialog();
    }
  }

  Future<dynamic> errorDialog() {
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
                  color: Colors.purple[100],
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
                          'ผู้ใช้นี้ไม่สามารถ Approve ได้',
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
                          onPressed: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(228, 60, 137, 1),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'เข้าใจแล้ว',
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
    _tabController = TabController(length: 4, vsync: this);
    getShop().then((value) {
      setState(() {
        shopList = value;
        takeDateStart = DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(shopList!.first.shopDate.toString()));
        String date = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(shopList!.first.shopDate.toString()));
        dateStart.text = date;
        getReport(typeSelect, flagTab, takeDateStart).then((value) {
          setState(() {
            dataList = value;
            takeDocno = dataList!.first.incomDocno.toString();
            shopName = dataList!.first.shopname!;
            loadData = true;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 1800;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          elevation: 50,
          backgroundColor: Colors.pink[50],
          child: ListView(
            children: _navBarItems
                .map(
                  (item) => ListTile(
                    onTap: () {},
                    title: Row(
                      children: [
                        item.icon,
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          item.label.toString(),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isSmallScreen
                ? IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  )
                : Expanded(
                    flex: 1,
                    child: NavigationRail(
                      backgroundColor: Colors.pink[50],
                      onDestinationSelected: (value) {
                        setState(() {
                          _selectedIndex = value;
                          loadData = false;
                          if (_selectedIndex == 0) {
                            typeSelect = "SOU";
                            typeName = "Souvinir";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 1) {
                            typeSelect = "FB";
                            typeName = "F & B";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 2) {
                            typeSelect = "RES";
                            typeName = "Restaurant";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 3) {
                            typeSelect = "GM";
                            typeName = "Game";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 4) {
                            typeSelect = "TRM";
                            typeName = "Tram";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 5) {
                            typeSelect = "TK";
                            typeName = "Ticket";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          } else if (_selectedIndex == 6) {
                            typeSelect = "OTH";
                            typeName = "Others";
                            getReport(typeSelect, flagTab, takeDateStart)
                                .then((value) {
                              setState(() {
                                dataList = value;
                                takeDocno =
                                    dataList!.first.incomDocno.toString();
                                shopName = dataList!.first.shopname!;
                                loadData = true;
                              });
                            });
                          }
                        });
                      },
                      extended: true,
                      elevation: 50,
                      destinations: _navBarItems
                          .map(
                            (e) => NavigationRailDestination(
                              icon: e.icon,
                              label: Text(
                                e.label.toString(),
                                style: const TextStyle(fontSize: 25),
                              ),
                              selectedIcon: e.activeIcon,
                            ),
                          )
                          .toList(),
                      selectedIndex: _selectedIndex,
                    ),
                  ),
            isSmallScreen
                ? Container()
                : const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            dateSelect(context),
                            buttonWidget(context),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 20)),
                            Container(
                              width: 650,
                              height: kToolbarHeight - 8.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.pink,
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                labelStyle: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'pg',
                                ),
                                onTap: (value) {
                                  setState(() {
                                    loadData = false;
                                    if (value == 0) {
                                      flagTab = "N";
                                    } else if (value == 1) {
                                      flagTab = 'Y';
                                    } else if (value == 2) {
                                      flagTab = 'A';
                                      summaryMethod();
                                    } else if (value == 3) {
                                      flagTab = 'C';
                                    }
                                    getReport(
                                            typeSelect, flagTab, takeDateStart)
                                        .then((value) {
                                      setState(() {
                                        dataList = value;
                                        takeDocno = dataList!.first.incomDocno!;
                                        shopName = dataList!.first.shopname!;
                                        loadData = true;
                                      });
                                    });
                                  });
                                },
                                tabs: const [
                                  Tab(text: "New"),
                                  Tab(text: "Completed"),
                                  Tab(text: "Approved"),
                                  Tab(text: "Canceled"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: !loadData
                        ? LoadingAnimationWidget.bouncingBall(
                            color: Colors.pink, size: 300)
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              newTabWidget(context),
                              completeWidget(context),
                              approveWidget(context),
                              cancelWidget(context),
                            ],
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

  void summaryMethod() {
    getReportTotal(takeDateStart).then((value) {
      setState(() {
        totalList = value;
        sumList!.clear();
        typeList!.clear();
        creditTot = 0;
        eshop = 0;
        voucherTot = 0;
        chequeTot = 0;
        payinTot = 0;
        fccoinTot = 0;
        uSDQty = 0;
        uSDRate = 0;
        sGDQty = 0;
        sGDRate = 0;
        tWDQty = 0;
        tWDRate = 0;
        jPYQty = 0;
        jPYRate = 0;
        hKDQty = 0;
        hKDRate = 0;
        gBPQty = 0;
        gBPRate = 0;
        cNYQty = 0;
        cNYRate = 0;
        aUDQty = 0;
        aUDRate = 0;
        eURQty = 0;
        eURRate = 0;
        tHB1000Qty = 0;
        tHB500Qty = 0;
        tHB100Qty = 0;
        tHB50Qty = 0;
        tHB20Qty = 0;
        tHB10Qty = 0;
        tHB5Qty = 0;
        tHB2Qty = 0;
        tHB1Qty = 0;
        tHB050Qty = 0;
        tHB025Qty = 0;
        tOTAL = 0;

        uSDQtyType = 0;
        uSDRateType = 0;
        sGDQtyType = 0;
        sGDRateType = 0;
        tWDQtyType = 0;
        tWDRateType = 0;
        jPYQtyType = 0;
        jPYRateType = 0;
        hKDQtyType = 0;
        hKDRateType = 0;
        gBPQtyType = 0;
        gBPRateType = 0;
        cNYQtyType = 0;
        cNYRateType = 0;
        aUDQtyType = 0;
        aUDRateType = 0;
        eURQtyType = 0;
        eURRateType = 0;
        tHB1000QtyType = 0;
        tHB500QtyType = 0;
        tHB100QtyType = 0;
        tHB50QtyType = 0;
        tHB20QtyType = 0;
        tHB10QtyType = 0;
        tHB5QtyType = 0;
        tHB2QtyType = 0;
        tHB1QtyType = 0;
        tHB050QtyType = 0;
        tHB025QtyType = 0;
        thTot = 0;
        foreignTot = 0;
        sumForeingCash = 0;
        sumTHCash = 0;

        if (totalList!.first.idIncom == '') {
        } else {
          for (final total in totalList!) {
            creditTot += double.parse(total.creditTot.toString());
            eshop += double.parse(total.eshopTot.toString());
            voucherTot += double.parse(total.voucherTot.toString());
            chequeTot += double.parse(total.chequeTot.toString());
            payinTot += double.parse(total.payinTot.toString());
            fccoinTot += double.parse(total.fccoinTot.toString());
            uSDQty += double.parse(total.uSDQty.toString());

            sGDQty += double.parse(total.sGDQty.toString());

            tWDQty += double.parse(total.tWDQty.toString());

            jPYQty += double.parse(total.jPYQty.toString());

            hKDQty += double.parse(total.hKDQty.toString());

            gBPQty += double.parse(total.gBPQty.toString());

            cNYQty += double.parse(total.cNYQty.toString());

            aUDQty += double.parse(total.aUDQty.toString());

            eURQty += double.parse(total.eURQty.toString());

            tHB1000Qty += double.parse(total.tHB1000Qty.toString());
            tHB500Qty += double.parse(total.tHB500Qty.toString());
            tHB100Qty += double.parse(total.tHB100Qty.toString());
            tHB50Qty += double.parse(total.tHB50Qty.toString());
            tHB20Qty += double.parse(total.tHB20Qty.toString());
            tHB10Qty += double.parse(total.tHB10Qty.toString());
            tHB5Qty += double.parse(total.tHB5Qty.toString());
            tHB2Qty += double.parse(total.tHB2Qty.toString());
            tHB1Qty += double.parse(total.tHB1Qty.toString());
            tHB050Qty += double.parse(total.tHB050Qty.toString());
            tHB025Qty += double.parse(total.tHB025Qty.toString());
            tOTAL += double.parse(total.tOTAL.toString());

            uSDQtyType = double.parse(total.uSDQty!);
            uSDRateType = double.parse(total.uSDRate!);
            sGDQtyType = double.parse(total.sGDQty!);
            sGDRateType = double.parse(total.sGDRate!);
            tWDQtyType = double.parse(total.tWDQty!);
            tWDRateType = double.parse(total.tWDRate!);
            jPYQtyType = double.parse(total.jPYQty!);
            jPYRateType = double.parse(total.jPYRate!);
            hKDQtyType = double.parse(total.hKDQty!);
            hKDRateType = double.parse(total.hKDRate!);
            gBPQtyType = double.parse(total.gBPQty!);
            gBPRateType = double.parse(total.gBPRate!);
            cNYQtyType = double.parse(total.cNYQty!);
            cNYRateType = double.parse(total.cNYRate!);
            aUDQtyType = double.parse(total.aUDQty!);
            aUDRateType = double.parse(total.aUDRate!);
            eURQtyType = double.parse(total.eURQty!);
            eURRateType = double.parse(total.eURRate!);
            tHB1000QtyType = double.parse(total.tHB1000Qty!);
            tHB500QtyType = double.parse(total.tHB500Qty!);
            tHB100QtyType = double.parse(total.tHB100Qty!);
            tHB50QtyType = double.parse(total.tHB50Qty!);
            tHB20QtyType = double.parse(total.tHB20Qty!);
            tHB10QtyType = double.parse(total.tHB10Qty!);
            tHB5QtyType = double.parse(total.tHB5Qty!);
            tHB2QtyType = double.parse(total.tHB2Qty!);
            tHB1QtyType = double.parse(total.tHB1Qty!);
            tHB050QtyType = double.parse(total.tHB050Qty!);
            tHB025QtyType = double.parse(total.tHB025Qty!);

            foreignTot = ((uSDQtyType * uSDRateType) +
                (sGDQtyType * sGDRateType) +
                (tWDQtyType * tWDRateType) +
                (jPYQtyType * jPYRateType) +
                (hKDQtyType * hKDRateType) +
                (gBPQtyType * gBPRateType) +
                (cNYQtyType * cNYRateType) +
                (aUDQtyType * aUDRateType) +
                (eURQtyType * eURRateType));
            thTot = (1000 * tHB1000QtyType) +
                (500 * tHB500QtyType) +
                (100 * tHB100QtyType) +
                (50 * tHB50QtyType) +
                (20 * tHB20QtyType) +
                (10 * tHB10QtyType) +
                (5 * tHB5QtyType) +
                (2 * tHB2QtyType) +
                (1 * tHB1QtyType) +
                (0.5 * tHB050QtyType) +
                (0.25 * tHB025QtyType);

            sumForeingCash += foreignTot;
            sumTHCash += thTot;

            typeList!.add(
              TotalType(
                shopName: total.shopcode,
                thTot: thTot.toString(),
                foreignTot: foreignTot.toString(),
                creditTot: total.creditTot,
                eShop: total.eshopTot,
                voucherTot: total.voucherTot,
                chequeTot: total.chequeTot,
                payinTot: total.payinTot,
              ),
            );
          }
          uSDRate = double.parse(totalList!.first.uSDRate.toString());
          sGDRate = double.parse(totalList!.first.sGDRate.toString());
          tWDRate = double.parse(totalList!.first.tWDRate.toString());
          jPYRate = double.parse(totalList!.first.jPYRate.toString());
          hKDRate = double.parse(totalList!.first.hKDRate.toString());
          gBPRate = double.parse(totalList!.first.gBPRate.toString());
          cNYRate = double.parse(totalList!.first.cNYRate.toString());
          aUDRate = double.parse(totalList!.first.aUDRate.toString());
          eURRate = double.parse(totalList!.first.eURRate.toString());

          print(fccoinTot);
          sumList!.add(
            TotalData(
              creditTot: creditTot.toString(),
              eShop: eshop.toString(),
              voucherTot: voucherTot.toString(),
              chequeTot: chequeTot.toString(),
              payinTot: payinTot.toString(),
              uSDQty: uSDQty.toString(),
              uSDRate: uSDRate.toString(),
              sGDQty: sGDQty.toString(),
              sGDRate: sGDRate.toString(),
              tWDQty: tWDQty.toString(),
              tWDRate: tWDRate.toString(),
              jPYQty: jPYQty.toString(),
              jPYRate: jPYRate.toString(),
              hKDQty: hKDQty.toString(),
              hKDRate: hKDRate.toString(),
              gBPQty: gBPQty.toString(),
              gBPRate: gBPRate.toString(),
              cNYQty: cNYQty.toString(),
              cNYRate: cNYRate.toString(),
              aUDQty: aUDQty.toString(),
              aUDRate: aUDRate.toString(),
              eURQty: eURQty.toString(),
              eURRate: eURRate.toString(),
              tHB1000Qty: tHB1000Qty.toString(),
              tHB500Qty: tHB500Qty.toString(),
              tHB100Qty: tHB100Qty.toString(),
              tHB50Qty: tHB50Qty.toString(),
              tHB20Qty: tHB20Qty.toString(),
              tHB10Qty: tHB10Qty.toString(),
              tHB5Qty: tHB5Qty.toString(),
              tHB2Qty: tHB2Qty.toString(),
              tHB1Qty: tHB1Qty.toString(),
              tHB050Qty: tHB050Qty.toString(),
              tHB025Qty: tHB025Qty.toString(),
              tOTAL: tOTAL.toString(),
              fccoinTot: fccoinTot.toString(),
            ),
          );
          print(jsonEncode(sumList));
        }
      });
    });
  }

  Row buttonWidget(BuildContext context) {
    return Row(
      children: [
        flagTab == 'A' && takeDocno != ''
            ? InkWell(
                onTap: () async {
                  //printTotalMethod();
                  loadDialog();
                  await PrintTotal()
                      .printTotalMethod(
                          sumList, sumTHCash, sumForeingCash, takeDateStart)
                      .then((value) {
                    Navigator.of(context).pop();
                  });

                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewDialy(
                        dataList: sumList!,
                        date: takeDateStart,
                        foreCash: sumForeingCash.toString(),
                        thbCash: sumTHCash.toString(),
                      ),
                    ),
                  ); */
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewPDFPage(
                        dataList: dataList!,
                        date: dateStart.text,
                      ),
                    ),
                  ); */
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewDialy(
                        dataList: sumList!,
                        date: takeDateStart,
                      ),
                    ),
                  ); */
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewType(
                        typeList: typeList!,
                        date: takeDateStart,
                        sumForeingCash: sumForeingCash.toString(),
                        sumTHCash: sumTHCash.toString(),
                        sumCredit: creditTot.toString(),
                        sumEshop: eshop.toString(),
                        sumPayin: payinTot.toString(),
                        sumVoucher: voucherTot.toString(),
                        sumCheque: chequeTot.toString(),
                        total: tOTAL.toString(),
                      ),
                    ),
                  ); */
                },
                child: Container(
                  width: 160,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue[500],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.print,
                        color: Colors.white,
                      ),
                      Text(
                        'Print',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            :
            /* Container(
                width: 160,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue[500],
                ),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPrint,
                    hint: const Text(
                      'Print',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.blue[500],
                    items: printList.map((String p) {
                      return DropdownMenuItem<String>(
                        value: p,
                        child: Text(
                          p,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Total') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewDialy(
                              dataList: sumList!,
                              date: takeDateStart,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviewType(
                              typeList: typeList!,
                              date: takeDateStart,
                              sumForeingCash: sumForeingCash.toString(),
                              sumTHCash: sumTHCash.toString(),
                              sumCredit: creditTot.toString(),
                              sumEshop: eshop.toString(),
                              sumPayin: payinTot.toString(),
                              sumVoucher: voucherTot.toString(),
                              sumCheque: chequeTot.toString(),
                              total: tOTAL.toString(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            :  */
            Container(),
        const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        InkWell(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewPage(
                  typeSelect: typeSelect,
                  typeName: typeName,
                  date: DateTime.parse(takeDateStart),
                ),
              ),
            );
            if (result != null) {
              setState(() {
                loadData = false;
                print('fdfdff');
                getReport(typeSelect, flagTab, takeDateStart).then((value) {
                  setState(() {
                    dataList = value;
                    takeDocno = dataList!.first.incomDocno.toString();
                    loadData = true;
                  });
                });
              });
            }
          },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.green[500],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'New',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        InkWell(
          onTap: flagTab == 'A' ||
                  flagTab == 'C' ||
                  flagTab == 'Y' ||
                  takeDocno == ''
              ? null
              : () {
                  setState(() {
                    updateDialog('Y', 'Complete', shopName);
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'A' ||
                      flagTab == 'C' ||
                      flagTab == 'Y' ||
                      takeDocno == ''
                  ? Colors.grey
                  : Colors.blue[200],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.check),
                Text(
                  'Complete',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 20)),
        InkWell(
          onTap: flagTab == 'N' ||
                  flagTab == 'C' ||
                  flagTab == 'A' ||
                  takeDocno == ''
              ? null
              : () {
                  setState(() {
                    updateDialog('A', 'Approve', shopName);
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'N' ||
                      flagTab == 'C' ||
                      flagTab == 'A' ||
                      takeDocno == ''
                  ? Colors.grey
                  : Colors.purple[200],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.thumb_up_off_alt_outlined),
                Text(
                  'Approve',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 20)),
        InkWell(
          onTap: flagTab == 'A' || flagTab == 'C' || takeDocno == ''
              ? null
              : () {
                  setState(() {
                    updateDialog('C', 'Cancel', shopName);
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'A' || flagTab == 'C' || takeDocno == ''
                  ? Colors.grey
                  : Colors.red[200],
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.cancel),
                Text(
                  'Cancel',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 20)),
      ],
    );
  }

  Row dateSelect(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        const Text(
          'เลือกวันที่',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 200, //300
          height: 60,
          padding: const EdgeInsets.only(
            left: 10,
            bottom: 10,
          ),
          alignment: Alignment.topCenter,

          child: TextField(
            controller: dateStart,
            style: const TextStyle(
              fontFamily: 'pg',
              fontSize: 20,
            ),
            //editing controller of this TextField
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              icon: const Icon(Icons.calendar_today),
              hoverColor: Colors.lightBlue[50], //icon of text field
              labelText: dateStart.text.isEmpty ? "Choose Date" : '',
              labelStyle: const TextStyle(
                fontFamily: 'pg',
                fontSize: 20,
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.parse(takeDateStart),
                firstDate: DateTime(1800),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  dateStart.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                  takeDateStart = DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              } else {}
            },
          ),
        ),
        /*const Padding(
                                padding: EdgeInsets.only(left: 20),
                              ),
                              const Text(
                                'ถึงวันที่',
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                width: 200, //300
                                height: 60,
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),
                                alignment: Alignment.topCenter,

                                child: TextField(
                                  controller: dateEnd,
                                  style: const TextStyle(
                                    fontFamily: 'pg',
                                    fontSize: 20,
                                  ),
                                  //editing controller of this TextField
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    icon: const Icon(Icons.calendar_today),
                                    hoverColor: Colors
                                        .lightBlue[50], //icon of text field
                                    labelText: dateEnd.text.isEmpty
                                        ? "Choose Date"
                                        : '',
                                    labelStyle: const TextStyle(
                                      fontFamily: 'pg',
                                      fontSize: 20,
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      dateEnd.text = DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                      takeDateEnd =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                    } else {}
                                  },
                                ),
                              ),*/
        const Padding(
          padding: EdgeInsets.only(left: 30),
        ),
        InkWell(
          onTap: () {
            setState(() {
              loadData = false;
              getReport(typeSelect, flagTab, takeDateStart).then((value) {
                setState(() {
                  dataList = value;
                  takeDocno = dataList!.first.incomDocno.toString();
                  shopName = dataList!.first.shopname!;
                  loadData = true;
                });
              });
              if (flagTab == 'A') {
                summaryMethod();
              }
            });
          },
          child: Container(
            width: 140,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromRGBO(228, 60, 137, 1),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row completeWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              elevation: 50,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(228, 60, 137, 1),
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'pg',
                ),
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Document No',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Preview',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
                rows: List.generate(
                  dataList!.length,
                  (index) {
                    final row = dataList![index];
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (states) => selectedRowIndexComplete == index
                            ? Colors.pink[100]
                            : null,
                      ),
                      onSelectChanged: dataList!.first.incomDocno!.isEmpty
                          ? null
                          : (selected) {
                              setState(() {
                                selectedRowIndexComplete =
                                    (selected == true ? index : null)!;
                                takeDocno = row.incomDocno.toString();
                                shopName = row.shopname!;
                              });
                            },
                      selected: false,
                      cells: [
                        DataCell(
                          Text(
                            dataList!.first.incomDocno!.isEmpty
                                ? ''
                                : '${index + 1}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDate == ''
                                ? ""
                                : DateFormat("dd/MM/yyyy")
                                    .format(DateTime.parse(
                                        row.incomDate.toString()))
                                    .toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDocno ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.shopname ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.tOTAL ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.preview),
                                onPressed: row.incomDocno!.isEmpty ||
                                        dataList!.first.incomDocno!.isEmpty
                                    ? null
                                    : () async {
                                        selectedRowIndexComplete = index;
                                        final result = await showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            loadData = false;
                                            getReport(typeSelect, flagTab,
                                                    takeDateStart)
                                                .then((value) {
                                              setState(() {
                                                dataList = value;
                                                takeDocno = dataList!
                                                    .first.incomDocno
                                                    .toString();
                                                loadData = true;
                                              });
                                            });
                                          });
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row cancelWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              elevation: 50,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(228, 60, 137, 1),
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'pg',
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Document No',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Preview',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
                rows: List.generate(
                  dataList!.length,
                  (index) {
                    final row = dataList![index];
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            dataList!.first.incomDocno!.isEmpty
                                ? ''
                                : '${index + 1}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDate == ''
                                ? ""
                                : DateFormat("dd/MM/yyyy")
                                    .format(DateTime.parse(
                                        row.incomDate.toString()))
                                    .toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDocno ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.shopname ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.tOTAL ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.preview),
                                onPressed: row.incomDocno!.isEmpty ||
                                        dataList!.first.incomDocno!.isEmpty
                                    ? null
                                    : () async {
                                        final result = await showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            loadData = false;
                                            getReport(typeSelect, flagTab,
                                                    takeDateStart)
                                                .then((value) {
                                              setState(() {
                                                dataList = value;
                                                takeDocno = dataList!
                                                    .first.incomDocno
                                                    .toString();
                                                loadData = true;
                                              });
                                            });
                                          });
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row approveWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              elevation: 50,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(228, 60, 137, 1),
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'pg',
                ),
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Document No',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Preview',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
                rows: List.generate(
                  dataList!.length,
                  (index) {
                    final row = dataList![index];
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (states) => selectedRowIndexApprove == index
                            ? Colors.pink[100]
                            : null,
                      ),
                      onSelectChanged: dataList!.first.incomDocno!.isEmpty
                          ? null
                          : (selected) {
                              setState(() {
                                selectedRowIndexApprove =
                                    (selected == true ? index : null)!;
                                takeDocno = row.incomDocno.toString();
                                shopName = row.shopname!;
                              });
                            },
                      cells: [
                        DataCell(
                          Text(
                            dataList!.first.incomDocno!.isEmpty
                                ? ""
                                : '${index + 1}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDate == ''
                                ? ""
                                : DateFormat("dd/MM/yyyy")
                                    .format(DateTime.parse(
                                        row.incomDate.toString()))
                                    .toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDocno ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.shopname ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.tOTAL ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.preview),
                                onPressed: row.incomDocno!.isEmpty ||
                                        dataList!.first.incomDocno!.isEmpty
                                    ? null
                                    : () async {
                                        setState(() {
                                          selectedRowIndexApprove = index;
                                        });
                                        final result = await showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            loadData = false;
                                            getReport(typeSelect, flagTab,
                                                    takeDateStart)
                                                .then((value) {
                                              setState(() {
                                                dataList = value;
                                                takeDocno = dataList!
                                                    .first.incomDocno
                                                    .toString();
                                                loadData = true;
                                              });
                                            });
                                          });
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row newTabWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              elevation: 50,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(228, 60, 137, 1),
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'pg',
                ),
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Document No',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Edit',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
                rows: List.generate(
                  dataList!.length,
                  (index) {
                    final row = dataList![index];
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (states) => selectedRowIndexNew == index
                            ? Colors.pink[100]
                            : null,
                      ),
                      onSelectChanged: dataList!.first.incomDocno!.isEmpty
                          ? null
                          : (selected) {
                              setState(() {
                                selectedRowIndexNew =
                                    (selected == true ? index : null)!;
                                takeDocno = row.incomDocno.toString();
                                shopName = row.shopname!;
                              });
                            },
                      selected: false,
                      cells: [
                        DataCell(
                          Text(
                            dataList!.first.incomDocno!.isEmpty
                                ? ''
                                : '${index + 1}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDate == ''
                                ? ""
                                : DateFormat("dd/MM/yyyy")
                                    .format(DateTime.parse(
                                        row.incomDate.toString()))
                                    .toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.incomDocno ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.shopname ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Text(
                            row.tOTAL ?? "",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: row.incomDocno!.isEmpty
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                                onPressed: row.incomDocno!.isEmpty ||
                                        dataList!.first.incomDocno!.isEmpty
                                    ? null
                                    : () async {
                                        setState(() {
                                          selectedRowIndexNew = index;
                                        });
                                        final result = await showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
                                        if (result != null) {
                                          setState(() {
                                            loadData = false;
                                            getReport(typeSelect, flagTab,
                                                    takeDateStart)
                                                .then((value) {
                                              setState(() {
                                                dataList = value;
                                                takeDocno = dataList!
                                                    .first.incomDocno
                                                    .toString();
                                                loadData = true;
                                              });
                                            });
                                          });
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
