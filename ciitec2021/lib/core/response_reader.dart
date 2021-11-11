import 'dart:io';

String responseReader(String name) =>
    File('test/response/$name').readAsStringSync();
