import 'package:nuconta_marketplace/bloc/customer/customer_exception.dart';
import 'package:nuconta_marketplace/models/customer.dart';
import 'package:nuconta_marketplace/repositories/offers_repository_interface.dart';
import 'package:nuconta_marketplace/services/graphql/graphql_queries.dart';
import 'package:nuconta_marketplace/services/graphql/graphql_service.dart';

class GraphqlRepository implements OffersRepositoryInterface {
  final GraphqlService _graphqlService;

  GraphqlRepository(this._graphqlService);

  @override
  Future<Customer> getCustomerData() async {
    var customerDataQuery =
        await _graphqlService.performQuery(GraphqlQueries.customerData);
    if (customerDataQuery.hasException) {
      print("Has exception ${customerDataQuery.exception}");
    }
    final customerData = Customer.fromJson(customerDataQuery.data['viewer']);
    return customerData;
  }

  @override
  Future<int> purchaseOffer(String offerId) async {
    var purchaseMutation = await _graphqlService.performMutation(
        GraphqlQueries.purchaseQuery,
        variables: {'offerId': offerId});
    if (purchaseMutation.hasException ||
        purchaseMutation.data['purchase']['success'] == false) {
      throw new CantPurchaseOffer(
          purchaseMutation.data['purchase']['errorMessage']);
    }
    return purchaseMutation.data['purchase']['customer']['balance'];
  }
}
