import 'package:flutter_test/flutter_test.dart';
import 'package:nuconta_marketplace/services/graphql/graphql_queries.dart';
import 'package:nuconta_marketplace/services/graphql/graphql_service.dart';

main() {
  GraphqlService graphqlService = GraphqlService();
  test('should do a successful request to graphql service', () async {
    var result = await graphqlService.performQuery(GraphqlQueries.customerData);
    expect(result.hasException, false);
  });

  test('Should do a bad request with a malformed query to graphql service',
      () async {
    var result = await graphqlService.performQuery('query{BADQUERY}');
    expect(result.hasException, true);
  });

  test('Should do a successful purchase', () async {
    var result = await graphqlService.performMutation(
        GraphqlQueries.purchaseQuery,
        variables: {'offerId': 'offer/portal-gun'});
    expect(result.hasException, false);
  });
}
