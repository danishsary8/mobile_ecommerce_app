import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class CheckoutAddressView extends StatefulWidget {
  const CheckoutAddressView({super.key});

  @override
  State<CheckoutAddressView> createState() => _CheckoutAddressViewState();
}

class _CheckoutAddressViewState extends State<CheckoutAddressView> {
  int selectedIndex = -1;

  // Example address list — you can replace with your real data
  final List<Map<String, String>> addresses = [
    {
      'title': 'Home',
      'address': '123 Main St',
      'city': 'Phnom Penh, KH',
    },
    {
      'title': 'Office',
      'address': '456 Central Blvd',
      'city': 'Phnom Penh, KH',
    },
    {
      'title': 'Friend\'s Place',
      'address': '789 River Rd',
      'city': 'Phnom Penh, KH',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final item = addresses[index];
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1.6,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['address']!,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  item['city']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ===== Add New Address Button =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  icon: const Icon(Icons.add_location_alt),
                  label: const Text(
                    'Add New Address',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    // TODO: Navigate to an “Add Address” screen
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ===== Continue Button =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ).copyWith(
                    shadowColor: MaterialStateProperty.all(
                      const Color(0xFF3B82F6).withOpacity(0.35),
                    ),
                  ),
                  onPressed: selectedIndex == -1
                      ? null
                      : () {
                    Get.toNamed(AppRoutes.checkoutDelivery);
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
