import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nuconta_marketplace/models/customer.dart';
import 'package:nuconta_marketplace/models/offer.dart';
import 'package:nuconta_marketplace/models/product.dart';
import 'package:nuconta_marketplace/repositories/offers_repository_interface.dart';

class MockOffersRepository extends Mock implements OffersRepositoryInterface {}

main() {
  final customerData = Customer(
      id: "CUSTOMER_TEST_ID",
      balance: 1000,
      name: "John Doe",
      offers: [
        Offer(
            id: 'offer/mock',
            price: 10,
            product: Product(
                id: 'product/mock',
                name: 'Mock',
                description: 'lorem ipsum ...',
                image: 'image/mock'))
      ]);

  MockOffersRepository _mockOffersRepository;
  setUp(() => _mockOffersRepository = MockOffersRepository());
  test('When called the function getCustomerData should return Customer object',
      () async  {
    when(_mockOffersRepository.getCustomerData())
        .thenAnswer((_) => Future.value(customerData));
    var customer = await _mockOffersRepository.getCustomerData();
    expect(customer.id, 'CUSTOMER_TEST_ID');
  });
}
