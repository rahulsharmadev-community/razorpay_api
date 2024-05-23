import 'package:flutter/material.dart';
import 'package:razorpay_api/razorpay_api.dart';

var razorPayAPI = RazorPayAPI();
void main() {
  RazorPayAPI.init(keyId: '', keySecret: "");
  runApp(const MyApp());
}

final massenger = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: massenger,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _order = RazorPayOrder(
      amount: 7500,
      currency: RazorpayCurrency.INR,
      receipt: 'receipt #01',
      notes: {'note1': '100 cr.', 'note: 2': 'hope it will work'});
  late final RazorPayOrderResponse orderResponse;
  @override
  Widget build(BuildContext context) {
    void onSuccess(PaymentSuccessResponse response) => showTextDialog(context,
        buttonText: 'Successful',
        centerText: 'Payment Id: ${response.paymentId}',
        responseText: 'Order id: ${response.orderId}');
    void onError(PaymentFailureResponse response) => showTextDialog(context,
        buttonText: 'Okay', centerText: '${response.message}', responseText: 'Error Code: ${response.code}');
    void onExternalWallet(ExternalWalletResponse response) => showTextDialog(context,
        buttonText: 'External Wallet',
        centerText: 'Wallet Name: ${response.walletName}',
        responseText: 'Wallet Name: ${response.walletName}');

    return AutofillGroup(
      child: Scaffold(
        appBar: AppBar(title: const Text('RazorPay Demo')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var temp = await RazorPayRefundAPI().fetchAll();
                    if (temp != null) {
                      print(temp.map((e) => e.toJson()));
                      massenger.currentState?.showSnackBar(const SnackBar(content: Text('Fetch')));
                    }
                  },
                  child: const Text('Fetch All Order')),
              ElevatedButton(
                  onPressed: () async {
                    var temp = await const RazorPayOrderAPI().createOrder(_order);
                    if (temp != null) {
                      orderResponse = temp;
                      print(orderResponse.toJson());
                      massenger.currentState
                          ?.showSnackBar(const SnackBar(content: Text('Order response recived')));
                    }
                  },
                  child: const Text('Create an Order')),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    var checkout = RazorpayCheckout(
                        amount: orderResponse.amount,
                        currency: RazorpayCurrency.INR,
                        name: "WOODLAND Outdoor Shoes For Men",
                        orderId: orderResponse.id,
                        timeout: 120,
                        notes: const {'note: 1': '100 cr.', 'note: 2': 'hope it will work'},
                        description:
                            'Soft foot bed with plush rubberized foam cushioning grounds a cozy slip-on shoe for men. ',
                        sendSmsHash: true,
                        image:
                            'https://rukminim2.flixcart.com/image/832/832/j1b0xow0/shoe/z/d/h/gc-0549108y15nw-44-woodland-camel-original-imaeswufmus2z6kz.jpeg',
                        theme:
                            RazorPayCheckOutTheme(color: Colors.lightBlueAccent, backdropColor: Colors.black),
                        prefill: Prefill(
                            contact: '+918368968075',
                            name: 'Rahul Sharma',
                            email: 'rahulsharmadev.talk@gmail.com'));

                    razorPayAPI.checkout(checkout);

                    razorPayAPI.handler(onSuccess, onError, onExternalWallet);
                  },
                  child: const Text('Pay \$100')),
            ],
          ),
        ),
      ),
    );
  }

  void showTextDialog(BuildContext context,
      {required String buttonText, required String centerText, required String responseText}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(responseText), content: Text(centerText), actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  razorPayAPI.dispose();
                },
                child: Text(buttonText))
          ]);
        });
  }
}
