for path in $(kpsepath tex | tr : '\n'); do
    if [ "$path" != "." ] && [ -d $path ] && [ ${path:0:1} != "!" ]; then
        for file in *.cls; do
            cp $file $path
        done
        for file in *.sty; do
            cp $file $path
        done
        echo "Installation successful at location $path"
        exit
    fi
done

echo "No previously existing possible installation paths."

for path in $(kpsepath tex | tr : '\n'); do
    if [ "$path" != "." ] && [ ${path:0:1} != "!" ]; then
        read -p "Create installation path $path [Y/n]?" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]] ; then
            mkdir -p $path
            for file in *.cls; do
                cp $file $path
            done
            for file in *.sty; do
                cp $file $path
            done
            echo "Installation successful at location $path"
            exit
        fi
    fi
done

echo "Installation failed."