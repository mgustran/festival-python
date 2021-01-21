# festival-python
Simple **python3** wrapper for Festival TTS Voice Synthentizer, 
with installer script for debian based distributions and optimized for catalan and spanish

Note: you can use it any linux system, 
but the installer script only work on debian based systems with **apt, dpkg** and **wget**, 
and festival on its repositories
#
#### Install Festival and voices
A ) `bash install.sh`

Other way if fails

B ) `sudo bash installer-script.sh` 


#
#### Usage
text `-t` `--text`

language `-l` `--lang`  (ca, es, en) more can be added

gender `-g` `--gender`  (male or female)

voice `-x` `--voice`  (select voice instead language and gender)

help `-h`

version `-v`  `--version` Print Festival and Python3 versions
#
#### Run examples
`python3 tts_engine.py -t 'Aixo es una prova' -l ca -g female`

`python3 tts_engine.py --text 'Esto es una prueba' --lang es --gender male`

`python3 tts_engine.py -t 'This is a test' -l en -g male`

or

`python3 tts_engine.py -t 'This is a test' -x cmu_us_slt_arctic_hts`
#
#### Supported voices and modifications
`catalan (male & female)` 

`spanish (male & female)`

`english (male & female)`

You can modify current voices, 
download more for current and other languages
simply installing them (usually are packaged in .deb),
or extracting its content in festival system folder.

Note: Italian voices don't work with my festival version