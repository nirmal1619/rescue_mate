
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:project_final_year/bluetooth_operation.dart';
import 'package:project_final_year/provider/blue_details_provider.dart';
import 'package:provider/provider.dart';

class NeumorphismWidget extends StatefulWidget {
  final String assetPath;
  final double height;
  // final VoidCallback ? onTap;
  final IconData? icon;
  final bool isBlue;
  final String action;
  final Color color;
  final String type;

  const NeumorphismWidget({
    required this.assetPath,
    required this.height,
    required this.icon,
    required this.isBlue,
    required this.action,
    required this.color,
    required this.type,
    // this.onTap,
  });

  @override
  State<NeumorphismWidget> createState() => _NeumorphismWidgetState();
}

class _NeumorphismWidgetState extends State<NeumorphismWidget> {

  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    BlueDetailsProvider blueDetailsProvider =
    Provider.of<BlueDetailsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Consumer<BlueDetailsProvider>(
        builder: (context, Bluedetails, child) => Column(
          children: [
            Container(
              width: 170,
              height: 230,
              child: Stack(
                children: [
                  widget.type=="bluetooth" || widget.type=="person" ? Padding(
                    padding: const EdgeInsets.only(top: 40,left: 16),
                    child: Image.asset(
                      widget.assetPath,
                      height: widget.height,
                       color: blueDetailsProvider.isBlueOn ? Colors.redAccent : Colors.black,
                      alignment: Alignment.center,
                    ),
                  ):Image.asset(
                    widget.assetPath,
                    height: widget.height+60,
                    alignment: Alignment.center,
                  ),
                  if (widget.icon != null)
                    widget.isBlue == false
                        ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(


                          widget.icon,
                          color: widget.color,

                      ),
                    )
                        : Positioned(
                      bottom: 0,
                      right: 0,
                      child: Switch(
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.black,

                        value: _isSwitched,
                        onChanged: (value) async {
                          setState(() {
                            _isSwitched = value;
                          });
                          if (value) {
                            BluetoothOperation.turnOnBlue(
                                blueDetailsProvider, context);
                          } else {

                            BluetoothOperation. turnOffBlue(
                              blueDetailsProvider,context


                            );
                          }
                        },
                        thumbColor:
                        MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.grey.shade200;
                            }
                            Colors.redAccent;
                          },
                        ),
                        trackColor:
                        MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.red;
                            }
                            return Colors.white;
                          },
                        ),
                      ),
                    ),
                  Positioned(child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.action),
                  )),
                  widget.type=="helmet" || widget.type=="bike" ?
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: widget.type=="helmet"?  Icon(
                            CupertinoIcons.bluetooth,
                          color:blueDetailsProvider.isConnectedTohelmet ? Colors.redAccent :Colors.black38 ,
                        )  :
                         Icon(
                           CupertinoIcons.bluetooth,
                          color:blueDetailsProvider.isConnectedTobike ? Colors.redAccent :Colors.black38 ,
                        )

                      ) : Text(""),

                ],
              ),
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
                bottom: 5,
                left: 0,
              ),
              decoration: decoration(),
            ),
          ],
        ),
      ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(-5, -5),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.grey.shade600,
          offset: const Offset(5, 5),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }

}
