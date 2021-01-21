#!/bin/bash
# Tested on Debian 10 (Bunsenlabs Lithium), python3.7.6 and festival2.5.0
# Tested on Ubuntu 20.04, python3.8 and festival 2.5.0

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


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