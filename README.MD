# dotConfig for nvim
This configuration was created in parallel on windows/linux machines

### Todos
- [ ] Further modifications of CMP to aid better with Reaact component props
- [ ] Experiment with debuggers

Install (not tested since rewriting):
1. (Windows) Install mingw `choco install mingw` 
2. (Install cmake and fzf for telescope-fzf-native)
3. Install packer: https://github.com/wbthomason/packer.nvim
       :so packer.lua if Packer commands don't work on first run
4. Install language servers:
5.     sudo npm install -g typescript typescript-language-server
       sudo npm install -g @tailwindcss/language-server
       sudo npm install -g @astrojs/language-server
       sudo npm install -g @fsouza/prettierd
       sudo npm i -g vscode-langservers-extracted
5. Install a patched font: https://www.nerdfonts.com/font-downloads
6. Start nvim, run :PackerSync and :TSUpdate

For multiple configs, use a script like:
```bash
#!/bin/sh
exec env NVIM_APPNAME=nvim-old nvim "$@"
```
