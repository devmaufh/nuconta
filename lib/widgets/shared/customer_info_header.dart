import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuconta_marketplace/Utilities/Constants.dart';
import 'package:nuconta_marketplace/bloc/customer/customer_bloc.dart';

class CustomerInfoHeader extends StatelessWidget {
  const CustomerInfoHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var customer = (BlocProvider.of<CustomerBloc>(context).state).customer;

    return Container(
      height: size.height * 0.35,
      width: size.width,
      decoration: BoxDecoration(
        color: Constants.primaryPurple,
        // borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, ${customer.name}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Balance",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white),
          ),
          Text(
            "\$${customer.balance}",
            style: TextStyle(
                letterSpacing: 3.5,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
