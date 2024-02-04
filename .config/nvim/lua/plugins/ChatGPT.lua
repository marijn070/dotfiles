return {
  "jackMort/ChatGPT.nvim",
    cmd = "ChatGPT",
    config = function()
      require("chatgpt").setup({
          api_key_cmd = "op read op://Personal/OpenAI_API/credential --no-newline",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
}
