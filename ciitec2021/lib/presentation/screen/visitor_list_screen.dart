import 'package:ciitec2021/Domain/entity/Visitor.dart';
import 'package:ciitec2021/presentation/bloc/event/attendee_list_event.dart';
import 'package:ciitec2021/presentation/bloc/state/attendee_list_state.dart';
import 'package:ciitec2021/presentation/bloc/attendee_list_bloc.dart';
import 'package:ciitec2021/presentation/di/di_module.dart';
import 'package:ciitec2021/presentation/screen/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendeeListScreen extends StatefulWidget {
  @override
  _AttendeeListScreenState createState() => _AttendeeListScreenState();
}

class _AttendeeListScreenState extends State<AttendeeListScreen> {
  AttendeeListBloc _attendeeListBloc;

  @override
  void initState() {
    _attendeeListBloc = builder<AttendeeListBloc>();
    _attendeeListBloc.add(AttendeeListInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _attendeeListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider<AttendeeListBloc>(
        create: (context) => _attendeeListBloc,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  Container(
                    color: Colors.green,
                    height: SizeConfig.screenHeight,
                  ),
                  Positioned(
                    top: 120.0,
                    left: 20.0,
                    child: Text(
                      'Attendee List CIITEC 2021',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: SizeConfig.screenHeight * 0.75,
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.safeBlockHorizontal * 6,
                        SizeConfig.safeBlockVertical * 3,
                        SizeConfig.safeBlockHorizontal * 6,
                        SizeConfig.safeBlockVertical * 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [_body()],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _body() {
    return Flexible(
      fit: FlexFit.tight,
      child: BlocBuilder<AttendeeListBloc, AttendeeListState>(
        builder: (context, state) {
          List<Atendee> visitorList = List.empty();
          if (state is AttendeeListInitState) {
            visitorList = state.visitorList;
            return _list(context, visitorList);
          }
          return _list(context, visitorList);
        },
      ),
    );
  }

  Widget _list(BuildContext context, List<Atendee> visitorList) {
    return Container(
        child: ListView.builder(
      itemCount: visitorList.length,
      itemBuilder: (context, index) {
        Atendee visitor = visitorList[index];
        return Container(
          margin: EdgeInsets.only(top: 5.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            children: [Expanded(child: _getAttendeeRowView(visitor))],
          ),
        );
      },
    ));
  }

  Widget _getAttendeeRowView(Atendee atendee) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${atendee.name} ${atendee.lastName}',
            maxLines: 2,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
