local boole_ok, boole = pcall(require, "boole")
if not boole_ok then
	return
end

boole.setup({
	mappings = {
		increment = "<C-x>",
		decrement = "<C-z>",
	},
})