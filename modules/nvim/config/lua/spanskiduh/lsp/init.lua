-- Check for lsp-zero
local ok, lsp_zero = pcall(require, 'lsp-zero')
if not ok then return end

-- Extend lspconfig with lsp-zero's functionalities
lsp_zero.extend_lspconfig()

-- Default on_attach function
lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    if client.name == "eslint" then
        vim.cmd [[ LspStop eslint ]]
        return
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'rust_analyzer'},
    handlers = {
        lsp_zero.default_setup,
        -- Additional custom configurations for servers can be added here
    },
})

-- Set up nvim-cmp for completion
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- Remove completion with Tab to help with copilot setup
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
}
cmp.setup({
    mapping = cmp_mappings,
    sources = {
        { name = 'nvim_lsp' },
    },
})

vim.diagnostic.config({
    virtual_text = true,
})

lsp_zero.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
