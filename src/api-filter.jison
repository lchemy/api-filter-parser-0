/* description: Parses API filter string into JSON */

%left "OP_FILTER" "IN_FILTER" "BETWEEN_FILTER" "NULL_FILTER" "EXISTS_FILTER"
%left "GROUPING"


%start EXPRESSIONS
%%

EXPRESSIONS
  : EXPRESSION EOF
    { return $1; }
  ;

VALUE
  : NUMBER
    { $$ = Number($1); }
  | STRING
    { $$ = $1; }
  | FIELD
    { $$ = $1; }
  ;

IN_VALUE
  : VALUE
    { $$ = [$1]; }
  | IN_VALUE "," VALUE
    { $1.push($3); }
  ;

EXPRESSION
  : "(" EXPRESSION ")"
    {
      $$ = $2
    }
  | FIELD OP_FILTER VALUE
    {
      $$ = {
        field: $1,
        operator: $2,
        value: $3
      };
    }
  | FIELD NULL_FILTER
    {
      $$ = {
        field: $1,
        operator: $2
      };
    }
  | FIELD BETWEEN_FILTER VALUE "," VALUE
    {
      $$ = {
        field: $1,
        operator: $2,
        value: [
          $3,
          $5
        ]
      }
    }
  | FIELD IN_FILTER IN_VALUE
    {
      $$ = {
        field: $1,
        operator: $2,
        value: $3
      };
    }
  | FIELD EXISTS_FILTER "(" EXPRESSION ")"
    {
      $$ = {
        field: $1,
        operator: $2,
        value: $4
      };
    }
  | FIELD EXISTS_FILTER
    {
      $$ = {
        field: $1,
        operator: $2
      };
    }
  | EXPRESSION GROUPING EXPRESSION
    {
      let leftSameGroup = (typeof $1 === "object" && $1.grouping === $2),
        rightSameGroup = (typeof $3 === "object" && $3.grouping === $2);
      if (leftSameGroup && rightSameGroup) {
        $1.expressions.push.apply($1.expressions, $3.expressions);
        $$ = $1;
      } else if (leftSameGroup) {
        $1.expressions.push($3);
        $$ = $1;
      } else {
        $$ = {
          grouping: $2,
          expressions: [$1, $3]
        };
      }
    }
  ;
