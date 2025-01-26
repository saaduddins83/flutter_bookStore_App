import 'package:app_book_store/providers/cartProvider.dart';
import 'package:app_book_store/screens/productDetailScreen.dart';
import 'package:app_book_store/widgets/iconBtnWithCounter.dart';
import 'package:app_book_store/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart' as model_product;
import 'package:app_book_store/widgets/chipsStyle.dart';
import 'package:provider/provider.dart';

class Categoryscreen1 extends StatefulWidget {
  const Categoryscreen1({super.key});

  @override
  State<Categoryscreen1> createState() => _Categoryscreen1State();
}

class _Categoryscreen1State extends State<Categoryscreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Screen"),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Row(
                children: [
                  IconBtnWithCounter(
                    svgSrc: cartIcon,
                    numOfitem: cart.numOfItems,
                    press: () {},
                  ),
                  const SizedBox(width: 8),
                  IconBtnWithCounter(
                    svgSrc: bellIcon,
                    // numOfitem: 3, // You can add a different count for bell if necessary
                    press: () {},
                  ),
                  const SizedBox(width: 8),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://i.postimg.cc/7ZQYv8Vv/Profile-Image.png",
                        ),
                        onBackgroundImageError: (_, __) {
                          // Handle error
                        },
                        child: Image.network(
                          "https://i.postimg.cc/7ZQYv8Vv/Profile-Image.png",
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person); // Default profile icon
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                // Handle account tap
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              BestSellers(products: model_product.products),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 16),
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          fillColor: Color.fromRGBO(151, 151, 151, 0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          hintText: "Search product",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class BestSellers extends StatelessWidget {
  final List<model_product.Product> products;

  const BestSellers({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((product) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.images[0],
                      width: 100.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            product.description,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 16.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: product.categories.map((category) {
                              return Chip(
                                label: Text(
                                  category,
                                  style: getCategoryTextStyle(category),
                                ),
                                backgroundColor:
                                    getCategoryBackgroundColor(category),
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Rs. ${product.price}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
