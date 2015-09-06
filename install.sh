copyall() {
    for file in *.cls; do
        cp $file $1
    done
    for file in *.sty; do
        cp $file $1
    done
}

if hash kpsepath 2>/dev/null; then
    paths=$(kpsepath tex | tr : '\n')
else
    paths="$HOME/Library/texmf"
fi

for path in $paths; do
    if [ "$path" != "." ] && [ -d $path ] && [ ${path:0:1} != "!" ]; then
        copyall $path
        echo "Installation successful at location $path"
        exit
    fi
done

echo "No previously existing possible installation paths."

for path in $paths; do
    if [ "$path" != "." ] && [ ${path:0:1} != "!" ]; then
        read -p "Create installation path $path [Y/n]?" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]] ; then
            mkdir -p $path
            copyall $path
            echo "Installation successful at location $path"
            exit
        fi
    fi
done

echo "Installation failed."
