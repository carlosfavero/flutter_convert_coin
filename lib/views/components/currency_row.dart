import 'package:convertCoin/models/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyRow extends StatelessWidget {

  final List<CurrencyModel> items;
  final CurrencyModel selectedItem;   
  final TextEditingController controller;
  final void Function(CurrencyModel) onChanged;
  final bool enabled;
  final String prefix;
  final String sufix;
  const CurrencyRow({Key key, this.items, this.controller, this.onChanged, this.selectedItem, this.enabled, this.prefix, this.sufix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,          
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.amber, style: BorderStyle.solid, width: 0.80),
            ),
            child:DropdownButton<CurrencyModel>(
              iconEnabledColor: Colors.amber,
              iconSize: 40,
              isExpanded: true,
              style: TextStyle(                
                fontSize: 18,
              ),
              underline: Container(
                height: 0,
                color: Colors.amber,
              ),
              value: selectedItem,
              items: items.map((e) => DropdownMenuItem(value: e, child:Text(e.name))).toList(),
              onChanged: onChanged
            ),
          ),
        ),
        SizedBox( width: 10,),
        Expanded(
          flex: 3,          
          child: SizedBox(
            child: TextField(
              cursorColor: Colors.amber,
              style: TextStyle(
                fontSize: 20,
              ),
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              enabled: enabled,
              decoration: InputDecoration(
                suffix: Text(
                  sufix,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                prefix: Text(prefix,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.amber, 
                    width: 1.0,                    
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.amber, 
                    width: 1.0,                    
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.amber, 
                    width: 1.0,                    
                  ),
                ),
                
              ),
            ),
          ),
        ),
      ],
    );
  }
}
