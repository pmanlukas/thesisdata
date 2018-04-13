import pickle
import random
import json

#{k: d[k] for k in random.sample(d.keys(),25)}

#load the dict from the pickle file
specjsons = dict()

with open('obj/specs.pkl', 'rb') as handle:
    specjsons = pickle.load(handle)

keys = list(specjsons.keys())

#select 25 random keys

random_keys = random.sample(keys, 25)
print(random_keys)
#create new dict containing these values

with open('random_keys.json', 'w') as fp:
        json.dump(random_keys,fp)

veri_dict = dict((k, specjsons[k]) for k in random_keys)
print(veri_dict)
#create pickle object of this dict
with open('obj/'+ 'veridict' + '.pkl', 'wb') as f:
        pickle.dump(veri_dict, f, pickle.HIGHEST_PROTOCOL)


