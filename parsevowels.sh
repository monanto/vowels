#!/bin/bash



function parseVowels() {
    FILE="$1"
    # bash Associative Array
    declare -A COUNT
    # Count Total number of words
    T_WORDS=$(wc -w "$FILE"|cut -d' ' -f1)
    #Number of words with length 4 or more -w word, -o print only match
    LENGTH=$(egrep -wio "[a-z,']{4,}" "$FILE"|wc -l)
    echo "The file contains $T_WORDS words, of which $LENGTH are four letter words or more in length. The vowel count for these $LENGTH are as follows:"
    while read WORD;do
        # Count number of vowels
        VOW=$(echo $WORD|grep -i -o '[aeiou]'|wc -l)
        # Skip words with Vowels more than 5
        if [[ $VOW -gt 5 ]];then
            continue
        fi
        # store in Array
        COUNT[$VOW]=${COUNT[$VOW]}" [$WORD]"
        # redirect output of #Number of words with length 4 or more to loop
    done <<< $(egrep -woi "[a-z,']{4,}" "$FILE")

    for (( i=0; i<${#COUNT[@]};i++)); do  
        # Number of words of certain length $i
        echo "$(wc -w <<< "${COUNT[$i]}") contains $i vowels, these being:"
        echo "${COUNT[$i]}"
    done

}

echo -n "Please enter a file name to parse: "
read FILENAME
# File dont exist check
if [[ ! -f "$FILENAME" ]];then
    echo "File $FILENAME not found"
    echo Quitting.......
    exit 1
fi
# Pass Filename to function parseVowels
parseVowels "$FILENAME"
exit 0



