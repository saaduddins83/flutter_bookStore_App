import 'package:app_book_store/providers/uidProvider.dart';
import 'package:flutter/material.dart';

// Assuming these pages are already created
import 'package:app_book_store/admin/addBooks.dart';
import 'package:app_book_store/admin/book_listing.dart';
import 'package:app_book_store/admin/updateBooks.dart';
import 'package:app_book_store/admin/userAccounts.dart';
import 'package:provider/provider.dart';

class NavigationFAB extends StatelessWidget {
  const NavigationFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showNavigationDialog(context);
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  void _showNavigationDialog(BuildContext context) {
    final String? uid = Provider.of<UidProvider>(context).uid;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Navigate to"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Add Book"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddBookPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Book List"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookListPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Update Books"),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const UpdateBooks(data: uid)),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text("User Account"),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => UserAccountPage(
                  //             userId: uid ?? '',
                  //           )),
                  // );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
