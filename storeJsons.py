import pickle
import pymongo
from bson.json_util import loads

uri = "mongodb://lpopenapi:naNTjnGUE34EhtnOWkCvpKpGIXC2gj1xxAEZTEMRriIdvbEGd3l8S6bkCIV7lHygmSLjjfQaaHxkbY932EI93Q==@lpopenapi.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
client = pymongo.MongoClient(uri)

db = client['openapi']
collection = db['specs']

#data = loads(req.text)
#spec_id = collection.insert_one(specification).inserted_id
#print("Inserted " + str(specification) + " with id " + str(spec_id))

#jsons = dict()

#with open('obj/specs.pkl', 'rb') as handle:
#    jsons = pickle.load(handle)

#keys = list(jsons.keys())

#print(keys[2])

#print(jsons[keys[2]])
#keysDB = {}
#i = 0
#for key in keys:
#    data_jsons = jsons[keys[i]]
#    i +=1
#    idjson = collection.insert(data_jsons, check_keys=False)
#    keysDB[key] = idjson
#print(keysDB.keys())
print(collection.count())
