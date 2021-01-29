import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuconta_marketplace/bloc/customer/customer_bloc.dart';
import 'package:nuconta_marketplace/widgets/offers/offer_list.dart';
import 'package:nuconta_marketplace/widgets/shared/customer_info_header.dart';
import 'package:nuconta_marketplace/widgets/shared/loading_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (_, state) {
          if (state.isLoading) {
            BlocProvider.of<CustomerBloc>(context).add(FetchCustomer());
            return LoadingWidget(size: size);
          } else {
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  state.loadingError.isNotEmpty
                      ? Container()
                      : CustomerInfoHeader(size: size),
                  state.loadingError.isNotEmpty
                      ? Text(state.loadingError)
                      : OfferList(
                          size: size,
                        ),
                ],
              ),
            ));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
