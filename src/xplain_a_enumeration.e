note

	description:

		"Xplain string enumerations"

	author:     "Berend de Boer <berend@pobox.com>"

class

	XPLAIN_A_ENUMERATION


inherit

	XPLAIN_A_DOMAIN_RESTRICTION
		rename
			make as make_xplain_domain_restriction
		redefine
			check_attachment
		end

	XPLAIN_ENUMERATION [XPLAIN_A_NODE]
		redefine
			first
		end

	KL_SHARED_STANDARD_FILES
		export
			{NONE} all
		end


create

	make


feature

	make (afirst: XPLAIN_A_NODE)
		do
			make_xplain_domain_restriction (True)
			first := afirst
		end

feature -- Access

	first: XPLAIN_A_NODE


feature

	sqldomainconstraint (sqlgenerator: SQL_GENERATOR; column_name: STRING): STRING
			-- return SQL search condition something like
			-- "check value in ('a','b','c')"
		do
			result := sqlgenerator.sqlcheck_in (first, column_name)
		end

feature

	check_attachment (sqlgenerator: SQL_GENERATOR; a_representation: XPLAIN_REPRESENTATION)
			-- Print warning if a value in enumeration does not fit in max
			-- base type length.
		local
			node: detachable XPLAIN_A_NODE
			maxlength: INTEGER
		do
			if attached {XPLAIN_A_REPRESENTATION} a_representation as representation then
				maxlength := representation.length
				from
					node := first
				until
					node = Void
				loop
					if node.item /= Void and then node.item.count > maxlength then
						std.error.put_string ("string in enumeration exceeds representation length.%N")
						std.error.put_string ("string is: ")
						std.error.put_string (node.to_sqlcode (sqlgenerator))
						std.error.put_string (" (length: ")
						std.error.put_string (node.item.count.out)
						std.error.put_string (")%N")
						std.error.put_string ("max length is: ")
						std.error.put_integer (maxlength)
						std.error.put_string ("%N")
					end
					node := node.next
				end
			else
				std.error.put_string ("A enumeration not attached to A domain.%N")
			end
		end

end
