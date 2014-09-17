#!/bin/sh

#The MIT License (MIT)
#
#Copyright (c) 2014 Fábio C. Barrionuevo da Luz
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





# obtem o diretorio atual
dot_files_dir=~/.dotfiles

# define o nome do diretorio de backup
backup_dir_name="BACKUP_"`date +%Y%m%d-%H%M%S`

# caminho do diretorio de backup
backup_dir=$dot_files_dir/$backup_dir_name

echo ""
echo "Dotfiles dir: $dot_files_dir"
echo "Backup directory: $backup_dir"

# entra no diretorio dos dotfiles, para poder proceguir a execucao
cd $dot_files_dir


# expressao regular para selecionar os arquivos NAO serao linkados
# coloque aqui o que voce NAO quer que seja incluido na linkagem
RE="^(\.git|setup\.sh|README\.md|LICENSE)$|^BACKUP_."


files=`ls -cA1 | grep -Ev "$RE"`


for file_name in $files; do
    echo ""
    current_file_orig=$dot_files_dir/$file_name
    current_file_dest=~/$file_name
    if [ -e "$current_file_dest" ] || [ -d "$current_file_dest" ]; then
        echo "$file_name already exists on your home directory. Performing backup copy"
        if [ ! -d $backup_dir ]; then
           mkdir -p $backup_dir
        fi
        cp -rp $current_file_dest $backup_dir
    fi
    echo "linking: "`ln -sfv $current_file_orig $current_file_dest`
done

