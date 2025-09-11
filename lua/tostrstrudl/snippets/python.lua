require("luasnip.session.snippet_collection").clear_snippets("python")
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node


ls.add_snippets("python", {
    s(
        "f",
        fmt(
            [[
            def {}({}) -> {}:
                {}
                {}

            {}
            ]],
            {
                i(1),
                i(2),
                i(3, ""),
                i(4, "# meat and potatoes here, please"),
                i(5),
                i(0),
            }
        )
    ),

    s(
        "t",
        fmt(
            [[
            try:
                {}
            except {}:
                {}

            {}
            ]],
            {
                i(1),
                c(2, {
                    t("FloatingPointError"),
                    t("OverflowError"),
                    t("ZeroDivisionError"),
                    t("ModuleNotFoundError"),
                    t("IndexError"),
                    t("KeyError"),
                    t("UnboundLocalError"),
                    t("BrokenPipeError"),
                    t("ConnectionAbortedError"),
                    t("ConnectionRefusedError"),
                    t("ConnectionResetError"),
                    t("FileExistsError"),
                    t("FileNotFoundError"),
                    t("InterruptedError"),
                    t("IsADirectoryError"),
                    t("NotADirectoryError"),
                    t("PermissionError"),
                    t("ProccessLookupError"),
                    t("TimeoutError"),
                    t("ReferenceError"),
                    t("NotImplementedError"),
                    t("PythonFinalizationError"),
                    t("RecursionError"),
                    t("TabError"),
                    t("SystemError"),
                    t("TypeError"),
                    t("ValueError"),
                    t("Warning"),
                    t(""),
                }),
                i(3),
                i(0),
            }
        )
    ),
})

