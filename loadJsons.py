import pickle


import json
import requests


urls = json.load(open('urls.json'))
keys = urls.keys()
specFiles = {}


def save_obj(obj, name ):
    with open('obj/'+ name + '.pkl', 'wb') as f:
        pickle.dump(obj, f, pickle.HIGHEST_PROTOCOL)


for key in keys:
    url = urls[key]
    req = requests.get(url)
    specification = req.json()

    specFiles[key] = specification

save_obj(specFiles, 'specs')
print(specFiles.keys())
