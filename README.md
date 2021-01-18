# festival-python
Simple **python3** wrapper for Festival TTS Voice Synthentizer, with installer script for debian based distributions and optimized for catalan and spanish
#
#### Install Festival and voices
`sudo bash install-dependencies.sh`
#
#### Usage
text `-t` `--text`

language `-l` `--lang`  (ca, es, en) more can be added

gender `-g` `--gender`  (male or female)

help `-h`

version `-v`  `--version` Print Festival and Python3 versions
#
#### Run examples
`python3 tts_engine.py -t 'Aixo es una prova' -l ca -g female`

`python3 tts_engine.py -t 'Esto es una prueba' -l es -g male`

`python3 tts_engine.py -t 'This is a test' -l en -g male`
#
#### Supported voices and modifications
`catalan (male & female)` 

`spanish (male & female)`

`english (male)`

You can modify current voices, 
download more for current and other languages
simply modifying install-dependencies.sh