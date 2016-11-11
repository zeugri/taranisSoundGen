#!/bin/sh

lang="en"
voice="Samantha"

soundFileFormat="WAVE"
soundFileExtension="wav"

mkdir -p ./SOUND/$lang/SYSTEM

while read p; do
    IFS=$'\t'; arr=($p); unset IFS;
    say -v $voice --file-format=$soundFileFormat --data-format=LEF32@32000 -o ./SOUND/$lang/${arr[0]}.$soundFileExtension --progress ${arr[1]}
done <sounds_list.txt
