abstract class CustomerException implements Exception {}

class CantPurchaseOffer extends CustomerException {
  String cause;
  CantPurchaseOffer(this.cause);
}
