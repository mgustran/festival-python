#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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