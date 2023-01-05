# dotConfig for nvim
This configuration was created in parallel on windows/linux machines

### Todos
- [ ] Refactor folder/file structure
- [ ] Add automatic management of language servers via e.g. mason
- [ ] Further modifications of CMP to aid better with Reaact component props
- [ ] Experiment with debuggers

Install
1. (Windows) Install mingw `choco install mingw` 
2. (Install cmake and fzf for telescope-fzf-native)
3. Install packer: https://github.com/wbthomason/packer.nvim
4. Install language servers:
5.     sudo npm install -g typescript typescript-language-server
       sudo npm install -g @tailwindcss/language-server
       sudo npm install -g @astrojs/language-server
       sudo npm install -g @fsouza/prettierd
       sudo npm i -g vscode-langservers-extracted
5. Install a patched font: https://www.nerdfonts.com/font-downloads
6. Start nvim, run :PackerSync and :TSUpdate

