import requests as req
import json
import csv
import pickle
url = 'https://api.apis.guru/v2/list.json'


def get_json(url):
    request = req.get(url)
    if request.status_code == 200:
        json = request.json()
    else:
        return 0
    return json
#all entries from the apiguru database
parsed_res = get_json(url)

#storing the entries for later usage
with open('obj/'+ 'parsed_res' + '.pkl', 'wb') as f:
        pickle.dump(parsed_res, f, pickle.HIGHEST_PROTOCOL)

#save all responses as a json locally
with open('gurumeta.json', 'w') as fp:
        json.dump(parsed_res,fp)

print(parsed_res.keys())
print(parsed_res['1forge.com']['versions']['0.0.1']['swaggerUrl'])


def urlto_dict(dicts):
    keys = dicts.keys()
    swagger_urls = {}
    for key in keys:
        entry = dicts[key]
        version = entry['preferred']
        url_entry = entry['versions'][version]['swaggerUrl']
        swagger_urls[key] = url_entry

    print(swagger_urls)
    return swagger_urls


def to_csv(dicts):
    with open('urls.csv', 'w', newline='') as f:
        fieldnames = ['API', 'Swagger URL']
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        data = [dict(zip(fieldnames, [k,v])) for k, v in dicts.items()]
        writer.writerows(data)
    return True


def to_json(dicts):
    with open('urls.json', 'w') as fp:
        json.dump(dicts,fp)

swaggerurls = urlto_dict(parsed_res)
to_json(swaggerurls)

