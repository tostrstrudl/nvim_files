return {
	s(
		{
			trig = "temp",
			descr = "Barebones C Template",
		},
		fmt(
			[[
            #include <stdio.h>
            #include <stdlib.h>

            {} main({}){{
                {}
            }}{}
            ]],
			{ i(1, "int"), i(2, "void"), i(3), i(0) }
		)
	),

	s(
		{
			trig = "e",
			descr = "Enum Filler",
		},
		fmt(
			[[
            typedef enum {{
                {}
            }} {}
            ]],
			{ i(1), i(0) }
		)
	),

	s(
		{
			trig = "f",
			descr = "Function Filler",
		},
		fmt(
			[[
            {} {}({}) {{
                {}
            }}{}
            ]],
			{ i(1), i(2), i(3), i(4), i(0) }
		)
	),
}
