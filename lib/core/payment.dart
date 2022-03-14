import 'package:bloodbank/constants.dart';
import 'package:bloodbank/core/viewmodels/general_provider.dart';
import 'package:bloodbank/ui/widgets/toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:bloodbank/ui/screens/bottomnavigator.dart';

class Payment extends StatefulWidget {
  Payment({Key key, this.title, this.busWidget, this.data, this.docId})
      : super(key: key);

  final String title;
  final Map data;
  final Widget busWidget;
  final docId;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Razorpay _razorpay;
  GeneralProvider generalProvider;
  List selectedSeats = [];
  double total = 0.0;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    generalProvider.seatsData.forEach((element) {
      if (element["isSelected"] == true) {
        selectedSeats.add(element);
      }
    });

    selectedSeats.forEach((e) {
      total += double.parse(e["price"]);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void launchPayment() async {
    print("TOTAL $total");
    var options = {
      'key': 'rzp_test_e5Q4MaKYXrfSnE',
      'currency': 'INR',
      'amount': total * 100,
      'name': 'flutterdemorazorpay',
      'description': 'Test payment from Flutter app',
      'prefill': {'contact': '', 'email': ''},
      'external': {'wallets': []}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Error ' + response.code.toString() + ' ' + response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    if (generalProvider.seatMaxCount == 0) {
      toaster(message: AppStrings.atleastOneSeat);
    }
    var result = await generalProvider.updateSeatBooked(
      parentDocId: widget.docId,
      docId: DateFormat.yMMMd().format(DateTime.now()),
    );
    if (result == true) {
      toaster(message: AppStrings.paySuccess);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigator()),
          (route) => false);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'Wallet Name ' + response.walletName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Payment",
          style: regularStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: widget.busWidget,
            ),
            SizedBox(height: 15.0),
            ...List.generate(
              selectedSeats.length,
              (index) => Container(
                padding: EdgeInsets.only(bottom: 15),
                width: 90,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Seat No"),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Price")
                        ],
                      ),
                      Column(
                        children: [
                          Text(selectedSeats[index]["seat"]),
                          SizedBox(
                            height: 5,
                          ),
                          Text(selectedSeats[index]["price"]),
                        ],
                      )
                    ]),
              ),
            ),
            SizedBox(height: 15.0),
            Text("Total Amount \u{20B9}$total"),
            SizedBox(height: 15.0),
            RaisedButton(
              color: AppConstants.primaryAccent,
              textColor: Colors.white,
              child: Text('PAY NOW'),
              onPressed: () {
                launchPayment();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget ticketSummary() {
    selectedSeats.forEach((element) {
      return Row(children: [
        Column(
          children: [Text("Seat No"), Text("Price")],
        )
      ]);
    });
  }
}
