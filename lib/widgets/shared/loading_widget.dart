import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nuconta_marketplace/Utilities/Constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.primaryPurple,
      child: Center(
        child: SizedBox(
            height: size.height * 0.07,
            width: size.width * 0.15,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOutRapid,
              color: Colors.white,
            )),
      ),
    );
  }
}
