import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
	final String buttonText;
	final pressedCB;
	
	const PrimaryButton({
		Key? key,
		required this.buttonText,
		required this.pressedCB,
	}) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();	
}

class _PrimaryButtonState extends State<PrimaryButton> {
	TextStyle primaryButtonTextStyle = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w700,
		fontSize: 21,
		color: Colors.white,
	);

	@override
	Widget build(BuildContext context) {
		return OutlinedButton(
			style: OutlinedButton.styleFrom(
					shape: const StadiumBorder(),
				backgroundColor: const Color.fromRGBO(116, 109, 247, 1),
				side: const BorderSide(
					width: 1, 
					color: Color.fromRGBO(116, 109, 247, 1)
				),
				
			),
			child: Padding(
			  padding: const EdgeInsets.symmetric(horizontal: 82.0, vertical: 15.0),
			  child: Text(widget.buttonText, style: primaryButtonTextStyle),
			),
			onPressed: () => widget.pressedCB(),
		);
	}
}