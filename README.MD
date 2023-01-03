# dotConfig for nvim
This configuration was created on a windows machine.

### Todos
- [ ] Refactor folder/file structure
- [ ] Add automatic management of language servers via e.g. mason
- [ ] Further modifications of CMP to aid better with component props
- [ ] Fix telescope browse files, not cooperating well with git bash on windows
- [ ] Experiment with debuggers

Install
1. (Windows) Install mingw `choco install mingw`
2. Install packer: https://github.com/wbthomason/packer.nvim
3. Install language servers:
   `sudo npm install -g typescript typescript-language-server`
   `sudo npm install -g @tailwindcss/language-server`
   `sudo npm install -g @astrojs/language-server`
   `sudo npm install -g @fsouza/prettierd`
4. Install a patched font: https://www.nerdfonts.com/font-downloads
5. Start nvim, run :PackerSync and :TSUpdate

