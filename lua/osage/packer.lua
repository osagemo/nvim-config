-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim" -- Requirement for multiple plugins
    use "nvim-lua/popup.nvim" -- Requirement for multiple plugins
    use "folke/tokyonight.nvim"
    use "lewis6991/gitsigns.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    -- use { 'nvim-telescope/telescope-fzf-native.nvim',
    --     run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use "dinhhuy258/git.nvim" -- For git blame & browse
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/nvim-cmp"
    use "jose-elias-alvarez/null-ls.nvim"
    use "onsails/lspkind-nvim" -- vscode-like pictograms
    -- use "glepnir/lspsaga.nvim" -- LSP UIs
    use "terrortylor/nvim-comment"
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"
    use("saadparwaiz1/cmp_luasnip")
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use("romgrk/nvim-treesitter-context")
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use "windwp/nvim-ts-autotag"
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use "ThePrimeagen/harpoon"
    use "github/copilot.vim"
end)
