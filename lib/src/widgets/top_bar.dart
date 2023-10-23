import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 196, 197, 197),
                  width: 1.0,
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.density_medium_rounded,
                  color: Color(0xFF3B45F5),
                ),
              ),
            ),
            Text(
              DateFormat("EEEEE, d 'de' MMMM").format(DateTime.now()),
              style: TextStyle(
                color: Color(0xFFC5C4C4),
                fontFamily: 'MontSerrat',
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromARGB(255, 196, 197, 197),
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: Color(0xFF3B45F5),
                    )))
          ],
        ),
      ),
    );
  }
}
