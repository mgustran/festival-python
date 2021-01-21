#!/bin/bash
# Tested on Debian 10 (Bunsenlabs Lithium), python3.7.6 and festival2.5.0
# Tested on Ubuntu 20.04, python3.8 and festival 2.5.0

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "source code path : $SCRIPTPATH"
mkdir "$SCRIPTPATH/z_packages"

# Install python3,  Festival TTS engine  and  Festival Catalan voice
apt-get -y install python3 festival festvox-ca-ona-hts festvox-us-slt-hts

# Useful Festival wiki (from arch but its the same) -> https://wiki.archlinux.org/index.php/Festival

# Download 3 more voices :    2 spanish from guadalinex repo     &  1 catalan voice from festcat repo
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


# You have to reference the voice you want to use in the configuration.json file


# Now Festival TTS has 7 voices available:     listable in festival console -> (voice.list)
#   Voice Id                                        Language        Gender
# kal_diphone    ...............................     english         male
# cmu_us_slt_arctic_hts    .....................     english         female
# upc_ca_ona_hts     ...........................     catalan         female         // Best option for catalan
# upc_ca_pau_hts     ...........................     catalan         male           // Best option for catalan
# el_diphone   .................................     spanish         male
# JuntaDeAndalucia_es_sf_diphone   .............     spanish         female
# JuntaDeAndalucia_es_pa_diphone  ..............     spanish         male           // Best option for spanish

# Some Downloadable
# upc_ca_pau_clunits  (1Gb).....................     catalan         male           // Slow performance, perfect quality
# upc_ca_pep_clunits  (100Mb)...................     catalan         male           // Medium performance, good quality
# upc_ca_jan_clunits  (100Mb)...................     catalan         male           // Good performance, good quality