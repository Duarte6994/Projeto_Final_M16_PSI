import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../../../Administrador/Lista/appbar_add_admin.dart';
import 'package:pap_projeto/Cliente/Interface_Ementa/carrosel_imagens/carrosel.dart';
import '../../../core/app_data.dart';
import '../../controller/product_controller.dart';
import '../widget/product_grid_view.dart';

final ProductController controller = Get.put(ProductController());

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Color(0xFFFDAE47),
          elevation: 0.0,
          centerTitle: true,
          title: Text('My Coffee',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Varela',
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      body: Stack(
          children: <Widget>[
            CustomPaint(
              painter: appbar_add(),
              child: Container(height: 0),
            ),
    ListView(
            children: [
            SizedBox(width: 10,),
            Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 15),
            Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
                  "Destaques",
                      style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Varela'
                    ),
                ),
            ),
            SizedBox(height: 20),
            carrossel(),
            SizedBox(height: 10),
    SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub-Categorias",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Varela'
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: AppData.categories.length,
                    itemCount: controller.categories.length,
                    itemBuilder: (_, index) {
                      // ProductCategory category = controller.categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: GetBuilder<ProductController>(
                          builder: (ProductController controller) {
                            return Container(
                              width: 130,
                              height: 100,
                              decoration: BoxDecoration(
                                color:
                                controller.categories[index].isSelected ==
                                    false
                                    ? const Color(0xFFE5E6E8)
                                    : const Color(0xFFf16b26),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                IconButton(
                                  icon: FaIcon(controller.categories[index].icon,
                                      color: controller
                                          .categories[index].isSelected ==
                                          false
                                          ? const Color(0xFFA6A3A0)
                                          : Colors.white,
                                    ),
                                  iconSize: 24,
                                  color: Colors.white,
                                  //  onPressed: controller.filterItemsByCategory,
                                  onPressed: () =>
                                      controller.filterItemsByCategory(index),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: Text(controller.categories[index].name,
                                    style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Varela',
                                    fontSize: 16,
                                    color: Colors.black
                                    ),
                                    ),
                                  onPressed: () =>
                                      controller.filterItemsByCategory(index),
                                ),
                              ],
                              ),
                              ],
                            ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 36),
                const SizedBox(
                  height: 460,
                  child: ProductGridView(),
                )
              ],
            ),
          ),
        ),
      ),
    ]
    ),
    ),
    ]
    ),
    ]
    )
    );
  }
}

