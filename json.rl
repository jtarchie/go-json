package main

import "fmt"

%%{
  machine json;

  exp     = ("e" | "e+" | "e-" | "E" | "E+" | "E-") digit+;
  frac    = "." digit+;
  nonzero = "1".."9";
  integer = "-"? (digit+ | nonzero digit+);
  number  = integer (frac | exp | frac exp);
  control = "\\" ( '"' | "\\" | '/' | 'b' | 'f' | 'n' | 'r' | 't' | 'u' xdigit{4});
  chars   = (any -- ('"' | "\\")) | control;
  string  = '"' chars* '"';
  boolean = "true" | "false";
  value   = string | number | boolean | null;
  array   = "[" value* "]";
  pair    = string ":" value;
  members = pair ("," pair )*;
  object  = "{" members* "}";

  main := object;
}%%

%% write data;

var parseErr = fmt.Errorf("parse error")

func Parse(data []byte) error {
  cs, p, pe := 0, 0, len(data)

  %% write init;
  %% write exec;

  if cs < json_first_final {
    return parseErr
  }

  return nil
}

func main() {
  fmt.Printf("err: %s", Parse([]byte(`{"a":"a"}`)))
}
