return {
  "Pocco81/auto-save.nvim",
  event = { "InsertEnter" },
  config = function()
    require("auto-save").setup({
      enabled = true,

      trigger_events = { "InsertLeave", "TextChanged" },

      debounce_delay = 800,

      execution_message = {
        enabled = false,
      },

      condition = function(buf)
        if vim.bo[buf].buftype ~= "" then
          return false
        end
        return vim.bo[buf].modifiable
      end,
    })
  end,
}
