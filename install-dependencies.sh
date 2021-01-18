#!/bin/bash
# Tested on Debian 10 (Bunsenlabs Lithium), python3.7.6 and festival2.5.0

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "source code path : $SCRIPTPATH"


mkdir "$SCRIPTPATH/z_packages"

# Install espeak (basic tts),  Festival TTS engine,  Festival Spanish and Catalan voices
apt-get -y install python3 festival festvox-ca-ona-hts festvox-ellpc11k

# Useful Festival wiki (from arch but its the same) -> https://wiki.archlinux.org/index.php/Festival

# Download 3 more voices :    2 spanish from guadalinex repo     &  1 catalan voice from upc repo
wget -O "$SCRIPTPATH/z_packages/festvox-ca-pau-hts_1.3-1_all.deb" 'http://festcat.talp.cat/download/festvox-ca-pau-hts_1.3-1_all.deb'
wget -O "$SCRIPTPATH/z_packages/festvox-sflpc16k_1.0-1_all.deb" 'https://github.com/guadalinex-archive/hispavoces/raw/master/packages/festvox-sflpc16k_1.0-1_all.deb'
wget -O "$SCRIPTPATH/z_packages/festvox-palpc16k_1.0-1_all.deb" 'https://github.com/guadalinex-archive/hispavoces/raw/master/packages/festvox-palpc16k_1.0-1_all.deb'

# Install manually 3 more voices
apt install -y "$SCRIPTPATH/z_packages/festvox-palpc16k_1.0-1_all.deb"
apt install -y "$SCRIPTPATH/z_packages/festvox-sflpc16k_1.0-1_all.deb"
apt install -y "$SCRIPTPATH/z_packages/festvox-ca-pau-hts_1.3-1_all.deb"

# You can install more voices if you want, usually festvox voices are available in .deb installers like:
# http://festcat.talp.cat/download.php                    (for catalan voices)
# https://github.com/guadalinex-archive/hispavoces        (for spanish voices, already installed manually)

# Now Festival TTS has 5 voices available:     listable in festival console -> (voice.list)
#   Voice Id                                        Language              Gender
# upc_ca_ona_hts     ...........................     catalan               female         // Best option for catalan
# upc_ca_pau_hts     ...........................     catalan               male           // Best option for catalan
# kal_diphone    ...............................     english               male
# JuntaDeAndalucia_es_sf_diphone   .............     spanish               female
# el_diphone   .................................     spanish               male
# JuntaDeAndalucia_es_pa_diphone  ..............     spanish               male           // Best option for spanish

# Some Downloadable
# upc_ca_pau_clunits  (1Gb).....................     catalan               male           // Slow performance, perfect quality
# upc_ca_pep_clunits  (100Mb)...................     catalan               male           // Medium performance, good quality
# upc_ca_jan_clunits  (100Mb)...................     catalan               male           // Good performance, good quality

mkdir -p /opt/tts-config
chmod 775 /opt/tts-config

# Festival config files, simply put: (voice_<voiceId>)
# If you pretend to download/install more voices, you have to modify appropriate cfg_*_*.txt with new voice
printf "(voice_upc_ca_pau_hts)" > /opt/tts-config/cfg_ca_male.txt
printf "(voice_upc_ca_ona_hts)" > /opt/tts-config/cfg_ca_female.txt
printf "(voice_JuntaDeAndalucia_es_sf_diphone)" > /opt/tts-config/cfg_es_female.txt
printf "(voice_JuntaDeAndalucia_es_pa_diphone)" > /opt/tts-config/cfg_es_male.txt
printf "(voice_kal_diphone)" > /opt/tts-config/cfg_en_male.txt