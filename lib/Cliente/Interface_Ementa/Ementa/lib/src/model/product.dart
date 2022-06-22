import 'package:pap_projeto/Cliente/Interface_Ementa/Ementa/lib/src/model/product_size_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductType { all,snacks, bebidas,cafe,petiscos}

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool? isAvailable;
  ProductSizeType? sizes;
  int quantity;
  List<String> images;
  bool? isLiked;
  double rating;
  ProductType? type;

  Product(
      {
      required this.name,
      required this.price,
      required this.about,
      required this.isAvailable,
      this.sizes,
      required this.off,
      required this.quantity,
      required this.images,
      required this.isLiked,
      required this.rating,
      this.type,
      }
  );

  Map<String, dynamic> toJson() => {
    'nome': name,
    'preco': price,
    'quantidade': quantity ,
  };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
      price: map["preco"],
      name: map["nome"],
      quantity: map["quantidade"],
      isAvailable: null,
      about: '',
      isLiked: null,
      off: null,
      rating: 0,
      images: [],
  );


  Map<String, dynamic> toMap() =>
    {
      'nome': name,
      'preco': price,
      'quantidade': quantity,
    };

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

