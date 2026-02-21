local init = vim.schedule_wrap(function()
  if Snacks and pcall(require, "snacks.picker") then
    -- Users can call Snacks.picker.fff() after this
    Snacks.picker.sources.fff = require("fff-snacks.find_files").source
  end
end)

if vim.v.vim_did_enter == 1 then
  init()
else
  vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("fff-snacks.init", {}),
    once = true,
    nested = true,
    callback = init,
  })
end

vim.api.nvim_create_user_command("FFFSnacks", function()
  if Snacks and pcall(require, "snacks.picker") then
    Snacks.picker(require("fff-snacks.find_files").source)
  else
    vim.notify("fff-sncaks: Snacks is not loaded", vim.log.levels.ERROR)
  end
end, {
  desc = "Open FFF in snacks picker",
})
