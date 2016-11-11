# Taranis Sound Generator for OpenTX

supported os : macOS

FrSky Taranis and Taranis Plus RC remote systems running OpenTX supports sound customisation. 

http://www.frsky-rc.com/product/pro.php?pro_id=137

Basically you can download sounds packs from http://www.open-tx.org/downloads for instance and use them on your remote for various settings or system events.

OpenTX provides utilities for generating various sounds ("Voice Recorder" and "Voice Generator" utilities) but those only run on MS Windows system.

The "Taranis sound generator" is a simple script relying on MacOS text to speech "say" utility. 

It's goal is to generate a complete sound pack from a text file containing output file names and text to be spoken.

Author & Contact : \<alex at ledrone dot club>

website : https://ledrone.club

## OpenTX sound directory structure

OpenTX sound files are to be found on the SD Card under the /SOUNDS directory. The directory structure is as follows :

```
/SOUNDS/$lang/...
/SOUNDS/$lang/SYSTEM/...
```

```$lang``` is the OpenTX language, usually 'en' for 'English'.

```/SOUNDS/$lang/``` contains various sounds especially custom ones.

```/SOUNDS/$lang/SYSTEM/``` contains the system sounds (boot sound, numbers, units, etc.).

## Taranis Sound Generator

This small script take à list of "sound path" "text to be pronounced" from the sounds_file.txt :

```
...
SYSTEM/eebad	bad eeprom
SYSTEM/endtrim	trim maximum
SYSTEM/inactiv	inactivity alarm
SYSTEM/lowbatt	low battery
SYSTEM/midtrim	trim center
SYSTEM/rssi_org	rssi low
SYSTEM/rssi_red	rssi critical
SYSTEM/rx_org	receiver battery low
SYSTEM/rx_red	receiver battery critical
SYSTEM/swalert	switch warning
SYSTEM/swr_red	radio antenna defective
...
```

field separator is tab (\t character).

I provide a sample sounds_file.txt, you are totally free to create your own or to improove the provided one.

It iterates trough the list and creates the .wav files accordingly and saves them in the correct directory structure in order to make them ready to use on your Taranis remote.


## Usage

Create an empty directory.

Put the ```taranisSoundGen.sh``` script and ```sounds_list.txt``` in this directory.

Make sure that the ```say```system utility is available on your system.

Edit the script in order to change the ```lang``` and ```voice``` variable in order to match your system and needs.

It is setup by default to run on my macOS and create sound files in english using the 'Samantha' voice (lang=en, voice=Samantha).

Run the script :

```
$ chmod +x taranisSoundGen.sh
$ ./taranisSoundGen.sh
```

NB : the quality of the audio file produced can be tweaked in the script by changing the ```--data-format=LEI16@32000```. (which reads as Little Endian, Integer 16 bit @ 32000 Hz).

while running, the script produces the following output :

```
[...]
encoding text "aileron high" as file ./SOUNDS/en/ailhgh.wav ...DONE
encoding text "aileron medium" as file ./SOUNDS/en/ailmed.wav ...DONE
encoding text "aileron low" as file ./SOUNDS/en/aillow.wav ...DONE
encoding text "rudder coupled to ailerons" as file ./SOUNDS/en/rudcail.wav ...DONE
encoding text "ailerons mixted with rudder" as file ./SOUNDS/en/ail2rud.wav ...DONE
encoding text "elevator mixed with flaperons" as file ./SOUNDS/en/ele2flr.wav ...DONE
encoding text "elevator mixed with flaps" as file ./SOUNDS/en/ele2flp.wav ...DONE
encoding text "Knife Edge" as file ./SOUNDS/en/knfedge.wav ...DONE
encoding text "Knife Edge Mix" as file ./SOUNDS/en/knfedgm.wav ...DONE
encoding text "Flaperons" as file ./SOUNDS/en/flaprns.wav ...DONE
encoding text "time up" as file ./SOUNDS/en/timup.wav ...DONE
encoding text "time is up" as file ./SOUNDS/en/timisup.wav ...DONE
encoding text "... mixed with ..." as file ./SOUNDS/en/mxdwth.wav ...DONE
encoding text "... coupled with ..." as file ./SOUNDS/en/cpldwth.wav ...DONE
encoding text "...mix" as file ./SOUNDS/en/mix.wav ...DONE
encoding text "switch" as file ./SOUNDS/en/switch.wav ...DONE
[...]
```

You can then upload the content of the ./SOUNDS directory on your Taranis remote in order to use the freshly generated sounds.

## References 

 * [man say (macOS)](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/say.1.html)
 * [macOS supported audio file formats](https://developer.apple.com/library/content/documentation/MusicAudio/Conceptual/CoreAudioOverview/SupportedAudioFormatsMacOSX/SupportedAudioFormatsMacOSX.html)
 * [Open-TX](http://www.open-tx.org)
 * [Waveform Audio File Format (WAVE/WAV), wikipedia](https://en.wikipedia.org/wiki/WAV)
 
 



