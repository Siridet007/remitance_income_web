import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:remittance_income_cm/model/model.dart';
import 'package:remittance_income_cm/pdf/previewpdf.dart';
import 'package:remittance_income_cm/pdf/printpage.dart';
import 'package:remittance_income_cm/screens/addnewpage.dart';
import 'package:remittance_income_cm/screens/previewpage.dart';

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

  final List<Map<String, String>> data = [
    {
      "incom_docno": "DOC001",
      "incom_date": "2024-12-01",
      "shopname": "Shop A",
      "TOTAL": "5000"
    },
    {
      "incom_docno": "DOC002",
      "incom_date": "2024-12-02",
      "shopname": "Shop B",
      "TOTAL": "7500"
    },
    {
      "incom_docno": "DOC003",
      "incom_date": "2024-12-03",
      "shopname": "Shop C",
      "TOTAL": "8200"
    },
    {
      "incom_docno": "DOC004",
      "incom_date": "2024-12-04",
      "shopname": "Shop D",
      "TOTAL": "6700"
    },
    {
      "incom_docno": "DOC005",
      "incom_date": "2024-12-05",
      "shopname": "Shop E",
      "TOTAL": "5400"
    },
    {
      "incom_docno": "DOC006",
      "incom_date": "2024-12-06",
      "shopname": "Shop F",
      "TOTAL": "4900"
    },
    {
      "incom_docno": "DOC007",
      "incom_date": "2024-12-07",
      "shopname": "Shop G",
      "TOTAL": "7100"
    },
    {
      "incom_docno": "DOC008",
      "incom_date": "2024-12-08",
      "shopname": "Shop H",
      "TOTAL": "4300"
    },
    {
      "incom_docno": "DOC009",
      "incom_date": "2024-12-09",
      "shopname": "Shop I",
      "TOTAL": "6200"
    },
    {
      "incom_docno": "DOC010",
      "incom_date": "2024-12-10",
      "shopname": "Shop J",
      "TOTAL": "6800"
    },
    {
      "incom_docno": "DOC011",
      "incom_date": "2024-12-11",
      "shopname": "Shop K",
      "TOTAL": "5200"
    },
    {
      "incom_docno": "DOC012",
      "incom_date": "2024-12-12",
      "shopname": "Shop L",
      "TOTAL": "7400"
    },
    {
      "incom_docno": "DOC013",
      "incom_date": "2024-12-13",
      "shopname": "Shop M",
      "TOTAL": "5800"
    },
    {
      "incom_docno": "DOC014",
      "incom_date": "2024-12-14",
      "shopname": "Shop N",
      "TOTAL": "6700"
    },
    {
      "incom_docno": "DOC015",
      "incom_date": "2024-12-15",
      "shopname": "Shop O",
      "TOTAL": "7300"
    },
    {
      "incom_docno": "DOC016",
      "incom_date": "2024-12-16",
      "shopname": "Shop P",
      "TOTAL": "4100"
    },
    {
      "incom_docno": "DOC017",
      "incom_date": "2024-12-17",
      "shopname": "Shop Q",
      "TOTAL": "4900"
    },
    {
      "incom_docno": "DOC018",
      "incom_date": "2024-12-18",
      "shopname": "Shop R",
      "TOTAL": "7600"
    },
    {
      "incom_docno": "DOC019",
      "incom_date": "2024-12-19",
      "shopname": "Shop S",
      "TOTAL": "5200"
    },
    {
      "incom_docno": "DOC020",
      "incom_date": "2024-12-20",
      "shopname": "Shop T",
      "TOTAL": "6400"
    },
    {
      "incom_docno": "DOC021",
      "incom_date": "2024-12-21",
      "shopname": "Shop U",
      "TOTAL": "7500"
    },
    {
      "incom_docno": "DOC022",
      "incom_date": "2024-12-22",
      "shopname": "Shop V",
      "TOTAL": "6000"
    },
    {
      "incom_docno": "DOC023",
      "incom_date": "2024-12-23",
      "shopname": "Shop W",
      "TOTAL": "7300"
    },
    {
      "incom_docno": "DOC024",
      "incom_date": "2024-12-24",
      "shopname": "Shop X",
      "TOTAL": "7800"
    },
    {
      "incom_docno": "DOC025",
      "incom_date": "2024-12-25",
      "shopname": "Shop Y",
      "TOTAL": "5100"
    },
    {
      "incom_docno": "DOC026",
      "incom_date": "2024-12-26",
      "shopname": "Shop Z",
      "TOTAL": "6400"
    },
    {
      "incom_docno": "DOC027",
      "incom_date": "2024-12-27",
      "shopname": "Shop AA",
      "TOTAL": "7000"
    },
    {
      "incom_docno": "DOC028",
      "incom_date": "2024-12-28",
      "shopname": "Shop AB",
      "TOTAL": "5600"
    },
    {
      "incom_docno": "DOC029",
      "incom_date": "2024-12-29",
      "shopname": "Shop AC",
      "TOTAL": "7700"
    },
    {
      "incom_docno": "DOC030",
      "incom_date": "2024-12-30",
      "shopname": "Shop AD",
      "TOTAL": "6800"
    }
  ];

  TextEditingController dateStart = TextEditingController();
  String takeDateStart = '';
  TextEditingController dateEnd = TextEditingController();
  String takeDateEnd = '';
  String takeDocno = '';
  String takeFlag = '';
  List<GetShop>? shopList = [];
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

  Future<dynamic> updateDialog(flag, actionText) {
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
                              updateFlag(flag, takeDocno).then((value) {
                                Navigator.of(context).pop();
                                loadData = false;
                                getReport(typeSelect, flagTab, takeDateStart)
                                    .then((value) {
                                  setState(() {
                                    dataList = value;
                                    takeDocno =
                                        dataList!.first.incomDocno.toString();
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                .map((item) => ListTile(
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
                    ))
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
                                    } else if (value == 3) {
                                      flagTab = 'C';
                                    }
                                    getReport(
                                            typeSelect, flagTab, takeDateStart)
                                        .then((value) {
                                      setState(() {
                                        dataList = value;

                                        takeDocno = dataList!.first.incomDocno
                                            .toString();
                                        print(takeDocno == '');
                                        loadData = true;
                                      });
                                    });
                                  });
                                },
                                tabs: const [
                                  Tab(text: "New"),
                                  Tab(text: "Completed"),
                                  //Tab(text: "Approved"),
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
                              //approveWidget(context),
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

  Row buttonWidget(BuildContext context) {
    return Row(
      children: [
        flagTab == 'Y' && takeDocno != ''
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewPDFPage(
                        dataList: dataList!,
                        date: dateStart.text,
                      ),
                    ),
                  );
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
            : Container(),
        const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewPage(
                  typeSelect: typeSelect,
                  typeName: typeName,
                  date: DateTime.parse(takeDateStart),
                ),
              ),
            );
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
          onTap: flagTab == 'A' || flagTab == 'C' || flagTab == 'Y'
              ? null
              : () {
                  setState(() {
                    updateDialog('Y', 'Complete');
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'A' || flagTab == 'C' || flagTab == 'Y'
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
        /*InkWell(
          onTap: flagTab == 'N' || flagTab == 'C' || flagTab == 'A'
              ? null
              : () {
                  setState(() {
                    updateDialog('A', 'Approve');
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'N' || flagTab == 'C' || flagTab == 'A'
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
        const Padding(padding: EdgeInsets.only(left: 20)),*/
        InkWell(
          onTap: flagTab == 'A' || flagTab == 'C'
              ? null
              : () {
                  setState(() {
                    updateDialog('C', 'Cancel');
                  });
                },
          child: Container(
            width: 160,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: flagTab == 'A' || flagTab == 'C'
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
                dateStart.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                takeDateStart = DateFormat('yyyy-MM-dd').format(pickedDate);
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
                  loadData = true;
                });
              });
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
                                print(takeDocno);
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
                                    : () {
                                        selectedRowIndexComplete = index;
                                        showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
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
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
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
                                    : () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => PreviewPage(
                                            list: [row],
                                            typeSelect: typeSelect,
                                            flagTab: flagTab,
                                            date: DateTime.parse(takeDateStart),
                                          ),
                                        );
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
                                print(takeDocno);
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
                                    : () {
                                        setState(() {
                                          selectedRowIndexNew = index;
                                          showDialog(
                                            context: context,
                                            builder: (context) => PreviewPage(
                                              list: [row],
                                              typeSelect: typeSelect,
                                              flagTab: flagTab,
                                              date:
                                                  DateTime.parse(takeDateStart),
                                            ),
                                          );
                                        });
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
