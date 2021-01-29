import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nuconta_marketplace/Utilities/Constants.dart';
import 'package:nuconta_marketplace/bloc/customer/customer_bloc.dart';
import 'package:nuconta_marketplace/models/offer.dart';

class OfferDetails extends StatefulWidget {
  final Offer offer;
  OfferDetails({Key key, this.offer}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  bool _isLoading = false;
  String _error = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer.product.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constants.primaryPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildImage(size),
              _buildDescription(),
              Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              _buildBuyNowButton(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuyNowButton(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        height: size.height * 0.1,
        minWidth: size.width,
        // padding: EdgeInsets.symmetric(horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Constants.primaryPurple,
        disabledColor: Constants.primaryPurple,
        onPressed: _isLoading
            ? null
            : () {
                // ignore: close_sinks
                var bloc = BlocProvider.of<CustomerBloc>(context);
                bloc.add(PurchaseOffer(offerId: widget.offer.id));

                bloc.listen((state) {
                  if (state is ErrorPurchaseOffer) {
                    _showMaterialDialog(
                        context: context,
                        title: '¡Oh no!',
                        textColor: Colors.red,
                        message: state.errorPurchaseMessage,
                        buttonText: "Back to home");
                  } else if (state is SuccessPurchaseOffer) {
                    _showMaterialDialog(
                        context: context,
                        title: 'Thank you',
                        textColor: Colors.green,
                        message: 'Your purchase was successfuly',
                        buttonText: "Back to home");
                  }
                });

                // Navigator.pop(context);
              },

        child: _isLoading
            ? CircularProgressIndicator(backgroundColor: Colors.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Buy now ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "\$${widget.offer.price}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.offer.product.description,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 19, letterSpacing: 2, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget buildImage(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
        child: Hero(
          tag: widget.offer.id,
          child: CachedNetworkImage(
            placeholder: (context, url) => LoadingIndicator(
              indicatorType: Indicator.ballRotate,
              color: Constants.primaryPurple,
            ),
            imageUrl: widget.offer.product.image,
            fit: BoxFit.contain,
            height: size.height * 0.35,
          ),
        ),
      ),
    );
  }

  _showMaterialDialog({
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Color textColor,
  }) {
    TextStyle textStyle = TextStyle(color: textColor);
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(title),
              content: new Text(message, style: textStyle),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    buttonText,
                    style: textStyle,
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                  },
                )
              ],
            ));
  }
}
