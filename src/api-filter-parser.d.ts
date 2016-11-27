export declare class Parser {
	parse(input: string): FilterExpression;
}

export interface ParseErrorHash {
	text: string;
	token: any;
	line: number;
	loc?: number;
	expected?: string;
	recoverable?: boolean;
}

export interface ParseError extends Error {
	message: string;
	hash: ParseErrorHash;
}

export interface EqualExpression {
	field: string;
	operator: "eq",
	value: (number | string);
}
export interface NotEqualExpression {
	field: string;
	operator: "neq",
	value: (number | string);
}
export interface GreaterThanExpression {
	field: string;
	operator: "gt",
	value: (number | string);
}
export interface GreaterThanOrEqualExpression {
	field: string;
	operator: "gte",
	value: (number | string);
}
export interface LessThanExpression {
	field: string;
	operator: "lt",
	value: (number | string);
}
export interface LessThanOrEqualExpression {
	field: string;
	operator: "lte",
	value: (number | string);
}
export interface LikeExpression {
	field: string;
	operator: "like",
	value: string;
}
export interface NotLikeExpression {
	field: string;
	operator: "not like",
	value: string;
}

export interface InExpression {
	field: string;
	operator: "in",
	value: (number | string)[]
}
export interface NotInExpression {
	field: string;
	operator: "not in",
	value: (number | string)[]
}
export interface BetweenExpression {
	field: string;
	operator: "between",
	value: [number | string, number | string]
}
export interface NotBetweenExpression {
	field: string;
	operator: "not between",
	value: [number | string, number | string]
}

export interface IsNullExpression {
	field: string;
	operator: "is null"
}
export interface IsNotNullExpression {
	field: string;
	operator: "is not null"
}

export interface ExistsExpression {
	field: string;
	operator: "exists";
	value?: FilterExpression;
}
export interface NotExistsExpression {
	field: string;
	operator: "not exists";
	value?: FilterExpression;
}

export interface AndExpression {
	grouping: "and";
	expressions: FilterExpression[];
}
export interface OrExpression {
	grouping: "or";
	expressions: FilterExpression[];
}

export declare type OperatorExpression = EqualExpression | NotEqualExpression | GreaterThanExpression | GreaterThanOrEqualExpression |
	LessThanExpression | LessThanOrEqualExpression | LikeExpression | NotLikeExpression | InExpression | NotInExpression | BetweenExpression |
	NotBetweenExpression | IsNullExpression | IsNotNullExpression | ExistsExpression | NotExistsExpression;
export declare type GroupExpression = AndExpression | OrExpression;
export declare type FilterExpression = OperatorExpression | GroupExpression;
