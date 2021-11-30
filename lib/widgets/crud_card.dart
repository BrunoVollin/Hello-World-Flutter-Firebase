import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CrudCard extends StatelessWidget {
  const CrudCard({
    Key? key,
    required this.time,
    required this.text,
  }) : super(key: key);

  final String time;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const  BoxConstraints(
                  minHeight: 45,
                  // maxHeight: 200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 200,
                      ),
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        softWrap: false,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.black38),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    // width: 20,
                    height: 25,
                    child: IconButton(               
                      iconSize: 20,
                      padding: new EdgeInsets.all(0.0),
                      icon: const Icon(Icons.edit),
                      color: Colors.orange,
                      onPressed: () {
                        print("scscsac");
                      },
                    ),
                  ),
                  Container(
                    // width: 20,
                    height: 25,
                    child: IconButton(               
                      iconSize: 20,
                      padding: new EdgeInsets.all(0.0),
                      icon: const Icon(Icons.delete_forever),
                      color: Colors.red,
                      onPressed: () {
                        print("scscsac");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
