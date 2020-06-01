import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dt>(
      create: (context) => Dt(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: MyText(),
          ),
          body: Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Level2());
  }
}

class Level2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  //keep watching and update
  @override
  Widget build(BuildContext context) {
    return Text(context.watch<Dt>().data);
  }
}

class MyText extends StatefulWidget {
  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  String str;
  //v4 style of read once and not listen again
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    str = context.read<Dt>().data;
  }

  @override
  Widget build(BuildContext context) {
    //old v3 method
    //return Text(Provider.of<Dt>(context, listen: false).data);
    return Text(str);
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newText) {
        context.read<Dt>().changeString(newText);
      },
    );
  }
}

class Dt extends ChangeNotifier {
  String data = 'test02';
  void changeString(String newString) {
    data = newString;
    notifyListeners();
  }
  //testing read once, and not listening again
  String originalValue() => data;
}
