import 'package:flutter/material.dart';

import '../palatte.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}

class Room1 extends StatelessWidget {
  const Room1({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/third');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}

class Room2 extends StatelessWidget {
  const Room2({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/third');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}


class Room3 extends StatelessWidget {
  const Room3({
    Key key,
    @required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/third');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            buttonText,
            style: kBodyText,
          ),
        ),
      ),
    );
  }
}

