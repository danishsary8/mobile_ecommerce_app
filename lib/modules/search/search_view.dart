import 'package:flutter/material.dart';
import '../../data/demo_products.dart';
import '../../widgets/app_input.dart';
import '../../widgets/product_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List get _filteredProducts {
    if (_query.isEmpty) {
      return [];
    }
    return demoProducts
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: AppInput(
          controller: _searchController,
          hint: 'Search products...',
          onChanged: (value) {
            setState(() => _query = value.trim());
          },
          prefixIcon: const Icon(Icons.search),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: _query.isEmpty
            ? const Center(
          child: Text(
            "Type something to search products",
            style: TextStyle(fontSize: 16),
          ),
        )
            : results.isEmpty
            ? const Center(
          child: Text(
            "No matching products found",
            style: TextStyle(fontSize: 16),
          ),
        )
            : GridView.builder(
          itemCount: results.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            return ProductCard(product: results[index]);
          },
        ),
      ),
    );
  }
}
