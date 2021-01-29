class GraphqlQueries {
  static const String customerData = r'''
  query{
    viewer {
      id
      name
      balance
      offers {
        id
        price
        product {
          id
          name
          description
          image
        }
      }
    }
  }
  ''';

  static const String purchaseQuery = '''
  mutation Purchase(\$offerId : ID!){
    purchase(offerId: \$offerId){
      success,
      errorMessage
      customer{
        balance
      }
    }
  }
  ''';
}
