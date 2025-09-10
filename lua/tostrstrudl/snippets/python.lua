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







-- local default_values = {
-- 	int = "0",
-- 	bool = "False",
-- 	string = '""',
-- 	error = function(_, info)
-- 		if info then
-- 			info.index = info.index + 1
--
-- 			return c(info.index, {
-- 				t(info.err_name),
-- 			})
-- 		else
-- 			return t("err")
-- 		end
-- 	end,
-- 	list = "[]",
-- 	dict = "{}",
-- 	tuple = "()",
-- }
--
-- -- func_def
-- -- name
-- -- parameters
-- -- return_type
-- -- return_statement
-- local transform = function(text, info)
-- 	local condition_matches = function(condition, ...)
-- 		if type(condition) == "string" then
-- 			return condition == text
-- 		else
-- 			return condition(...)
-- 		end
-- 	end
--
-- 	for condition, result in pairs(default_values) do
-- 		if condition_matches(condition, text, info) then
-- 			if type(result) == "string" then
-- 				return t(result)
-- 			else
-- 				return result(text, info)
-- 			end
-- 		end
-- 	end
--
-- 	return t(text)
-- end
--
-- local handlers = {
-- 	parameter_list = function(node, info)
-- 		local result = {}
-- 		local count = node:named_child_count()
-- 		for idx = 0, count - 1 do
-- 			local matching_node = node:named_child(idx)
-- 			local type_node = matching_node:field("type")[1]
-- 			table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
-- 			if idx ~= count - 1 then
-- 				table.insert(result, t({ ", " }))
-- 			end
-- 		end
--
-- 		return result
-- 	end,
--
-- 	-- bool
-- 	type_identifier = function(node, info)
-- 		local text = vim.treesitter.get_node_text(node, 0)
-- 		return { transform(text, info) }
-- 	end,
-- }
--
-- local function result_type(info)
-- 	local function_node_types = {
-- 		func_def = true,
-- 		params = true,
-- 	}
--
-- 	local node = vim.treesitter.get_node()
-- 	while node ~= nil do
-- 		if function_node_types[node:type()] then
-- 			break
-- 		end
--
-- 		node = node:parent()
-- 	end
--
-- 	if not node then
-- 		vim.notify("Not inside of a function")
-- 		return t("")
-- 	end
--
-- 	local query = assert(vim.treesitter.query.get("python", "return-snippet"), "No query")
-- 	for _, capture in query:iter_captures(node, 0) do
-- 		if handlers[capture:type()] then
-- 			return handlers[capture:type()](capture, info)
-- 		end
-- 	end
-- end
--
-- local return_values = function(args)
-- 	return sn(
-- 		nil,
-- 		result_type({
-- 			index = 0,
-- 			func_args = args[1][1],
-- 			ret_type = args[2][1],
-- 		})
-- 	)
-- end

