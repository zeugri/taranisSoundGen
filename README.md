# Taranis Sound Generator for OpenTX

FrSky Taranis and Taranis Plus RC remote systems running OpenTX supports sound customisation. 

http://www.frsky-rc.com/product/pro.php?pro_id=137

Basically you can download sounds packs from http://www.open-tx.org/downloads for instance and use them on your remote for various settings or system events.

OpenTX provides utilities for generating various sounds ("Voice Recorder" and "Voice Generator" utilities) but those only run on MS Windows system.

The "Taranis ound Generator" is a simple script relying on unix/linux text to speech "say" utility. 

It's goal is to generate a complete sound pack from a text file containing output file names and text to be spoken.

Author & Contact : \<alex at ledrone dot club>

website : https://ledrone.club

## OpenTX sound directory structure

OpenTX sound files are to be found on the SD Card under the /SOUND directory. The directory structure is as follows :

```
/SOUNDS/$lang/...
/SOUNDS/$lang/SYSTEM/...
```

```lang``` is the OpenTX language, usually 'en' for 'English'.

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

You can then upload the content of the ./SOUND directory on your Taranis remote in order to use the freshly generated sounds.

## References 

 * man say
 * http://www.open-tx.org
 
 



