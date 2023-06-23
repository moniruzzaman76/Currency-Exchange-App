import 'package:currency_exchange/model_class/currency_model.dart';
import 'package:flutter/material.dart';

class AllCurrencyListItem extends StatelessWidget {
  final CurrencyModel currencyModel;

  const AllCurrencyListItem({Key? key, required this.currencyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withAlpha(80),
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(currencyModel.code??"",style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),),

          Text(currencyModel.value.toString(),
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),),
        ],
      ),
    );
  }
}
