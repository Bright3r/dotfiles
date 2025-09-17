return {
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()

			-- Custom keymaps for toggling comments
			vim.keymap.set("n", "<leader>/", function()
				MiniComment.toggle_lines(vim.fn.line("v"), vim.fn.line("."))
			end, { desc = "Toggle comment (MiniComment)" })

			vim.keymap.set("v", "<leader>/", function()
				MiniComment.toggle_lines(vim.fn.line("v"), vim.fn.line("."))
			end, { desc = "Toggle comment (visual, MiniComment)" })
		end,
	},
}
