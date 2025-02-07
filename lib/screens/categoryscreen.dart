import 'package:app_book_store/providers/cartProvider.dart';
import 'package:app_book_store/providers/productsProvider.dart';
import 'package:app_book_store/screens/productDetailScreen.dart';
import 'package:app_book_store/widgets/iconBtnWithCounter.dart';
import 'package:app_book_store/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart' as model_product;
import 'package:app_book_store/widgets/chipsStyle.dart';
import 'package:provider/provider.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key, this.searchQuery});
  final String? searchQuery;

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  List<model_product.Product> filteredProducts = model_product.products;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    filteredProducts = Provider.of<Productsprovider>(context).products;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.searchQuery != null) {
      updateSearchQuery(widget.searchQuery!, shouldNotify: false);
    }
  }

  void updateSearchQuery(String query, {bool shouldNotify = true}) {
    final allProducts =
        Provider.of<Productsprovider>(context, listen: false).products;

    filteredProducts = allProducts.where((product) {
      final titleLower = product.title.toLowerCase();
      final categoriesLower = product.categories.join(' ').toLowerCase();
      final priceString = product.price.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          categoriesLower.contains(searchLower) ||
          priceString.contains(searchLower);
    }).toList();

    if (shouldNotify) {
      setState(() {}); // Ensure this is needed only when the UI should change
    }
  }

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
              HomeHeader(onSearch: updateSearchQuery),
              const SizedBox(height: 10),
              BestSellers(products: filteredProducts),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 16),
          Expanded(child: SearchField(onSearch: onSearch)),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onSearch});

  final Function(String) onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: widget.onSearch,
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
