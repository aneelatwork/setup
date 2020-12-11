md ~\AppData\Local\nvim\autoload 
(New-Object Net.WebClient).DownloadFile(
  'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
     "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

md c:\space\work\src\env
cd c:\space\work\src\env
git clone https://github.com/aneelatwork/setup.git
cd setup/dotfiles
cat init.vim | sed 's!__nvim_plugin_path__!~/AppData/Local/nvim/plugged|g' > '~\AppData\Local\nvim\init.vim'
nvim +PlugInstall "+CocInstall coc-clangd" "+CocInstall coc-pyright" +qall

cd ~
git config --global user.email 'aneelatwork@gmail.com'
git config --global user.name 'Aneel Rathore'

