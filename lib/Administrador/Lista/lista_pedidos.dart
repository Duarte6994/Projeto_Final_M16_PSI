import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/src/model/product.dart';
import '../../Cliente/Interface_Ementa/estilos/colors.dart';
import 'appbar_add_admin.dart';

class produto{
  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['nome'],
      price: snap['preco'],
      quantity: snap['quantidade'],
      isLiked: null,
      rating: 0,
      off: null,
      images: [],
      isAvailable: null,
      about: '',
    );
    return product;
  }
}
class pedidos extends StatefulWidget {
  const pedidos({Key? key}) : super(key: key);

  @override
  _pedidosState createState() => _pedidosState();
}

class _pedidosState extends State<pedidos> {

  @override
  void initState() {
    super.initState();
  }

  var _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                toolbarHeight: 80.0,
                backgroundColor: Color(0xFFFDAE47),
                elevation: 0.0,
                centerTitle: true,
              title: Text('My Coffee',
                style: TextStyle(
                  fontSize: 27,
                  fontFamily: 'Varela',
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
          ),
          backgroundColor: AppColors.white,
          body: Stack(
            children: <Widget>[
              CustomPaint(
                painter: appbar_add(),
                child: Container(height: 0),
              ),
              SizedBox(height: 50),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pedidos')
                    .orderBy('Data do pedido')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return const Center(
                        child: Text('Ocorreu um erro'),
                      );
                    } else {
                      return ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return Card(
                              margin: const EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Mesa ' + doc['Mesa'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Varela'),
                                    ),
                                    subtitle: Text(
                                      '\nData do pedido: ' + doc['Data do pedido'] + '\n\nPreço Total do Pedido: ' + doc['Preco total'].toString() + '€',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Varela'),),
                                    trailing: IconButton(onPressed: (){{
                                      Get.snackbar(
                                        '',
                                        '',
                                        snackPosition: SnackPosition.TOP,
                                        snackStyle: SnackStyle.FLOATING,
                                        messageText: const Text(
                                          'NESTE MOMENTO NÃO É POSSIVEL APAGAR PEDIDOS \n\n EM FASE DE DESENVOLVIMENTO!',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
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
                                    }
    }, icon: Icon(Icons.delete_rounded,
                                    size: 26,
                                    color: Colors.black,)),
                                  ),
                                  SizedBox(height:5),
                                  if (_expanded)
                                    (SizedBox(
                                      height: 200.0,
                                      child: ListView(
                                        children: List.generate(
                                        List.from(doc['Pedido']).length,
                                        (i) {
                                        return Column(
                                              children: [
                                                    SizedBox(height: 15),
                                                     Text('Produto: ' + doc['Pedido'][i]['nome'].toString(),
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 16,
                                                           fontFamily: 'Varela'),),
                                                     SizedBox(height: 8),
                                                     Text('Quantidade: ' + doc['Pedido'][i]['quantidade'].toString() + 'x',
                                                        style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16,
                                                        fontFamily: 'Varela'),),
                                                     SizedBox(height: 8),
                                                     Text('Preço do produto: ' + doc['Pedido'][i]['preco'].toString() + '€',
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 16,
                                                           fontFamily: 'Varela'),),
                                                     SizedBox(height: 15),
                                                        ],
                                                  );
                                                },
                                             ),
                                          ),
                                    )),
                                ],
                              ),
                            );
                          }).toList());
                    }
                  }
                },
              ),
    ],
   ),

  );
 }
}
