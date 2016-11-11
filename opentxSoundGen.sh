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

soundFile=$1
lang=${2:-en}
voice=${3:-Samantha}
soundFileFormat="WAVE"
soundFileExtension="wav"

echo "will process $soundFile file (lang=$lang, voice=$voice) ..."

mkdir -p ./SOUNDS/$lang/SYSTEM

while read p; do
    IFS=$'\t'; arr=($p); unset IFS;
    path=./SOUNDS/$lang/${arr[0]}.$soundFileExtension
    echo "encoding text \"${arr[1]}\" as file $path ...\c"
    say -v $voice --file-format=$soundFileFormat --data-format=LEI16@32000 -o $path ${arr[1]}
    echo "DONE"
done <$soundFile