import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuconta_marketplace/bloc/customer/customer_bloc.dart';

import 'item_offer.dart';

class OfferList extends StatelessWidget {
  const OfferList({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var offersList =
        (BlocProvider.of<CustomerBloc>(context).state).customer.offers;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: offersList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemOffer(
            size: size,
            offer: offersList[index],
          );
        },
      ),
    );
  }
}
