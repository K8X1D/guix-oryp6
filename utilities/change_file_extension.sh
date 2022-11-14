# from https://unix.stackexchange.com/questions/19654/how-do-i-change-the-extension-of-multiple-files
# Rename all *.txt to *.text
for file in *.txt; do 
    mv -- "$file" "${file%.txt}.text"
done
