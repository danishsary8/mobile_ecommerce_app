import 'package:clothing_app/data/order.dart';
import 'package:clothing_app/modules/main/main_view.dart';
import 'package:clothing_app/modules/order_details/order_details_view.dart';
import 'package:get/get.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/auth/forgot_password_view.dart';
import '../modules/auth/reset_sent_view.dart';
import '../modules/auth/splash_view.dart';
import '../modules/home/home_view.dart';
import '../modules/product/product_detail_view.dart';
import '../modules/cart/cart_view.dart';
import '../modules/checkout/checkout_address_view.dart';
import '../modules/checkout/checkout_delivery_view.dart';
import '../modules/checkout/checkout_payment_view.dart';
import '../modules/checkout/checkout_review_view.dart';
import '../modules/checkout/order_success_view.dart';
import '../modules/profile/profile_view.dart';
import '../modules/orders/orders_view.dart';
import '../modules/notifications/notifications_view.dart';
import '../modules/search/search_view.dart';
import '../modules/wishlist/wishlist_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.login, page: () =>  LoginView()),
    GetPage(name: AppRoutes.register, page: () => const RegisterView()),
    GetPage(name: AppRoutes.forgot, page: () =>  ForgotPasswordView()),
    GetPage(name: AppRoutes.resetSent, page: () => const ResetSentView()),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(name: AppRoutes.product, page: () => const ProductDetailView()),
    GetPage(name: AppRoutes.cart, page: () => const CartView()),

    // ─── CHECKOUT FLOW ─────────────────────────────
    GetPage(
      name: AppRoutes.checkoutAddress,
      page: () => const CheckoutAddressView(),
    ),
    GetPage(
      name: AppRoutes.checkoutDelivery,
      page: () => const CheckoutDeliveryView(),
    ),
    GetPage(
      name: AppRoutes.checkoutPayment,
      page: () => const CheckoutPaymentView(),
    ),
    GetPage(
      name: AppRoutes.checkoutReview,
      page: () => const CheckoutReviewView(),
    ),

    GetPage(name: AppRoutes.orderSuccess, page: () => const OrderSuccessView()),

    GetPage(name: AppRoutes.profile, page: () => const ProfileView()),
    GetPage(name: AppRoutes.orders, page: () => const OrdersView()),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => OrderDetailsView(
        order: Get.arguments as Order,
      ),
    ),

    GetPage(name: AppRoutes.notifications, page: () => const NotificationsView()),
    GetPage(name: AppRoutes.search, page: () => const SearchView()),
    GetPage(name: AppRoutes.wishlist, page: () => const WishlistView()),
  ];
}
