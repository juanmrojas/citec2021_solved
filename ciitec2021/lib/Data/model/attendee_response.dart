import 'dart:convert';

import 'package:ciitec2021/Data/model/visitor_model.dart';

List<AtendeeModel> toAttendeeListFromJson(String response) =>
    List<AtendeeModel>.from(
        json.decode(response).map((x) => AtendeeModel.fromJson(x)));

String toJsonFromAttendeeList(List<AtendeeModel> attendeeList) =>
    json.encode(attendeeList);
