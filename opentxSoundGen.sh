#!/bin/sh
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
    $(basename $0) my_sounds_file.txt [lang] [voice] 
EOM
    exit 0
}

[ -z $1 ] && { usage; }

which say > /dev/null
if [ $? -eq 0 ]; then
    system=macos
else
    system=linux
fi

soundFileFormat="WAVE"
soundFileExtension="wav"
soundFile=$1
lang=${2:-en}
mkdir -p ./SOUNDS/$lang/SYSTEM

case $system in
macos)
    voice=${3:-Samantha}
    echo "[macOS] will process $soundFile file (lang=$lang, voice=$voice) ..."

    while read p; do
        IFS=$'\t'; arr=($p); unset IFS;
        path=./SOUNDS/$lang/${arr[0]}.$soundFileExtension
        echo "encoding text \"${arr[1]}\" as file $path ...\c"
        say -v $voice --file-format=$soundFileFormat --data-format=LEI16@32000 -o $path ${arr[1]}
        echo "DONE"
    done <$soundFile
    ;;
linux)
    echo "[GNU/Linux] will process $soundFile file (lang=$lang, voice=default) ..."
	mplayer=`which mplayer 2>&1`
   	
    while read p; do
        IFS=$'\t'; arr=($p); unset IFS;
        path=./SOUNDS/$lang/${arr[0]}.$soundFileExtension
        echo "encoding text \"${arr[1]}\" as file $path ...\c"
        google_query="http://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&q=${arr[1]// /+}&tl=En-us"
		$mplayer -ao pcm:waveheader:file=$path -really-quiet -noconsolecontrols -af format=s16le -srate 32000 $google_query
        echo "DONE"
    done <$soundFile 
	;;
*)
    echo "dunno what to do with myself"
    ;;
esac
