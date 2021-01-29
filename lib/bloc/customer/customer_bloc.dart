import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nuconta_marketplace/bloc/customer/customer_exception.dart';
import 'package:nuconta_marketplace/models/customer.dart';
import 'package:nuconta_marketplace/repositories/offers_repository_interface.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final OffersRepositoryInterface repository;

  CustomerBloc(this.repository) : super(CustomerState());

  @override
  Stream<CustomerState> mapEventToState(
    CustomerEvent event,
  ) async* {
    if (event is FetchCustomer) {
      yield* _mapFetchCustomer(event);
    } else if (event is PurchaseOffer) {
      yield* _mapPurchaseOffer(event);
    }
  }

  Stream<CustomerState> _mapFetchCustomer(FetchCustomer event) async* {
    if (event is FetchCustomer) {
      try {
        final Customer customer = await repository.getCustomerData();
        yield state.copyWith(customer: customer);
      } catch (_) {
        yield state.copyWith(
            customer: Customer(), loadingError: "Can't fetch data");
      }
    }
  }

  Stream<CustomerState> _mapPurchaseOffer(PurchaseOffer event) async* {
    try {
      final int newBalance = await repository.purchaseOffer(event.offerId);
      yield SuccessPurchaseOffer();
      yield state.copyWith(
          customer: state.customer.copyWith(balance: newBalance));
    } on CantPurchaseOffer catch (e) {
      yield ErrorPurchaseOffer(e.cause);
    }
  }
}
