import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Creates the Cupertino-style search bar.
class CupertinoSearchBar extends AnimatedWidget {
	CupertinoSearchBar({
		Key key,
		@required Animation<double> animation,
		@required this.controller,
		@required this.focusNode,
		this.onCancel,
		this.onClear,
		this.onSubmit,
		this.onUpdate,
	})  : assert(controller != null),
				assert(focusNode != null),
				super(key: key, listenable: animation);

	/// The text editing controller to control the search field
	final TextEditingController controller;

	/// The focus node needed to manually unfocus on clear/cancel
	final FocusNode focusNode;

	/// The function to call when the "Cancel" button is pressed
	final Function onCancel;

	/// The function to call when the "Clear" button is pressed
	final Function onClear;

	/// The function to call when the text is updated
	final Function(String) onUpdate;

	/// The function to call when the text field is submitted
	final Function(String) onSubmit;

	static final _opacityTween = Tween(begin: 1.0, end: 0.0);
	static final _paddingTween = Tween(begin: 0.0, end: 60.0);
	static final _kFontSize = 16.0;

	@override
	Widget build(BuildContext context) {
		final Animation<double> animation = listenable;
		return Padding(
			padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
			child: Row(
				children: <Widget>[
					Expanded(
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
							decoration: BoxDecoration(
								color: Color.fromRGBO(233, 233, 233, 1.0),
								border:
								Border.all(width: 0.0, color: Color.fromRGBO(233, 233, 233, 1.0),),
								borderRadius: BorderRadius.circular(10.0),
							),
							child: Stack(
								alignment: Alignment.centerLeft,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											Padding(
												padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
												child: Icon(
													Icons.search,
													color: CupertinoColors.inactiveGray,
													size: _kFontSize + 4.0,
												),
											),
											Text(
												'Cari',
												style: TextStyle(
													inherit: false,
													color: CupertinoColors.inactiveGray
															.withOpacity(_opacityTween.evaluate(animation)),
													fontSize: _kFontSize,
												),
											),
										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.end,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Expanded(
												child: Padding(
													padding: const EdgeInsets.only(left: 24.0),
													child: EditableText(
														controller: controller,
														textInputAction: TextInputAction.search,
														focusNode: focusNode,
														onChanged: onUpdate,
														onSubmitted: onSubmit,
														style: TextStyle(
															color: CupertinoColors.black,
															inherit: false,
															fontSize: _kFontSize,
														),
														cursorColor: CupertinoColors.black,
														backgroundCursorColor: CupertinoColors.inactiveGray,
													),
												),
											),
											CupertinoButton(
												minSize: 10.0,
												padding: const EdgeInsets.all(1.0),
												borderRadius: BorderRadius.circular(30.0),
												color: CupertinoColors.inactiveGray.withOpacity(
													1.0 - _opacityTween.evaluate(animation),
												),
												child: Icon(
													Icons.close,
													size: 8.0,
													color: Colors.white,
												),
												onPressed: () {
													if (animation.isDismissed)
														return;
													else
														onClear();
												},
											),
										],
									),
								],
							),
						),
					),
					SizedBox(
						width: _paddingTween.evaluate(animation),
						child: CupertinoButton(
							padding: const EdgeInsets.only(left: 8.0),
							onPressed: onCancel,
							child: Text(
								'Cancel',
								softWrap: false,
								style: TextStyle(
									inherit: false,
									color: CupertinoColors.inactiveGray,
									fontSize: _kFontSize,
								),
							),
						),
					),
				],
			),
		);
	}
}