#!/bin/bash
# MIT License
#
# Copyright (c) 2016 Alexandre Arvinte
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

usage() { 
    cat <<EOM
    Usage: 
    $(basename $0) [-l lang] [-v voice] [-p processor <say|mplayer>] [-h help] my_sounds_file.txt
EOM
    exit 1 
}

get_binary()
{
    if [ -n "$p" ]; then
        if ! which "$p"; then
            return 1
        fi
        local binary=$(which "$p")
    else
        for e in say mplayer; do
            if ! which "$e"; then
                continue
            fi
            local binary=$(which "$e")
            break
        done
        if [ -z "$binary" ]; then
            return 1
        fi
    fi
}


while getopts ":l:v:p:" o; do
    case "${o}" in
        l)
            l=${OPTARG}
            ;;
        v)
            v=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            [ "$p" == "say" ] || [ $p == "mplayer" ] || usage            
            ;;    
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# check if sounds file is provided
[ -z $1 ] && { usage; }

soundFileFormat="WAVE"
soundFileExtension="wav"
soundFile=$1
lang=${l:-en}

# create the sound directory arborescence
mkdir -p ./SOUNDS/$lang/SYSTEM

#test if say or mplayer is available
binary=$(get_binary)
if [ $? -ne 0 ];then
    cat <<EOM
    
    Could not find any WAV processor.
    
    On macOS, the default processor is "say" (try -v say option).
    
    On Linux/Unix : "mplayer" package must be installed.
    
EOM
    usage
fi    
processor=$(basename $binary)

case $processor in
say)
    voice=${v:-Samantha}
    echo "[say] will process $soundFile file (lang=$lang, voice=$voice) ..."
    ;;
mplayer)
    echo "[mplayer] will process $soundFile file (lang=$lang, voice=default) ..."
    ;;
*)
    echo "dunno what to do with myself"
    exit 0
    ;;
esac

# processing
while read p; do
    IFS=$'\t'; arr=($p); unset IFS;
    if [ -z ${arr[0]} ]; then continue; fi
    path=./SOUNDS/$lang/${arr[0]}.$soundFileExtension
        
    case $processor in
    say)    
        echo -n "encoding text \"${arr[1]}\" as file $path ..."
        $binary -v $voice --file-format=$soundFileFormat --data-format=LEI16@32000 -o $path ${arr[1]}
        ;;
    mplayer)
        echo -n "encoding text \"${arr[1]}\" as file $path ..."
        google_query="http://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=${arr[1]// /+}&tl=En-us"
        $binary -ao pcm:waveheader:file=$path -really-quiet -noconsolecontrols -af format=s16le -srate 32000 $google_query
        ;;
    *)
        exit 1
        ;;
    esac
    echo "DONE"
done <$soundFile