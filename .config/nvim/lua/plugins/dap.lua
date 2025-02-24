---------
-- DAP --
---------
return {
	-- 	"mfussenegger/nvim-dap",
	-- 	dependencies = {
	-- 		"David-Kunz/jester", -- Debugging Jest tests
	-- 		"theHamsta/nvim-dap-virtual-text", -- Show variable values in virtual text
	-- 		"mxsdev/nvim-dap-vscode-js", -- DAP adapter for vs**de-js-debug
	-- 		"williamboman/mason.nvim", -- Manage DAP adapters
	-- 		"jay-babu/mason-nvim-dap.nvim", -- Automatic DAP configuration
	-- 		"ofirgall/goto-breakpoints.nvim", -- Jump to next/previous breakpoint
	-- 		-- "nvim-telescope/telescope-dap.nvim", -- Telescope integration
	-- 		"ibhagwan/fzf-lua",
	-- 	},
	-- 	cmd = {
	-- 		"DapContinue",
	-- 		"DapDisconnect",
	-- 		"DapNew",
	-- 		"DapTerminate",
	-- 		"DapRestartFrame",
	-- 		"DapStepInto",
	-- 		"DapStepOut",
	-- 		"DapStepOver",
	-- 		"DapEval",
	-- 		"DapToggleRepl",
	-- 		"DapClearBreakpoints",
	-- 		"DapToggleBreakpoint",
	-- 		"DapSetLogLevel",
	-- 	},
	-- 	config = function()
	-- 		local dap = require("dap")
	-- 		local jester = require("jester")
	-- 		local mason_dap = require("mason-nvim-dap")
	-- 		local map = require("utils").map
	-- 		local fn, sign_define = vim.fn, vim.fn.sign_define
	-- 		local get_install_path = require("utils").get_install_path
	-- 		local breakpoint = require("goto-breakpoints")
	-- 		local fzf = require("fzf-lua")
	--
	-- 		sign_define("DapBreakpoint", { text = "", texthl = "Error" })
	-- 		sign_define("DapBreakpointCondition", { text = "לּ", texthl = "Error" })
	-- 		sign_define("DapLogPoint", { text = "", texthl = "Directory" })
	-- 		sign_define("DapStopped", { text = "ﰲ", texthl = "TSConstant" })
	-- 		sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })
	--
	-- 		-- Automatically set up installed DAP adapters
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		mason_dap.setup({ automatic_installation = true })
	--
	-- 		local function continue()
	-- 			-- Loads .vscode/launch.json files if available
	-- 			require("dap.ext.vscode").load_launchjs(nil, {
	-- 				["pwa-node"] = { "typescript" },
	-- 				["node"] = { "typescript" },
	-- 			})
	--
	-- 			dap.continue()
	-- 		end
	--
	-- 		-- Mappings --
	-- 		-- TODO: use stackmap.nvim to add ]s as "next step", or something similar
	-- 		map("n", "<leader>dB", function()
	-- 			vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
	-- 				dap.set_breakpoint(condition)
	-- 			end)
	-- 		end, "DAP set conditional breakpoint")
	-- 		map("n", "<leader>dc", continue, "DAP continue")
	-- 		map("n", "<leader>ds", dap.step_over, "DAP step over")
	-- 		map("n", "<leader>di", dap.step_into, "DAP step into")
	-- 		map("n", "<leader>do", dap.step_out, "DAP step out")
	-- 		map("n", "<leader>db", dap.toggle_breakpoint, "DAP toggle breakpoint")
	-- 		map("n", "<leader>dB", dap.clear_breakpoints, "DAP remove breakpoints")
	-- 		map("n", "<leader>dr", dap.repl.open, "DAP open REPL")
	-- 		map("n", "<leader>dl", dap.run_last, "DAP run last session")
	-- 		map("n", "<leader>dr", dap.restart, "DAP restart session")
	-- 		map("n", "<leader>dq", dap.terminate, "DAP terminate session")
	--
	-- 		-- Jester
	-- 		map("n", "<leader>djt", jester.debug, "DAP Jester debug test")
	-- 		map("n", "<leader>djf", jester.debug_file, "DAP Jester debug file")
	-- 		map("n", "<leader>djr", jester.debug_last, "DAP Jester rerun debug")
	-- 		map("n", "<leader>djT", jester.run, "DAP Jester run test")
	-- 		map("n", "<leader>djF", jester.run_file, "DAP Jester run file")
	-- 		map("n", "<leader>djR", jester.run_last, "DAP Jester rerun test")
	--
	-- 		-- Go to breakpoints
	-- 		map("n", "]b", breakpoint.next, "Go to next breakpoint")
	-- 		map("n", "[b", breakpoint.prev, "Go to previous breakpoint")
	--
	-- 		map("n", "<leader>td", fzf.dap_commands, "DAP commands")
	-- 		map("n", "<leader>tb", fzf.dap_breakpoints, "DAP breakpoints")
	-- 		map("n", "<leader>tv", fzf.dap_variables, "DAP variables")
	-- 		map("n", "<leader>tf", fzf.dap_frames, "DAP frames")
	--
	-- 		-- DAP virtual text --
	-- 		require("nvim-dap-virtual-text").setup()
	--
	-- 		-- TypeScript/JavaScript --
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		require("dap-vscode-js").setup({
	-- 			debugger_path = get_install_path("js-debug-adapter"),
	-- 			debugger_cmd = { "js-debug-adapter" },
	-- 			adapters = {
	-- 				"pwa-node",
	-- 				"pwa-chrome",
	-- 				"pwa-msedge",
	-- 				"node-terminal",
	-- 				"pwa-extensionHost",
	-- 				"node2",
	-- 			},
	-- 		})
	--
	-- 		-- Jester
	-- 		jester.setup({
	-- 			cmd = "yarn test -t '$result' -- $file", -- run command
	-- 			-- p
	-- 			-- dap = {
	-- 			-- 	type = "pwa-node",
	-- 			-- 	port = 9229,
	-- 			-- },
	-- 		})
	--
	-- 		for _, language in ipairs({ "typescript", "javascript" }) do
	-- 			dap.configurations[language] = {
	-- 				{
	-- 					name = "Debug Jest Unit Tests (default)",
	-- 					type = "pwa-node",
	-- 					request = "launch",
	-- 					runtimeArgs = {
	-- 						"./node_modules/jest/bin/jest.js",
	-- 						"--runInBand",
	-- 					},
	-- 					cwd = "${workspaceFolder}",
	-- 					console = "integratedTerminal",
	-- 					internalConsoleOptions = "neverOpen",
	-- 				},
	-- 				{
	-- 					name = "Attach to running process (default)",
	-- 					type = "pwa-node",
	-- 					request = "attach",
	-- 					processId = require("dap.utils").pick_process,
	-- 					cwd = "${workspaceFolder}",
	-- 				},
	-- 			}
	-- 		end
	--
	-- 		-- Loads .vscode/launch.json files if available
	-- 		require("dap.ext.vscode").load_launchjs(nil, {
	-- 			["pwa-node"] = { "typescript" },
	-- 			["node"] = { "typescript" },
	-- 		})
	-- 	end,
	-- }
	-- -- ---------
	-- -- -- DAP --
	-- -- ---------
	-- -- return {
	-- -- 	"mfussenegger/nvim-dap",
	-- -- 	dependencies = {
	-- -- 		"rcarriga/nvim-dap-ui",
	-- -- 		"mxsdev/nvim-dap-vscode-js",
	-- -- 		"David-Kunz/jester",
	-- -- 		-- build debugger from source
	-- -- 		{
	-- -- 			"microsoft/vscode-js-debug",
	-- -- 			version = "1.x",
	-- -- 			build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
	-- -- 		},
	-- -- 		"theHamsta/nvim-dap-virtual-text",
	-- -- 	},
	-- -- 	keys = {
	-- -- 		-- normal mode is default
	-- -- 		{
	-- -- 			"<leader>tb",
	-- -- 			function()
	-- -- 				require("dap").toggle_breakpoint()
	-- -- 			end,
	-- -- 			{ desc = "Toggle breakpoint" },
	-- -- 		},
	-- -- 		{
	-- -- 			"<leader>tbc",
	-- -- 			function()
	-- -- 				require("dap").continue()
	-- -- 			end,
	-- -- 			{ desc = "Continue" },
	-- -- 		},
	-- -- 		{
	-- -- 			"<leader>tso",
	-- -- 			function()
	-- -- 				require("dap").step_over()
	-- -- 			end,
	-- -- 			{ desc = "Step over" },
	-- -- 		},
	-- -- 		{
	-- -- 			"<leader>tsi",
	-- -- 			function()
	-- -- 				require("dap").step_into()
	-- -- 			end,
	-- -- 			{ desc = "Step into" },
	-- -- 		},
	-- -- 		{
	-- -- 			"<leader>tsx",
	-- -- 			function()
	-- -- 				require("dap").step_out()
	-- -- 			end,
	-- -- 			{ desc = "Step out" },
	-- -- 		},
	-- -- 	},
	-- -- 	config = function()
	-- -- 		require("dap-vscode-js").setup({
	-- -- 			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
	-- -- 			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
	-- -- 		})
	-- --
	-- -- 		require("nvim-dap-virtual-text").setup()
	-- -- 		-- Information for setting up configurations:  https://code.visualstudio.com/docs/nodejs/browser-debugging
	-- --
	-- -- 		for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
	-- -- 			require("dap").configurations[language] = {
	-- -- 				-- attach to a node process that has been started with
	-- -- 				-- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
	-- -- 				-- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
	-- -- 				{
	-- -- 					-- use nvim-dap-vscode-js's pwa-node debug adapter
	-- -- 					type = "pwa-node",
	-- -- 					-- attach to an already running node process with --inspect flag
	-- -- 					-- default port: 9222
	-- -- 					request = "attach",
	-- -- 					-- allows us to pick the process using a picker
	-- -- 					processId = require("dap.utils").pick_process,
	-- -- 					-- name of the debug action you have to select for this config
	-- -- 					name = "Attach debugger to existing `node --inspect` process",
	-- -- 					-- for compiled languages like TypeScript or Svelte.js
	-- -- 					sourceMaps = true,
	-- -- 					-- resolve source maps in nested locations while ignoring node_modules
	-- -- 					resolveSourceMapLocations = {
	-- -- 						"${workspaceFolder}/**",
	-- -- 						"!**/node_modules/**",
	-- -- 					},
	-- -- 					-- path to src in vite based projects (and most other projects as well)
	-- -- 					cwd = "${workspaceFolder}/src",
	-- -- 					-- we don't want to debug code inside node_modules, so skip it!
	-- -- 					skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
	-- -- 					port = 9222,
	-- -- 				},
	-- -- 				{
	-- -- 					type = "pwa-chrome",
	-- -- 					name = "Attach to Chrome (9222)",
	-- -- 					request = "attach",
	-- -- 					port = 9222,
	-- -- 					-- sourceMaps = true,
	-- -- 					-- protocol = 'inspector',
	-- -- 					-- resolveSourceMapLocations = {
	-- -- 					--   "${workspaceFolder}/**",
	-- -- 					--   "!**/node_modules/**" },
	-- -- 					-- -- path to src in vite based projects (and most other projects as well)
	-- -- 					-- cwd = "${workspaceFolder}/src",
	-- -- 					-- -- we don't want to debug code inside node_modules, so skip it!
	-- -- 					-- skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
	-- -- 				},
	-- -- 				{
	-- -- 					type = "pwa-chrome",
	-- -- 					name = "Launch Chrome to debug client",
	-- -- 					request = "launch",
	-- -- 					port = 9222,
	-- -- 					url = "http://localhost:3000",
	-- -- 					sourceMaps = true,
	-- -- 					protocol = "inspector",
	-- -- 					webRoot = "${workspaceFolder}/src",
	-- -- 					-- skip files from vite's hmr
	-- -- 					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
	-- -- 				},
	-- -- 				-- only if language is javascript, offer this debug action
	-- -- 				language == "javascript"
	-- -- 						and {
	-- -- 							-- use nvim-dap-vscode-js's pwa-node debug adapter
	-- -- 							type = "pwa-node",
	-- -- 							-- launch a new process to attach the debugger to
	-- -- 							request = "launch",
	-- -- 							-- name of the debug action you have to select for this config
	-- -- 							name = "Launch file in new node process",
	-- -- 							-- launch current file
	-- -- 							program = "${file}",
	-- -- 							cwd = "${workspaceFolder}",
	-- -- 						}
	-- -- 					or nil,
	-- -- 			}
	-- -- 		end
	-- --
	-- -- 		require("dapui").setup()
	-- -- 		local dap, dapui = require("dap"), require("dapui")
	-- -- 		dap.listeners.after.event_initialized["dapui_config"] = function()
	-- -- 			dapui.open({ reset = true })
	-- -- 		end
	-- -- 		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
	-- -- 		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	-- -- 	end,
}
