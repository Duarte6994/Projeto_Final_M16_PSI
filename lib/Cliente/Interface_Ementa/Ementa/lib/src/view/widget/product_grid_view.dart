import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../model/product.dart';
import '../screen/product_detail_screen.dart';
import 'open_container_wrapper.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        itemCount: controller.filteredProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 42 / 59,
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,),
        itemBuilder: (_, index) {
          Product product = controller.filteredProducts[index];
          return OpenContainerWrapper(
              child: GridTile(
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 148,
                    padding: EdgeInsets.only(left: 30, right: 10,top: 10,bottom: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),)),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontFamily: 'Varela',
                            fontSize: 15),
                      ),
                        ),
                      ),
                    ],
                  ),
                ),
                footer: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 30, top: 10, right: 15),
                  child: Container(
                    padding: const EdgeInsets.only(left: 1),
                    height: 42,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 2),
                            Text(
                              product.off != null
                                  ? "  Preço ${product.off}\€"
                                  : "  Preço ${product.price}\€",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Varela',
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                            SizedBox(width: 20),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E6E8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    product.images[0],
                    scale: 2,
                  ),
                ),
              ),
              product: product);
        },
      ),
    );
  }
}
