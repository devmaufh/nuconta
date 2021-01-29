import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nuconta_marketplace/Utilities/Constants.dart';
import 'package:nuconta_marketplace/models/offer.dart';
import 'package:nuconta_marketplace/pages/offer_details.dart';

class ItemOffer extends StatelessWidget {
  const ItemOffer({Key key, @required this.size, @required this.offer})
      : super(key: key);

  final Size size;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OfferDetails(offer: this.offer))),
      child: Container(
        margin: EdgeInsets.all(15),
        height: size.height * 0.10,
        child: Center(
          child: Row(
            children: [
              Hero(
                tag: offer.id,
                child: CachedNetworkImage(
                  placeholder: (context, url) => LoadingIndicator(
                    indicatorType: Indicator.ballRotate,
                    color: Constants.primaryPurple,
                  ),
                  imageUrl: offer.product.image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                offer.product.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(
                "\$${offer.price}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
