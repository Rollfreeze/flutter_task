import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
	final String buttonText;
	final bool isActiveNow;
	final pressedCB;
	
	var fontSize;

	FilterButton({
		Key? key,
		required this.buttonText,
		required this.isActiveNow,
		required this.pressedCB,
		this.fontSize = 16,
	}) : super(key: key);

  @override
  _FilterButtonState createState() => _FilterButtonState();	
}

class _FilterButtonState extends State<FilterButton> {
	TextStyle buttonTextStyleActive = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w400,
		fontSize: 16,
		color: Colors.white,
	);

	TextStyle buttonTextStyleNormal = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w400,
		fontSize: 16,
		color: Colors.black,
	);

	TextStyle buttonTextStylePrimary = const TextStyle(
		fontFamily: 'Roboto',
		fontWeight: FontWeight.w400,
		fontSize: 21,
		color: Colors.white,
	);

	@override
	Widget build(BuildContext context) {
		return Padding(
		  padding: const EdgeInsets.only(right: 8.0),
		  child: OutlinedButton(
		  	style: OutlinedButton.styleFrom(
					shape: const StadiumBorder(),
		  		backgroundColor: (widget.isActiveNow) ? const Color.fromRGBO(116, 109, 247, 1) : const Color.fromRGBO(237, 237, 237, 1),
		  		side:  BorderSide(
		  			width: 1, 
		  			color: (widget.isActiveNow) ? const Color.fromRGBO(116, 109, 247, 1) : const Color.fromRGBO(237, 237, 237, 1),
		  		),
		  		
		  	),
		  	child: Text(widget.buttonText, style: (widget.isActiveNow) ? buttonTextStyleActive : buttonTextStyleNormal),
		  	onPressed: () => widget.pressedCB(),
		  ),
		);
	}
}