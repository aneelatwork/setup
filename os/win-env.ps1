﻿#MIT License
#
#Copyright (c) 2019 aneelatwork
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

md ~\AppData\Local\nvim\autoload 
(New-Object Net.WebClient).DownloadFile(
  'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
     "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

set raks_work_root 'C:\space\work'
setx RAKS_WORK_ROOT "$raks_work_root"

set raks_src_env "${Env:RAKS_WORK_ROOT}\src\env"
md "$raks_src_env"
cd "$raks_src_env"

git clone https://github.com/aneelatwork/setup.git
cd setup/coding
cat init.vim | sed 's!__nvim_plugin_path__!~/AppData/Local/nvim/plugged|g' > '~\AppData\Local\nvim\init.vim'
nvim +PlugInstall "+CocInstall coc-clangd" "+CocInstall coc-pyright" +qall
cd ../make

set raks_bld_env "${raks_work_root}\build\env\setup"
md "$raks_bld_env"
cd "$raks_bld_env"


cmake "$raks_src_env\setup\make" -DCMAKE_INSTALL_PREFIX="$raks_work_root"
cmake --build . --config Release
cmake --install .

set old_path $( reg query HKEY_CURRENT_USER\Environment /v Path | select-object -skip 2 -first 1 | %{ $_.split( " ",[StringSplitOptions]"RemoveEmptyEntries" )[2] } )
setx Path "${old_path}%RAKS_WORK_ROOT%\bin;"

cd ~
git config --global user.email 'aneelatwork@gmail.com'
git config --global user.name 'Aneel Rathore'


