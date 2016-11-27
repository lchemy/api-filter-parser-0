%%
"eq"                  { return "OP_FILTER"; }
"neq"                 { return "OP_FILTER"; }
"gt"                  { return "OP_FILTER"; }
"gte"                 { return "OP_FILTER"; }
"lt"                  { return "OP_FILTER"; }
"lte"                 { return "OP_FILTER"; }
"like"                { return "OP_FILTER"; }
"not like"            { return "OP_FILTER"; }

"in"                  { return "IN_FILTER"; }
"not in"              { return "IN_FILTER"; }
"between"             { return "BETWEEN_FILTER"; }
"not between"         { return "BETWEEN_FILTER"; }

"is null"             { return "NULL_FILTER"; }
"is not null"         { return "NULL_FILTER"; }

"exists"              { return "EXISTS_FILTER"; }
"not exists"          { return "EXISTS_FILTER"; }

"and"                 { return "GROUPING"; }
"or"                  { return "GROUPING"; }

"("                   { return "("; }
")"                   { return ")"; }

","                   { return ","; }

[+-]?\d+("."\d+)?([eE]\d+)?\b  { return "NUMBER"; }
([\"|\'])(?:[^\1\\]|\\.)*?\1   { return "STRING"; } /* " fix syntax highlighting :) */
[\w\.]+                        { return "FIELD"; }

\s+                   {/* skip whitespace */}

<<EOF>>               { return "EOF"; }
