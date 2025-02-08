import 'package:app_book_store/providers/cartProvider.dart';
import 'package:app_book_store/providers/productsProvider.dart';
import 'package:app_book_store/routes/app_routes.dart';
import 'package:app_book_store/screens/checkOutScreen.dart';
import 'package:app_book_store/services/auth_services.dart';
import 'package:app_book_store/widgets/bigCardImageSlide.dart';
import 'package:app_book_store/widgets/iconBtnWithCounter.dart';
import 'package:app_book_store/widgets/icons.dart';
import 'package:app_book_store/widgets/productCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart' as model_product;
import 'package:app_book_store/widgets/chipsStyle.dart';
import 'package:app_book_store/screens/productDetailScreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  // static String routeName = "/home";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AuthService _authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Productsprovider>(context, listen: false).fetchProducts();
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Row(
                children: [
                  IconBtnWithCounter(
                    svgSrc: cartIcon,
                    numOfitem: cart.numOfItems,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            cartItems: cart.cartItems,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  // IconBtnWithCounter(
                  //   svgSrc: bellIcon,
                  //   // numOfitem: 3, // You can add a different count for bell if necessary
                  //   press: () {},
                  // ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
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
              leading: Icon(Icons.settings),
              title: Text('Order History'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.orderHistoryScreen);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                User? currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  // Proceed with logout
                  _authService.logout(context);
                } else {
                  // User is already logged out, display a message or handle accordingly
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User is already logged out!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child:
            Consumer<Productsprovider>(builder: (context, productsprovider, _) {
          return productsprovider.isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const HomeHeader(),
                      const DiscountBanner(),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: BigCardImageSlide(images: [
                          "https://i.postimg.cc/3kLKCFGr/02.jpg",
                          "https://i.postimg.cc/Yv2rWshy/03.jpg",
                          "https://i.postimg.cc/tntb13yj/07.jpg",
                          "https://i.postimg.cc/jDkbJdVL/08.jpg",
                          "https://i.postimg.cc/MM1247nQ/09.jpg",
                        ]),
                      ),
                      const SizedBox(height: 20),
                      const PopularProducts(),
                      const SizedBox(height: 20),
                      const RecentlyAddedProducts(),
                      const SizedBox(height: 20),
                      BestSellers(
                          products: productsprovider.products.sublist(
                              0,
                              productsprovider.products.length > 3
                                  ? 3
                                  : productsprovider.products.length)),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
        }),
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

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        onEditingComplete: () {
          if (_searchController.text.trim().isEmpty) return;
          Navigator.pushNamed(context, AppRoutes.category1,
              arguments: _searchController.text.trim());
        },
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          fillColor: const Color(0xFF979797).withOpacity(0.1),
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

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 10),
          child: Title(
              color: Colors.black,
              child: Text("Special for you",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4A3298),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(text: "A Summer Surpise\n"),
                TextSpan(
                  text: "Cashback 20%",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.category1);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text("See more"),
        ),
      ],
    );
  }
}

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productsprovider =
        Provider.of<Productsprovider>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {},
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productsprovider.products
                .sublist(
                    0,
                    productsprovider.products.length > 6
                        ? 6
                        : productsprovider.products.length)
                .length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ProductCard(
                  product: productsprovider.products[index],
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                            product: productsprovider.products[index]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
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

class RecentlyAddedProducts extends StatelessWidget {
  const RecentlyAddedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productsprovider =
        Provider.of<Productsprovider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Recently Added",
            press: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productsprovider.products
                .sublist(
                    0,
                    productsprovider.products.length > 4
                        ? 4
                        : productsprovider.products.length)
                .length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: productsprovider.products[index],
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                          product: productsprovider.products[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// class Product {
//   final int id;
//   final String title, description;
//   final List<String> images;
//   // final List<Color> colors;
//   final double rating, price;
//   final bool isFavourite, isPopular;

//   Product({
//     required this.id,
//     required this.images,
//     // required this.colors,
//     this.rating = 0.0,
//     this.isFavourite = false,
//     this.isPopular = false,
//     required this.title,
//     required this.price,
//     required this.description,
//   });
// }

// // Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: ["https://i.postimg.cc/3kLKCFGr/02.jpg"],
//     // colors: [
//     //   const Color(0xFFF6625E),
//     //   const Color(0xFF836DB8),
//     //   const Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "The Lawser",
//     price: 64.99,
//     description: 'The Lawser is a book by John Grisham',
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "https://i.postimg.cc/Yv2rWshy/03.jpg",
//     ],
//     // colors: [
//     //   const Color(0xFFF6625E),
//     //   const Color(0xFF836DB8),
//     //   const Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "The Adventure",
//     price: 50.5,
//     description: "The Adventure is a book by John Grisham",
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "https://i.postimg.cc/f3JMHS7c/04.jpg",
//     ],
//     // colors: [
//     //   const Color(0xFFF6625E),
//     //   const Color(0xFF836DB8),
//     //   const Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "The Magnolia Table",
//     price: 36.55,
//     description: "The Magnolia Table is a book by John Grisham",
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "https://i.postimg.cc/wyNgzKG3/05.jpg",
//     ],
//     // colors: [
//     //   const Color(0xFFF6625E),
//     //   const Color(0xFF836DB8),
//     //   const Color(0xFFDECB9C),
//     //   Colors.white,
//     // ],
//     title: "The Saint X",
//     price: 36.55,
//     description: "The Saint X is a book by John Grisham",
//     rating: 4.1,
//     isFavourite: false,
//     isPopular: true,
//   ),
// ];
