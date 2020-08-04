import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cell extends StatefulWidget {
  final index;
  final solverBrain;
  final ValueNotifier<List<List<int>>> boardNotifier;
  Cell({this.index, this.solverBrain, this.boardNotifier});

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  var controller = TextEditingController();
  bool isFocused = false;
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus == false) controller.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: ValueListenableBuilder(
          valueListenable: widget.boardNotifier,
          builder: (BuildContext context, List<List<int>> board, Widget child) {
            return TextField(
              maxLines: 1,
              focusNode: _focusNode,
              showCursor: false,
              textAlignVertical: TextAlignVertical.bottom,
              controller: controller,
              onSubmitted: (text) {
                setState(() {
                  widget.solverBrain
                      .assignValue(index: widget.index, val: int.parse(text));
                  controller.clear();
                });
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 8.0),
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: board[widget.index ~/ 9][widget.index % 9] != 0
                    ? board[widget.index ~/ 9][widget.index % 9].toString()
                    : null,
                hintStyle: TextStyle(
                  fontFamily: 'coolvetica',
                  color: Colors.black87,
                  fontSize: 22.0,
                ),
                counter: Offstage(),
              ),
              maxLength: 1,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontFamily: 'coolvetica',
                fontSize: 22.0,
                color: Colors.red,
              ),
            );
          }),
    );
  }
}
