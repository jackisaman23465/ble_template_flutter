import 'package:flutter/material.dart';
import 'DataLoading.dart';

class FutureData<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T?) child;
  final Widget? loading;
  final Widget Function(String?)? error;
  final bool rebuild;

  const FutureData({Key? key,
    required this.future,
    required this.child,
    this.loading,
    this.error,
    this.rebuild = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FutureDataState<T>();
}

class FutureDataState<T> extends State<FutureData<T>>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case(ConnectionState.waiting): return (widget.loading ?? const DataLoading());
          default:
            if(snapshot.hasError) {
              return (widget.error !=null) ? widget.error!("error") : Container();
            } else {
              if (snapshot.data is T){
                return widget.child(snapshot.data);
              } else {
                return widget.child(null);
              }
            }
        }
      }
    );
  }
}