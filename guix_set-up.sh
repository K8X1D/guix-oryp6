GUIX_CONFIG_DIR="$HOME/.config/guix" 

if [ -d $GUIX_CONFIG_DIR ] 
then
    echo "Directory $GUIX_CONFIG_DIR exists." 
else
    mkdir $GUIX_CONFIG_DIR
    echo "Directory $GUIX_CONFIG_DIR created." 
fi


ln -s $PWD/channels.scm $GUIX_CONFIG_DIR
ln -s $PWD/gtransform.scm $GUIX_CONFIG_DIR
ln -s $PWD/guix-config $GUIX_CONFIG_DIR
ln -s $PWD/manifests $GUIX_CONFIG_DIR
ln -s $PWD/oryp6.scm $GUIX_CONFIG_DIR
ln -s $PWD/signing-key.pub $GUIX_CONFIG_DIR
echo "Guix configuration was deployed." 

