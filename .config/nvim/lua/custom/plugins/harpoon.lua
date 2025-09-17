return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Harpoon Setup (DO NOT REMOVE)
			local harpoon = require("harpoon")
			harpoon:setup()

			-- Key Bindings
			vim.keymap.set("n", "<leader>hm", function()
				harpoon:list():add()
			end, { desc = "[H]arpoon [M]ark Buffer" })

			vim.keymap.set("n", "<leader>hq", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "[H]arpoon [Q]uick Menu" })

			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end, { desc = "[H]arpoon [1]" })

			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end, { desc = "[H]arpoon [2]" })

			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end, { desc = "[H]arpoon [3]" })

			vim.keymap.set("n", "<leader>h4", function()
				harpoon:list():select(4)
			end, { desc = "[H]arpoon [4]" })

			vim.keymap.set("n", "<leader>h5", function()
				harpoon:list():select(5)
			end, { desc = "[H]arpoon [5]" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end, { desc = "[H]arpoon [P]revious Buffer" })

			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end, { desc = "[H]arpoon [N]ext Buffer" })

			-- Basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>ho", function()
				toggle_telescope(harpoon:list())
			end, { desc = "[H]arpoon [O]pen Window" })
		end,
	},
}
