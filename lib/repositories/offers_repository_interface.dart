import 'package:nuconta_marketplace/models/customer.dart';

abstract class OffersRepositoryInterface {
  Future<Customer> getCustomerData();

  Future<int> purchaseOffer(String offerId);
}
