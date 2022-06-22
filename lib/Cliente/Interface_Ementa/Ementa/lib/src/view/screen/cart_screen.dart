import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/src/model/product.dart';
import 'package:provider/provider.dart';
import '../../../../../estilos/style.dart';
import '../../controller/product_controller.dart';
import '../../model/product.dart';
import '../widget/empty_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  String ticket = '';
  List<String> tickets = [];

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Inválida');
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('assets/Icons/splash_icon.png'),
            onPressed: null,
            iconSize: 25,
            ),
          actions: [
            IconButton(
              icon: Image.asset('assets/Icons/qrcodescan.png'),
              iconSize: 40,
              onPressed: readQRCode,
            )
          ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              if (ticket != '')
              Padding(
                padding: EdgeInsets.only(left: 145),
              child: PrimaryText(
              text: 'Mesa $ticket',
              size: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              ),
              ),
              ],
              ),
          ),
          Expanded(
            flex: 10,
            child: !controller.isEmptyCart
                ? ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: controller.cartProducts.length,
              itemBuilder: (_, index) {
                Product product = controller.cartProducts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(15),
                  width: 150,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.grey[200]?.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorExtension.randomColor),
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              product.images[0],
                              width: 70,
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17),
                            ),
                            Text(
                              controller.getCurrentSize(product),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Text(
                              controller.isPriceOff(product)
                                  ? "${product.off}\€"
                                  : "${product.price}\€",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            FittedBox(
                              child: IconButton(
                                splashRadius: 10.0,
                                onPressed: () =>
                                    controller.decreaseItem(index),
                                icon: const Icon(
                                  Icons.remove,
                                  color: Color(0xFFEC6813),
                                ),
                              ),
                            ),
                            GetBuilder<ProductController>(
                              builder: (ProductController controller) {
                                return Text(
                                  '${controller.cartProducts[index].quantity}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                );
                              },
                            ),
                            FittedBox(
                                child: IconButton(
                                    splashRadius: 10.0,
                                    onPressed: () =>
                                        controller.increaseItem(index),
                                    icon: const Icon(Icons.add,
                                        color: Color(0xFFEC6813)))),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                : const EmptyCart(),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total: ",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 60),
                  Obx(() {
                    return Text(
                      "${controller.totalPrice.value}\€",
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEC6813),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                child: ElevatedButton(
                  child: const Text("Submeter Pedido"),
                  onPressed: controller.isEmptyCart ? null : (){
                    Map<String, dynamic> data = {"Mesa $ticket": <Product>[]};
                    FirebaseFirestore.instance.collection('pedidos').add({
                    'Mesa': ticket,
                    'Data do pedido': DateTime.now().toString(),
                    'Pedido': controller.cartProducts.map((e) => e.toMap()).toList(),
                    'Preco total': controller.totalPrice.value,
                    });
                    Get.snackbar(
                        '',
                        '',
                        snackPosition: SnackPosition.TOP,
                        snackStyle: SnackStyle.FLOATING,
                        messageText: const Text(
                        'O teu pedido foi registado com sucesso!',
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                      textAlign: TextAlign.center,
                    ),
                      titleText: Container(),
                      margin: const EdgeInsets.only(top: kBottomNavigationBarHeight, left: 8, right: 8),
                      padding: const EdgeInsets.only(top: 5, left: 6, right: 6,bottom: 8),
                      borderRadius: 30,
                      backgroundColor: Colors.white70,
                      colorText: Theme.of(context).colorScheme.surface,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}



