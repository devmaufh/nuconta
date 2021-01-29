part of 'customer_bloc.dart';

abstract class CustomerEvent {}

class InitialState extends CustomerEvent {}

class FetchCustomer extends CustomerEvent {
  FetchCustomer();
}

class PurchaseOffer extends CustomerEvent {
  final String offerId;
  PurchaseOffer({this.offerId});
}

class UpdateCustomerBalance extends CustomerEvent {
  final int balance;
  UpdateCustomerBalance({this.balance});
}
