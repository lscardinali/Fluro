import 'package:checkout/models/product.dart';

abstract class ProductRepositoryInterface {
  List<Product> getProducts();
}

class ProductRepository implements ProductRepositoryInterface {
  @override
  List<Product> getProducts() {
    return [
      Product(
          sku: 'A',
          name: 'Seville Orange',
          price: 0.5,
          image:
              'https://static.vecteezy.com/system/resources/previews/022/825/521/original/orange-fruit-orange-on-transparent-background-png.png'),
      Product(
          sku: 'B',
          name: 'Ruby Frost Apple',
          price: 0.75,
          image:
              'https://proto.gr/sites/www.proto.gr/files/styles/colorbox/public/images/fruits/apple.png?itok=eNTrsBdf'),
      Product(
          sku: 'C',
          name: 'Lisbon Lemon',
          price: 0.25,
          image: 'https://pngfre.com/wp-content/uploads/lemon-44.png'),
      Product(
          sku: 'D',
          name: 'Crimson Grape',
          price: 1.50,
          image:
              'https://static.vecteezy.com/system/resources/previews/028/051/143/original/grape-isolated-a-red-grape-bunch-transparent-background-ai-generated-png.png'),
      Product(
          sku: 'E',
          name: 'Tropical Kiwi',
          price: 2.00,
          image: 'https://pngfre.com/wp-content/uploads/Kiwi-3.png'),
      Product(
          sku: 'F',
          name: 'Persian Pear',
          price: 1,
          image: 'https://freepngimg.com/save/14504-pear-png-clipart/339x259'),
    ].toList();
  }
}
