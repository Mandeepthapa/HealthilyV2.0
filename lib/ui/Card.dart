import 'package:flutter/material.dart';
import 'package:healthily_v2/card_data.dart';
import 'package:healthily_v2/ui/VideoPlayer.dart';

class Card1 extends StatelessWidget {
  final CardViewModel viewModel;
  // final double parallaxPercent;

  Card1({
    this.viewModel,
    // this.parallaxPercent=0.0,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //BackGround
          new ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              // child: FractionalTranslation(
              //   translation: Offset(parallaxPercent*2, 0.0),
              //   child: OverflowBox(
              //     maxWidth: double.infinity,
              child: Image.asset(viewModel.backdropAssetPath, fit: BoxFit.cover)
              //  )
              ),
          //  ),
          //Content
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: new Text(viewModel.address,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontFamily: "WorkSansSemiBold",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0)),
              ),
              Expanded(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(viewModel.text,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSansMedium",
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic)),
                    )
                  ],
                ),
              )),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: Colors.white, width: 1.5),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPlayer()));
                          },
                          child: Text(
                            viewModel.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSansSemiBold",
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
