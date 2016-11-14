# Taranis Sound Generator for OpenTX

A shell script sound pack generator for OpenTX. This script works on macOS and GNU/Linux and *nix systems.

```
    Usage:
    opentxSoundGen.sh [-l lang] [-v voice] [-p processor <say|mplayer>] [-h help] my_sounds_file.txt
    

	-l lang : corresponds to the OpenTX firmware language (en, fr, etc.)
	
	-v voice : macOS only, corresponds to the 'say' voice to be used. see at the bottom of this document
	
	-p processor <say|mplayer> : the processor used to create the wav files.
								 By default, on macOS the 'say' utility will
								 be used. You can optionally (mandatory on 
								 linux/unix) install mplayer.
```

## Documentation


[FrSky Taranis and Taranis Plus](http://www.frsky-rc.com/product/pro.php?pro_id=137) RC remote systems running OpenTX supports sound customisation. 

Basically you can download sounds packs from http://www.open-tx.org/downloads for instance and use them on your remote for various settings or system events.

OpenTX provides utilities for generating various sounds ("Voice Recorder" and "Voice Generator" utilities) but those only run on MS Windows systems.

The "Taranis Sound Generator" is a simple bash script. Despite its name you can use this script for any RC remote running OpenTX and supporting sound speech. Maybe need to tweak audio format to adapt your hardware.

It's purpose is to generate a complete sound pack from a text file containing output file names and text to be spoken.

Author & Contact : \<alex at ledrone dot club>

website : https://ledrone.club


## Requirements

### macOS

No requirements, the ```opentxSoundGen.sh``` script will use the system command ```say``` to produce the sound files.

Optionnally you can install mplayer (via brew or macports for instance) and use the ```-p processor``` option in order to get sounds produced via Google tts / mplayer. 

### Linux / Unix

You need to install ```mplayer``` in order to make the  ```opentxSoundGen.sh``` script able to produce the sound files.

You also need Internet access as the text to speech processing relies on the Google Translate Text To Speech "API".


### OpenTX sound directory structure

OpenTX sound files are to be found on the SD Card under the /SOUNDS directory. The directory structure is as follows :

```
/SOUNDS/$lang/...
/SOUNDS/$lang/SYSTEM/...
```

```$lang``` is the OpenTX language, usually 'en' for 'English'.

```/SOUNDS/$lang/``` contains various sounds especially custom ones.

```/SOUNDS/$lang/SYSTEM/``` contains the system sounds (boot sound, numbers, units, etc.).

### The sounds file

The script takes as an argument, a text file containing the output sound file name and the text to be spoken. The line format is :

```
[output file name without extension] [tab] [text to be spoken]\n
```

As an example here is a snippet of files going to the SYSTEM folder :

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

Field separator is \t (tab). The file name doesn't need to contain the .wav extension as it is appended automatically by the script.

I provide here a sample sounds_file.txt initially taken from the ['taranis siri sound pack' by dale3h](https://github.com/dale3h/taranis-siri-sound-pack).

You are totally free to create your own or to improve the provided one.

the opentxSoundGen.sh script iterates trough the list in sounds_list.txt and creates the .wav files accordingly, saves them in the correct directory structure in order to make them ready to use on your Taranis remote.


### Usage of the opentxSoundGen.sh script

Create an empty directory.

Put the ```opentxSoundGen.sh``` script and ```sounds_list.txt``` in this directory.

Make sure that the ```say```system utility is available on your system.

Run the script :

```
$ chmod +x opentxSoundGen.sh
$ ./opentxSoundGen.sh sounds_list.txt
```

optionally you can specify ```-l lang```, ```-v voice``` and ```-p processor``` parameters to the script in order to match your system and needs.

By default : 

 * On macOS (say) : The script will use lang=en and voice=Samantha.
 * On linux / unix (mplayer) : The script will use lang=en and voice will be the default EN-us from google translate_tts api. (TODO : make it changeable)


Please see at the bottom of this README file the list of voices/languages supported by say in macOS.

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
 * [RPi Text to speech](http://elinux.org/RPi_Text_to_Speech_(Speech_Synthesis\))
 * [macOS supported audio file formats](https://developer.apple.com/library/content/documentation/MusicAudio/Conceptual/CoreAudioOverview/SupportedAudioFormatsMacOSX/SupportedAudioFormatsMacOSX.html)
 * [Open-TX](http://www.open-tx.org)
 * [Waveform Audio File Format (WAVE/WAV), wikipedia](https://en.wikipedia.org/wiki/WAV)
 
## List of voices / languages supported in macOS 10.12 Sierra

```
Alex                en_US    # Most people recognize me by my voice.
Alice               it_IT    # Salve, mi chiamo Alice e sono una voce italiana.
Alva                sv_SE    # Hej, jag heter Alva. Jag är en svensk röst.
Amelie              fr_CA    # Bonjour, je m’appelle Amelie. Je suis une voix canadienne.
Anna                de_DE    # Hallo, ich heiße Anna und ich bin eine deutsche Stimme.
Carmit              he_IL    # שלום. קוראים לי כרמית, ואני קול בשפה העברית.
Damayanti           id_ID    # Halo, nama saya Damayanti. Saya berbahasa Indonesia.
Daniel              en_GB    # Hello, my name is Daniel. I am a British-English voice.
Diego               es_AR    # Hola, me llamo Diego y soy una voz española.
Ellen               nl_BE    # Hallo, mijn naam is Ellen. Ik ben een Belgische stem.
Fiona               en-scotland # Hello, my name is Fiona. I am a Scottish-English voice.
Fred                en_US    # I sure like being inside this fancy computer
Ioana               ro_RO    # Bună, mă cheamă Ioana . Sunt o voce românească.
Joana               pt_PT    # Olá, chamo-me Joana e dou voz ao português falado em Portugal.
Jorge               es_ES    # Hola, me llamo Jorge y soy una voz española.
Juan                es_MX    # Hola, me llamo Juan y soy una voz mexicana.
Kanya               th_TH    # สวัสดีค่ะ ดิฉันชื่อKanya
Karen               en_AU    # Hello, my name is Karen. I am an Australian-English voice.
Kyoko               ja_JP    # こんにちは、私の名前はKyokoです。日本語の音声をお届けします。
Laura               sk_SK    # Ahoj. Volám sa Laura . Som hlas v slovenskom jazyku.
Lekha               hi_IN    # नमस्कार, मेरा नाम लेखा है.Lekha मै हिंदी मे बोलने वाली आवाज़ हूँ.
Luca                it_IT    # Salve, mi chiamo Luca e sono una voce italiana.
Luciana             pt_BR    # Olá, o meu nome é Luciana e a minha voz corresponde ao português que é falado no Brasil
Maged               ar_SA    # مرحبًا اسمي Maged. أنا عربي من السعودية.
Mariska             hu_HU    # Üdvözlöm! Mariska vagyok. Én vagyok a magyar hang.
Mei-Jia             zh_TW    # 您好，我叫美佳。我說國語。
Melina              el_GR    # Γεια σας, ονομάζομαι Melina. Είμαι μια ελληνική φωνή.
Milena              ru_RU    # Здравствуйте, меня зовут Milena. Я – русский голос системы.
Moira               en_IE    # Hello, my name is Moira. I am an Irish-English voice.
Monica              es_ES    # Hola, me llamo Monica y soy una voz española.
Nora                nb_NO    # Hei, jeg heter Nora. Jeg er en norsk stemme.
Paulina             es_MX    # Hola, me llamo Paulina y soy una voz mexicana.
Samantha            en_US    # Hello, my name is Samantha. I am an American-English voice.
Sara                da_DK    # Hej, jeg hedder Sara. Jeg er en dansk stemme.
Satu                fi_FI    # Hei, minun nimeni on Satu. Olen suomalainen ääni.
Sin-ji              zh_HK    # 您好，我叫 Sin-ji。我講廣東話。
Tessa               en_ZA    # Hello, my name is Tessa. I am a South African-English voice.
Thomas              fr_FR    # Bonjour, je m’appelle Thomas. Je suis une voix française.
Ting-Ting           zh_CN    # 您好，我叫Ting-Ting。我讲中文普通话。
Veena               en_IN    # Hello, my name is Veena. I am an Indian-English voice.
Victoria            en_US    # Isn't it nice to have a computer that will talk to you?
Xander              nl_NL    # Hallo, mijn naam is Xander. Ik ben een Nederlandse stem.
Yelda               tr_TR    # Merhaba, benim adım Yelda. Ben Türkçe bir sesim.
Yuna                ko_KR    # 안녕하세요. 제 이름은 Yuna입니다. 저는 한국어 음성입니다.
Yuri                ru_RU    # Здравствуйте, меня зовут Yuri. Я – русский голос системы.
Zosia               pl_PL    # Witaj. Mam na imię Zosia, jestem głosem kobiecym dla języka polskiego.
Zuzana              cs_CZ    # Dobrý den, jmenuji se Zuzana. Jsem český hlas.
```
 
 
