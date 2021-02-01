import 'package:convertCoin/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyRow extends StatelessWidget {

  final List<CurrencyModel> items;
  final CurrencyModel selectedItem; 
  final TextEditingController controller;
  final void Function(CurrencyModel) onChanged;
  const CurrencyRow({Key key, this.items, this.controller, this.onChanged, this.selectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: DropdownButton<CurrencyModel>(
                iconEnabledColor: Colors.amber,
                iconSize: 42,
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.amber,
                ),
                value: selectedItem,
                items: items
                  .map((e) => DropdownMenuItem(value: e, child:Text(e.name)))
                  .toList(),
                onChanged: onChanged
              ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
