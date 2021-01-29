import 'package:graphql/client.dart';
import 'package:nuconta_marketplace/Utilities/Constants.dart';

class GraphqlService {
  GraphQLClient _graphQLClient;

  GraphqlService() {
    final HttpLink _httpLink = HttpLink(
        uri: Constants.endPoint,
        headers: {'Authorization': 'Bearer ${Constants.token}'});
    _graphQLClient = GraphQLClient(
      link: _httpLink,
      cache: InMemoryCache(),
    );
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(documentNode: gql(query), variables: variables);
    final result = await _graphQLClient.mutate(options);
    return result;
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    QueryOptions options =
        QueryOptions(documentNode: gql(query), variables: variables);
    final result = await _graphQLClient.query(options);
    return result;
  }
}
