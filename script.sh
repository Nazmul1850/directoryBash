#!/bin/bash
cdFunction(){
    cd "$1"
}
readFile(){
    len=0 
    while read line; 
    do 
        echo " Line $((len+1)) : $line "
        array[$len]=$line
        len=$((len+1)) 
    done < $1 
}
print()
{
    for ((i = 1;i < $1;i = i + 1))
    do
        echo -ne '|  '
    done
        echo '|--'$2
}
directory_tree(){
    cd "$1"
    for f in *
    do
        if [ -d "$f" ]; then
            x=$(expr $2 + 1)
            echo "Directory $f"
            #print $2 "$f"
            directory_tree "$f" $x
        elif [ -f "$f" ]; then
            #print $2 "$f"
            extension=(${f//./ })
            for i in "${array[@]}"
            do
                y="${extension[1]}"
                echo "$i"
                echo -ne "(y-->$y)"
                if [[ "$i" == "$y" ]]; then
                #if [[ $x = $y ]]; then
                    echo "ignoring $f"
                elif [[ $x != $y ]]; then
                    echo "($f --> $y)"
                fi
            done
        fi
    done
    cd ../
}

    if (($# == 2));then
        root=$1
        cdFunction $1
        filename=$2
    elif (($# == 1));then
        root="/media/nazmul"
        cdFunction $root
        filename=$1
    else
        echo "no input function"
    fi
    echo "$root and $filename"
    readFile $filename
    directory_tree $root 1
exec bash