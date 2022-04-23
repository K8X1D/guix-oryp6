GUIX_CONFIG_DIR="$HOME/.config/guix" 
SHEPHERD_CONFIG_DIR="$HOME/.config/shepherd" 

if [ -d $GUIX_CONFIG_DIR ] 
then
    echo "Directory $GUIX_CONFIG_DIR exists." 
else
    mkdir $GUIX_CONFIG_DIR
    echo "Directory $GUIX_CONFIG_DIR created." 
fi


if [ -d $SHEPHERD_CONFIG_DIR/init.d ] 
then
    echo "Directory $SHEPHERD_CONFIG_DIR/init.d exists." 
else
    mkdir -p $SHEPHERD_CONFIG_DIR/init.d
    echo "Directory $SHEPHERD_CONFIG_DIR/init.d created." 
fi


ln -s $PWD/manifests $GUIX_CONFIG_DIR
ln -s $PWD/utilities $GUIX_CONFIG_DIR
ln -s $PWD/oryp6.org $GUIX_CONFIG_DIR
emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "~/.config/guix/oryp6.org")'

echo "Guix configuration was deployed." 

