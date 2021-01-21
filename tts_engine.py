import getopt
import json
import subprocess
import sys
import tempfile
import os

path = (os.getcwd() + "/configuration.json")
with open(path) as json_file1:
    # global configuration
    configuration = json.load(json_file1)


def speech_lang(text, lang, gender):
    speech(text, configuration["voice"][lang][gender])


def speech(text, voice):
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

        cmd = "{0} -o {1} {2} -eval '(voice_" + voice + ")'"

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
    lang = ''
    gender = ''
    voice = ''
    try:
        opts, args = getopt.getopt(argv, "vhl:g:x:t:", ["version", "lang=", "gender=", "voice=", "text="])
    except getopt.GetoptError:
        print('tts_engine.py  -l <lang> -g <gender> -t <text> -x <voice>')
        sys.exit(2)


    for opt, arg in opts:
        if opt == '-h':
            print('tts_engine.py  -l <lang> -g <gender> -t <text> -x <voice>')
            print('tts_engine.py  --lang <lang> --gender <gender> --text <text> --voice <voice>')
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
        elif opt in ("-x", "--voice"):
            voice = arg
        elif opt in ("-t", "--text"):
            text = arg

    if (lang == '' or gender == '') and (voice != '' and text != ''):
        speech(text, voice)

    elif lang != '' and text != '' and gender != '':
        speech_lang(text, lang, gender)

    else:
        # if (lang == '' or text == '' or gender == '') and voice == '':
        print('## Error, missing parameters')
        print('-l <lang> -g <gender> -t <text>  /OR/  -x <voice> -t <text>')
        print('--lang <lang> --gender <gender> --text <text>  /OR/  --voice <voice> --text <text>')
        sys.exit()

    print('Lang is ', lang)
    print('Gender is ', gender)
    print('Text is ', text)

    # speech(text, lang, gender)

if __name__ == "__main__":
    main(sys.argv[1:])
