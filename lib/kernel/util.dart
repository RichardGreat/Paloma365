R nvl<R>(R? a, R b) {
  return a ?? b;
}

String nvlString(String? a, String b) {
  return a ?? b;
}

int? nvlTryInt(Object value) {
  if (value is String)
    return value.isNotEmpty ? int.tryParse(value) : null;
  else if (value is int)
    return value;
  else
    return null;
}

num? nvlTryNum(Object value) {
  if (value is String) {
    return value.isNotEmpty ? num.tryParse(value) : null;
  } else if (value is num)
    return value;
  else if (value is int)
    return value;
  else if (value is double)
    return value;
  else
    return null;
}
