GUIX_CONFIG_DIR="$HOME/.config/guix" 

if [ -d $GUIX_CONFIG_DIR ] 
then
    echo "Directory $GUIX_CONFIG_DIR exists." 
else
    mkdir $GUIX_CONFIG_DIR
    echo "Directory $GUIX_CONFIG_DIR created." 
fi


ln -s $PWD/manifests $GUIX_CONFIG_DIR
ln -s $PWD/utilities $GUIX_CONFIG_DIR
ln -s $PWD/oryp6.org $GUIX_CONFIG_DIR
emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.config/guix/oryp6.org")'

echo "Guix configuration was deployed." 

