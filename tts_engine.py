import getopt
import json
import subprocess
import sys
import tempfile
import os


def speech(text):
    iconv = '/usr/bin/iconv'
    txt2wave = '/usr/bin/text2wave'

    with tempfile.NamedTemporaryFile() as text_file, \
            tempfile.NamedTemporaryFile() as encoded_file, \
            tempfile.NamedTemporaryFile() as wave_file:
        f = open(text_file.name, 'w', encoding='utf8')
        f.write(text)
        f.close()

        cmd = '{0} -f utf8 -t ISO-8859-15//TRANSLIT {1} > {2}'. \
            format(iconv, text_file.name, encoded_file.name)
        p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        p.wait()

        cmd = "{0} -o {1} {2} -eval /opt/tts-config/cfg_" + configuration["voice"]["lang"] \
              + "_" + configuration["voice"]["gender"] + ".txt"

        cmd = cmd.format(txt2wave, wave_file.name, encoded_file.name)

        p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        p.wait()

        os.system("aplay %s" % wave_file.name)
        return


def main(argv):
    with open('configuration.json') as json_file:
        global configuration
        configuration = json.load(json_file)

    text = ''
    lang = configuration["voice"]["lang"]
    gender = configuration["voice"]["gender"]
    try:
        opts, args = getopt.getopt(argv, "vhl:g:t:", ["version", "lang=", "gender=", "text="])
    except getopt.GetoptError:
        print('tts_engine.py  -l <lang> -g <gender> -t <text>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('tts_engine.py  -l <lang> -g <gender> -t <text>')
            print('tts_engine.py  --lang <lang> --gender <gender> --text <text>')
            sys.exit()
        elif opt in ("-v", "--version"):
            print("  ****  festival-python: 1.0  ****")
            os.system("festival --version")
            os.system("python3 --version")
            sys.exit()
        elif opt in ("-l", "--lang"):
            lang = arg
        elif opt in ("-g", "--gender"):
            gender = arg
        elif opt in ("-t", "--text"):
            text = arg
    print('Lang is ', lang)
    print('Gender is ', gender)
    print('Text is ', text)

    configuration["voice"]["lang"] = lang
    configuration["voice"]["gender"] = gender
    speech(text)

if __name__ == "__main__":
    main(sys.argv[1:])
