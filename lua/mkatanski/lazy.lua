local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "mkatanski.plugins" }, { import = "mkatanski.plugins.lsp" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

-- Flag to control the execution of the autocommand
vim.g.run_autocommand = vim.g.run_autocommand or false

-- Autocommand to run a command after all plugins are loaded
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.g.run_autocommand then
			-- Wait until LSPs are ready
			vim.defer_fn(function()
				vim.cmd("SessionRestore")
			end, 100) -- Adjust the delay as necessary (in milliseconds)
		end
	end,
})
