#!/bin/bash
# Tested on Debian 10 (Bunsenlabs Lithium), python3.7.6 and festival2.5.0
# Tested on Ubuntu 20.04, python3.8 and festival 2.5.0

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


echo "source code path : $SCRIPTPATH"
mkdir -p "$SCRIPTPATH/z_packages"

# Download 3 more voices :    2 spanish from guadalinex repo     &  1 catalan voice from festcat repo
wget -O "$SCRIPTPATH/z_packages/festvox-ca-pau-hts_1.3-1_all.deb" 'http://festcat.talp.cat/download/festvox-ca-pau-hts_1.3-1_all.deb'
wget -O "$SCRIPTPATH/z_packages/festvox-sflpc16k_1.0-1_all.deb" 'https://github.com/guadalinex-archive/hispavoces/raw/master/packages/festvox-sflpc16k_1.0-1_all.deb'
wget -O "$SCRIPTPATH/z_packages/festvox-palpc16k_1.0-1_all.deb" 'https://github.com/guadalinex-archive/hispavoces/raw/master/packages/festvox-palpc16k_1.0-1_all.deb'

chmod +x "$SCRIPTPATH/installer-script.sh"
pkexec "$SCRIPTPATH/installer-script.sh"

echo '{
  "voice": {
    "ca": {
      "male": "upc_ca_pau_hts",
      "female": "upc_ca_ona_hts"
    },
    "es": {
      "male": "JuntaDeAndalucia_es_pa_diphone",
      "female": "JuntaDeAndalucia_es_sf_diphone"
    },
    "en": {
      "male": "kal_diphone",
      "female": "cmu_us_slt_arctic_hts"
    }
  }
}' > "$SCRIPTPATH/configuration.json"