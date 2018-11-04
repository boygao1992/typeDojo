exports.showChar = function ( c ) {
  var code = c.charCodeAt( 0 );
  if ( code < 0x20 || code === 0x7F ) {
    switch ( c ) {
      case "\x07":
        return "\\a";
      case "\b":
        return "\\b";
      case "\f":
        return "\\f";
      case "\n":
        return "\\n";
      case "\r":
        return "\\r";
      case "\t":
        return "\\t";
      case "\v":
        return "\\v";
    }
    return code.toString( 10 );
  }
  return c;
};
