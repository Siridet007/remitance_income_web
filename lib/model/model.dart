class GetPerson {
  String? code;
  String? name;
  String? deptcode;
  String? deptname;

  GetPerson({this.code, this.name, this.deptcode, this.deptname});

  GetPerson.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? '';
    name = json['name'] ?? '';
    deptcode = json['Deptcode'] ?? '';
    deptname = json['deptname'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['Deptcode'] = deptcode;
    data['deptname'] = deptname;
    return data;
  }

  static List<GetPerson>? fromJsonList(List list) {
    return list.map((item) => GetPerson.fromJson(item)).toList();
  }
}

class GetShop {
  String? shopchar;
  String? shopname;
  String? ipPrinter;
  String? shopDate;

  GetShop({this.shopchar, this.shopname, this.ipPrinter, this.shopDate});

  GetShop.fromJson(Map<String, dynamic> json) {
    shopchar = json['shopchar'] ?? '';
    shopname = json['shopname'] ?? '';
    ipPrinter = json['ip_printer'] ?? '';
    shopDate = json['shop_date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopchar'] = shopchar;
    data['shopname'] = shopname;
    data['ip_printer'] = ipPrinter;
    data['shop_date'] = shopDate;
    return data;
  }

  static List<GetShop>? fromJsonList(List list) {
    return list.map((item) => GetShop.fromJson(item)).toList();
  }
}

class GetData {
  String? idIncom;
  String? incomDocno;
  String? incomDate;
  String? usercode;
  String? shopcode;
  String? shopname;
  String? deptcode;
  String? creditTot;
  String? fccoinTot;
  String? eshopTot;
  String? voucherTot;
  String? chequeTot;
  String? payinTot;
  String? taxTot;
  String? giftTot;
  String? coupon20Qty;
  String? coupon10Qty;
  String? coupon5Qty;
  String? uSDQty;
  String? uSDRate;
  String? sGDQty;
  String? sGDRate;
  String? tWDQty;
  String? tWDRate;
  String? jPYQty;
  String? jPYRate;
  String? hKDQty;
  String? hKDRate;
  String? gBPQty;
  String? gBPRate;
  String? cNYQty;
  String? cNYRate;
  String? aUDQty;
  String? aUDRate;
  String? eURQty;
  String? eURRate;
  String? tHB1000Qty;
  String? tHB500Qty;
  String? tHB100Qty;
  String? tHB50Qty;
  String? tHB20Qty;
  String? tHB10Qty;
  String? tHB5Qty;
  String? tHB2Qty;
  String? tHB1Qty;
  String? tHB050Qty;
  String? tHB025Qty;
  String? tOTAL;
  String? remark;
  String? tOTALCOUPON;
  String? tOTALREFUND;
  String? tOTALROUND1;

  GetData(
      {this.idIncom,
      this.incomDocno,
      this.incomDate,
      this.usercode,
      this.shopcode,
      this.shopname,
      this.deptcode,
      this.creditTot,
      this.fccoinTot,
      this.eshopTot,
      this.voucherTot,
      this.chequeTot,
      this.payinTot,
      this.taxTot,
      this.giftTot,
      this.coupon20Qty,
      this.coupon10Qty,
      this.coupon5Qty,
      this.uSDQty,
      this.uSDRate,
      this.sGDQty,
      this.sGDRate,
      this.tWDQty,
      this.tWDRate,
      this.jPYQty,
      this.jPYRate,
      this.hKDQty,
      this.hKDRate,
      this.gBPQty,
      this.gBPRate,
      this.cNYQty,
      this.cNYRate,
      this.aUDQty,
      this.aUDRate,
      this.eURQty,
      this.eURRate,
      this.tHB1000Qty,
      this.tHB500Qty,
      this.tHB100Qty,
      this.tHB50Qty,
      this.tHB20Qty,
      this.tHB10Qty,
      this.tHB5Qty,
      this.tHB2Qty,
      this.tHB1Qty,
      this.tHB050Qty,
      this.tHB025Qty,
      this.tOTAL,
      this.remark,
      this.tOTALCOUPON,
      this.tOTALREFUND,
      this.tOTALROUND1});

  GetData.fromJson(Map<String, dynamic> json) {
    idIncom = json['id_incom'] ?? '';
    incomDocno = json['incom_docno'] ?? '';
    incomDate = json['incom_date'] ?? '';
    usercode = json['usercode'] ?? '';
    shopcode = json['shopcode'] ?? '';
    shopname = json['shopname'] ?? '';
    deptcode = json['deptcode'] ?? '';
    creditTot = json['Credit_tot'] ?? '0';
    fccoinTot = json['Fccoin_tot'] ?? '0';
    eshopTot = json['Eshop_tot'] ?? '0';
    voucherTot = json['Voucher_tot'] ?? '0';
    chequeTot = json['Cheque_tot'] ?? '0';
    payinTot = json['Payin_tot'] ?? '0';
    taxTot = json['Tax_tot'] ?? '0';
    giftTot = json['Gift_tot'] ?? '0';
    coupon20Qty = json['Coupon20_qty'] ?? '0';
    coupon10Qty = json['Coupon10_qty'] ?? '0';
    coupon5Qty = json['Coupon5_qty'] ?? '0';
    uSDQty = json['USD_qty'] ?? '0';
    uSDRate = json['USD_rate'] ?? '0';
    sGDQty = json['SGD_qty'] ?? '0';
    sGDRate = json['SGD_rate'] ?? '0';
    tWDQty = json['TWD_qty'] ?? '0';
    tWDRate = json['TWD_rate'] ?? '0';
    jPYQty = json['JPY_qty'] ?? '0';
    jPYRate = json['JPY_rate'] ?? '0';
    hKDQty = json['HKD_qty'] ?? '0';
    hKDRate = json['HKD_rate'] ?? '0';
    gBPQty = json['GBP_qty'] ?? '0';
    gBPRate = json['GBP_rate'] ?? '0';
    cNYQty = json['CNY_qty'] ?? '0';
    cNYRate = json['CNY_rate'] ?? '0';
    aUDQty = json['AUD_qty'] ?? '0';
    aUDRate = json['AUD_rate'] ?? '0';
    eURQty = json['EUR_qty'] ?? '0';
    eURRate = json['EUR_rate'] ?? '0';
    tHB1000Qty = json['THB1000_qty'] ?? '0';
    tHB500Qty = json['THB500_qty'] ?? '0';
    tHB100Qty = json['THB100_qty'] ?? '0';
    tHB50Qty = json['THB50_qty'] ?? '0';
    tHB20Qty = json['THB20_qty'] ?? '0';
    tHB10Qty = json['THB10_qty'] ?? '0';
    tHB5Qty = json['THB5_qty'] ?? '0';
    tHB2Qty = json['THB2_qty'] ?? '0';
    tHB1Qty = json['THB1_qty'] ?? '0';
    tHB050Qty = json['THB050_qty'] ?? '0';
    tHB025Qty = json['THB025_qty'] ?? '0';
    tOTAL = json['TOTAL'] ?? '0';
    remark = json['remark'] ?? '';
    tOTALCOUPON = json['TOTAL_COUPON'] ?? '0';
    tOTALREFUND = json['TOTAL_REFUND'] ?? '0';
    tOTALROUND1 = json['TOTAL_ROUND1'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_incom'] = idIncom;
    data['incom_docno'] = incomDocno;
    data['incom_date'] = incomDate;
    data['usercode'] = usercode;
    data['shopcode'] = shopcode;
    data['shopname'] = shopname;
    data['deptcode'] = deptcode;
    data['Credit_tot'] = creditTot;
    data['Fccoin_tot'] = fccoinTot;
    data['Eshop_tot'] = eshopTot;
    data['Voucher_tot'] = voucherTot;
    data['Cheque_tot'] = chequeTot;
    data['Payin_tot'] = payinTot;
    data['Tax_tot'] = taxTot;
    data['Gift_tot'] = giftTot;
    data['Coupon20_qty'] = coupon20Qty;
    data['Coupon10_qty'] = coupon10Qty;
    data['Coupon5_qty'] = coupon5Qty;
    data['USD_qty'] = uSDQty;
    data['USD_rate'] = uSDRate;
    data['SGD_qty'] = sGDQty;
    data['SGD_rate'] = sGDRate;
    data['TWD_qty'] = tWDQty;
    data['TWD_rate'] = tWDRate;
    data['JPY_qty'] = jPYQty;
    data['JPY_rate'] = jPYRate;
    data['HKD_qty'] = hKDQty;
    data['HKD_rate'] = hKDRate;
    data['GBP_qty'] = gBPQty;
    data['GBP_rate'] = gBPRate;
    data['CNY_qty'] = cNYQty;
    data['CNY_rate'] = cNYRate;
    data['AUD_qty'] = aUDQty;
    data['AUD_rate'] = aUDRate;
    data['EUR_qty'] = eURQty;
    data['EUR_rate'] = eURRate;
    data['THB1000_qty'] = tHB1000Qty;
    data['THB500_qty'] = tHB500Qty;
    data['THB100_qty'] = tHB100Qty;
    data['THB50_qty'] = tHB50Qty;
    data['THB20_qty'] = tHB20Qty;
    data['THB10_qty'] = tHB10Qty;
    data['THB5_qty'] = tHB5Qty;
    data['THB2_qty'] = tHB2Qty;
    data['THB1_qty'] = tHB1Qty;
    data['THB050_qty'] = tHB050Qty;
    data['THB025_qty'] = tHB025Qty;
    data['TOTAL'] = tOTAL;
    data['remark'] = remark;
    data['TOTAL_COUPON'] = tOTALCOUPON;
    data['TOTAL_REFUND'] = tOTALREFUND;
    data['TOTAL_ROUND1'] = tOTALROUND1;
    return data;
  }

  static List<GetData>? fromJsonList(List list) {
    return list.map((item) => GetData.fromJson(item)).toList();
  }
}
