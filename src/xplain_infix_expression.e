note

	description: "Use for infix expressions, with 2 operands"
	author:     "Berend de Boer <berend@pobox.com>"
	copyright:  "Copyright (c) 1999, Berend de Boer"

class

	XPLAIN_INFIX_EXPRESSION


inherit

	XPLAIN_TWO_OPERANDS_FUNCTION
		rename
			make as make_two_operands,
			name as operator
		redefine
			representation,
			sqlvalue_as_wildcard
		end


create

	make


feature {NONE} -- Initialization

	make (
			a_left: XPLAIN_EXPRESSION
			a_operator: STRING
			a_right: XPLAIN_EXPRESSION)
			-- Initialize.
		require
			valid_left: a_left /= Void
			valid_right: a_right /= Void
			operator_not_empty: a_operator /= Void and then not a_operator.is_empty
		do
			make_two_operands (a_left, a_right)
			operator := a_operator
		end


feature -- Access

	operator: STRING
			-- The Xplain operator


feature -- SQL code

	representation (sqlgenerator: SQL_GENERATOR): XPLAIN_REPRESENTATION
			-- Tried to come up with some rules of thumb to make sure we
			-- generate the correct type.
		local
			leftr,
			rightr: XPLAIN_REPRESENTATION
		do
			if operator ~ "/" then
				Result := sqlgenerator.value_representation_float
			else
				leftr := left.representation (sqlgenerator)
				if attached {XPLAIN_I_REPRESENTATION} leftr then
					rightr := right.representation (sqlgenerator)
					if not attached {XPLAIN_I_REPRESENTATION} rightr then
						Result := rightr
					else
						Result := leftr
					end
				else
					Result := leftr
				end
			end
		end

	sqloperator: STRING
			-- The SQL translation for `operator'
		do
			Result := operator
		ensure
			sql_operator_not_empty: Result /= Void and then not Result.is_empty
		end

	sqlinitvalue (sqlgenerator: SQL_GENERATOR_WITH_TRIGGERS): STRING
			-- Expression in sql syntax used in init statements. Equal to
			-- `sqlvalue' in many cases, but usually if you refer to
			-- attributes of the type it has to be prefixed by "new." for
			-- example.
		do
			Result := sqlgenerator.sql_init_infix_expression (left, operator, right)
		end

	sqlvalue (sqlgenerator: SQL_GENERATOR): STRING
			-- Value as SQL expression
		do
			Result := sqlgenerator.sql_infix_expression (left, operator, right)
		end

	sqlvalue_as_wildcard (sqlgenerator: SQL_GENERATOR): STRING
			-- As `sqlvalue', but a string literal uses this to return a
			-- properly formatted SQL like expression
		do
			Result := sqlgenerator.sql_infix_expression_as_wildcard (left, operator, right)
		end


end
