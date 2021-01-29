part of 'customer_bloc.dart';

class CustomerState {
  final bool isLoading;
  final Customer customer;
  String loadingError;

  CustomerState({Customer customer, String loadingError = ''})
      : customer = customer ?? null,
        isLoading = (customer != null) ? false : true,
        loadingError = loadingError;

  CustomerState copyWith({Customer customer, String loadingError}) =>
      CustomerState(
          customer: customer ?? this.customer,
          loadingError: loadingError ?? this.loadingError);

  CustomerState initialState() => new CustomerState();
}

class ErrorPurchaseOffer extends CustomerState {
  final String errorPurchaseMessage;
  ErrorPurchaseOffer(this.errorPurchaseMessage);
}

class SuccessPurchaseOffer extends CustomerState {}
